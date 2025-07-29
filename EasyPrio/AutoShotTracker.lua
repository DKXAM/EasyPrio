-- AutoShotTracker: Standalone auto shot timing module for EasyPrio
-- Extracted and adapted from Quiver addon
-- Only loads for Hunter class to prevent auto shot clipping

AutoShotTracker = {}

-- Only initialize for hunters
local _, playerClass = UnitClass("player")
if playerClass ~= "HUNTER" then
    return
end

-- Constants
local AIMING_TIME = 0.5 -- Time for auto shot aiming phase
local CAST_THRESHOLD = 0.25 -- Threshold for detecting cast vs auto shot timing

-- State variables
local isReloading = false
local isShooting = false
local isCasting = false
local castTime = 0
local timeStartCastLocal = 0

-- Position tracking for movement detection
local position = (function()
    local x, y = 0, 0
    local updateXY = function() x, y = GetPlayerMapPosition("player") end
    return {
        UpdateXY = updateXY,
        CheckStandingStill = function()
            local lastX, lastY = x, y
            updateXY()
            return x == lastX and y == lastY
        end,
    }
end)()

-- Reload timer
local timeReload = (function()
    local reloadTime = 0
    local time = GetTime()
    local getElapsed = function() return GetTime() - time end
    return {
        GetPercentCompleted = function()
            local elapsed = getElapsed()
            if elapsed <= reloadTime then
                return elapsed / reloadTime
            else
                return 1.0
            end
        end,
        GetRemaining = function() return reloadTime - getElapsed() end,
        Reset = function() time = GetTime() end,
        StartAt = function(t)
            time = t
            local speed, _, _, _, _, _ = UnitRangedDamage("player")
            isReloading = true
            reloadTime = speed - AIMING_TIME
        end,
    }
end)()

-- Shooting timer
local timeShoot = (function()
    local time = GetTime()
    local getElapsed = function() return GetTime() - time end
    return {
        GetPercentCompleted = function()
            local elapsed = getElapsed()
            if elapsed <= AIMING_TIME then
                return elapsed / AIMING_TIME
            else
                return 1.0
            end
        end,
        GetRemaining = function() return AIMING_TIME - getElapsed() end,
        Reset = function() time = GetTime() end,
    }
end)()

-- State machine for auto shot detection
local stateAuto = { IsInitial = true, TimeLock = 0 }
local isFiredInstant = false

-- Start shooting helper
local function startShooting()
    if not isReloading then timeShoot.Reset() end
    isShooting = true
    position.UpdateXY()
end

-- Event handlers
local function handleEventStateCasting(event, arg1)
    if event == "SPELLCAST_DELAYED" then
        castTime = castTime + arg1 / 1000
    elseif event == "SPELLCAST_STOP" or event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED" then
        isFiredInstant = false
        isCasting = false
        if not isReloading then timeShoot.Reset() end
    elseif event == "ITEM_LOCK_CHANGED" then
        local elapsed = GetTime() - timeStartCastLocal
        if elapsed < CAST_THRESHOLD then
            -- Auto shot fired as cast started
            timeReload.StartAt(GetTime())
        end
    end
end

local function handleEventStateShooting(event)
    if event == "SPELLCAST_STOP" then
        timeShoot.Reset()
    end

    if stateAuto.IsInitial then
        if event == "ITEM_LOCK_CHANGED" then
            if isFiredInstant then
                stateAuto.IsInitial = false
                stateAuto.TimeLock = GetTime()
                isFiredInstant = false
            elseif timeReload.GetRemaining() > 0 then
                -- Out-of-order events, probably multi-shot
            else
                -- Auto shot fired
                timeReload.StartAt(GetTime())
            end
        end
    else
        if event == "ITEM_LOCK_CHANGED" then
            -- Auto -> Instant sequence
            stateAuto.IsInitial = true
            isFiredInstant = false
            timeReload.StartAt(stateAuto.TimeLock)
        elseif event == "SPELLCAST_STOP" then
            -- Instant shot completed
            stateAuto.IsInitial = true
            isFiredInstant = false
        end
    end
