-- Sword tool script using Strength for damage
-- Place this Script inside a Tool in StarterPack (e.g. StarterPack.Sword)
-- Make sure the Tool has a Part named "Handle"

local tool = script.Parent
local DAMAGE_BASE = 10

local function onHit(hit, attacker)
    local victimHumanoid = hit.Parent and hit.Parent:FindFirstChild("Humanoid")
    if not victimHumanoid then
        return
    end

    local attackerPlayer = game.Players:GetPlayerFromCharacter(attacker)
    if not attackerPlayer then
        return
    end

    local stats = attackerPlayer:FindFirstChild("Stats")
    if not stats then
        return
    end

    local strength = stats:FindFirstChild("Strength")
    local damage = DAMAGE_BASE

    if strength then
        damage = DAMAGE_BASE + strength.Value
    end

    victimHumanoid:TakeDamage(damage)
end

tool.Activated:Connect(function()
    local character = tool.Parent
    local handle = tool:FindFirstChild("Handle")
    if not handle or not character then
        return
    end

    local connection
    connection = handle.Touched:Connect(function(hit)
        onHit(hit, character)
        if connection then
            connection:Disconnect()
        end
    end)

    -- Short attack window
    task.delay(0.3, function()
        if connection then
            connection:Disconnect()
        end
    end)
end)