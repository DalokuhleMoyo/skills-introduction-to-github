-- Strength trainer pad script
-- Place this Script inside a Part in Workspace (e.g. Workspace.StrengthTrainer)

local part = script.Parent
local STRENGTH_GAIN = 1
local COOLDOWN = 1  -- seconds

local debounce = {}

local function onTouched(hit)
    local character = hit.Parent
    if not character then
        return
    end

    local player = game.Players:GetPlayerFromCharacter(character)
    if not player then
        return
    end

    if debounce[player] then
        return
    end
    debounce[player] = true

    local stats = player:FindFirstChild("Stats")
    if not stats then
        debounce[player] = nil
        return
    end

    local strength = stats:FindFirstChild("Strength")
    if not strength then
        debounce[player] = nil
        return
    end

    strength.Value += STRENGTH_GAIN
    print(player.Name .. " trained strength to " .. strength.Value)

    task.wait(COOLDOWN)
    debounce[player] = nil
end

part.Touched:Connect(onTouched)