end

local function handleEventStateIdle(event)
    if event == "SPELLCAST_STOP" or event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED" then
        if isFiredInstant then
            -- Processed instant shot
        end
        isFiredInstant = false
    end
end

-- Main event handler
local function handleEvent()
    local e = event
    
    if e == "START_AUTOREPEAT_SPELL" then
        startShooting()
    elseif e == "STOP_AUTOREPEAT_SPELL" then
        isShooting = false
    elseif isCasting then
        handleEventStateCasting(e, arg1)
    elseif isShooting then
        handleEventStateShooting(e)
    else
        handleEventStateIdle(e)
    end
end

-- Update function to handle reload completion
local function handleUpdate()
    if isReloading then
        local percentCompleted = timeReload.GetPercentCompleted()
        if percentCompleted >= 1.0 then
            isReloading = false
            if isShooting then
                startShooting()
            end
        end
    end
end

-- Spell casting detection
local function onSpellcast(spellName)
    if not isCasting then
        isCasting = true
        -- Simple cast time estimation for common hunter shots
        if spellName == "Aimed Shot" then
            castTime = 3.0
        elseif spellName == "Multi-Shot" then
            castTime = 0.5
        elseif spellName == "Steady Shot" then
            castTime = 1.5
        else
            castTime = 1.5 -- Default
        end
        timeStartCastLocal = GetTime()
    end
end

-- API Functions for EasyPrio integration
function AutoShotTracker.GetSecondsRemainingReload()
    if isReloading then
        return true, timeReload.GetRemaining()
    else
        return false, 0
    end
end

function AutoShotTracker.GetSecondsRemainingShoot()
    local t = timeShoot.GetRemaining()
    local isFiring = isShooting and not isReloading
    if isFiring then
        return true, t
    else
        return false, 0
    end
end

function AutoShotTracker.PredMidShot()
    return isShooting and not isReloading
end

function AutoShotTracker.IsReadyToCast(castTime)
    -- Don't cast if we're mid auto shot (would clip)
    if AutoShotTracker.PredMidShot() then
        return false
    end
    
    -- Check if we're reloading - this is the safe window to cast
    local isReloadingNow, reloadTimeLeft = AutoShotTracker.GetSecondsRemainingReload()
    if isReloadingNow then
        -- Make sure we have enough time to complete the cast
        return reloadTimeLeft >= (castTime or 1.5)
    end
    
    -- If not reloading and not shooting, we're safe to cast
    return true
end

-- Frame for event handling
local frame = CreateFrame("Frame", "AutoShotTrackerFrame")
frame:RegisterEvent("ITEM_LOCK_CHANGED")
frame:RegisterEvent("SPELLCAST_DELAYED")
frame:RegisterEvent("SPELLCAST_FAILED")
frame:RegisterEvent("SPELLCAST_INTERRUPTED")
frame:RegisterEvent("SPELLCAST_STOP")
frame:RegisterEvent("START_AUTOREPEAT_SPELL")
frame:RegisterEvent("STOP_AUTOREPEAT_SPELL")

frame:SetScript("OnEvent", handleEvent)
frame:SetScript("OnUpdate", handleUpdate)

-- Hook into spell casting for timing detection
local originalCastSpell = CastSpell
CastSpell = function(spellId, bookType)
    local spellName = GetSpellName(spellId, bookType)
    if spellName then
        onSpellcast(spellName)
        isFiredInstant = true -- Mark that we fired an instant shot
    end
    return originalCastSpell(spellId, bookType)
end

-- Hook into spell casting by name
local originalCastSpellByName = CastSpellByName
CastSpellByName = function(spellName, onSelf)
    if spellName then
        onSpellcast(spellName)
        isFiredInstant = true -- Mark that we fired an instant shot
    end
    return originalCastSpellByName(spellName, onSelf)
end