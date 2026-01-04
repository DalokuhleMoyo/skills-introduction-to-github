-- Speed boost pad script
-- Place this Script inside a Part in Workspace (e.g. Workspace.SpeedPad)

local part = script.Parent
local SPEED_BOOST = 32      -- boosted WalkSpeed
local BOOST_DURATION = 5    -- seconds

local activeBoosts = {}

local function onTouched(hit)
    local character = hit.Parent
    if not character then
        return
    end

    local player = game.Players:GetPlayerFromCharacter(character)
    if not player then
        return
    end

    local stats = player:FindFirstChild("Stats")
    if not stats then
        return
    end

    local speed = stats:FindFirstChild("Speed")
    if not speed then
        return
    end

    if activeBoosts[player] then
        -- Already boosted, refresh duration instead
        activeBoosts[player].expiresAt = tick() + BOOST_DURATION
        return
    end

    local oldSpeed = speed.Value
    speed.Value = SPEED_BOOST

    activeBoosts[player] = {
        oldSpeed = oldSpeed,
        expiresAt = tick() + BOOST_DURATION,
    }

    task.spawn(function()
        while activeBoosts[player] and tick() < activeBoosts[player].expiresAt do
            task.wait(0.2)
        end

        if activeBoosts[player] then
            speed.Value = activeBoosts[player].oldSpeed
            activeBoosts[player] = nil
            print(player.Name .. "'s speed boost ended.")
        end
    end)
end

part.Touched:Connect(onTouched)