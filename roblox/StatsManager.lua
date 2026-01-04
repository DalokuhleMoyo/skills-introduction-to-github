-- Server-side stats manager for Roblox
-- Place this Script in ServerScriptService (name it StatsManager)

local Players = game:GetService("Players")

local DEFAULT_HEALTH = 100
local DEFAULT_STRENGTH = 10
local DEFAULT_SPEED = 16  -- Roblox default WalkSpeed

local function applyStatsToCharacter(player, character)
    local humanoid = character:WaitForChild("Humanoid")
    local statsFolder = player:WaitForChild("Stats")

    local health = statsFolder:FindFirstChild("Health")
    local strength = statsFolder:FindFirstChild("Strength")
    local speed = statsFolder:FindFirstChild("Speed")

    -- Health
    if health then
        humanoid.MaxHealth = health.Value
        humanoid.Health = health.Value
    end

    -- Speed
    if speed then
        humanoid.WalkSpeed = speed.Value
    end

    -- Strength is used for combat/abilities and is read from player.Stats.Strength.Value
end

local function createStats(player)
    local statsFolder = Instance.new("Folder")
    statsFolder.Name = "Stats"
    statsFolder.Parent = player

    local health = Instance.new("IntValue")
    health.Name = "Health"
    health.Value = DEFAULT_HEALTH
    health.Parent = statsFolder

    local strength = Instance.new("IntValue")
    strength.Name = "Strength"
    strength.Value = DEFAULT_STRENGTH
    strength.Parent = statsFolder

    local speed = Instance.new("IntValue")
    speed.Name = "Speed"
    speed.Value = DEFAULT_SPEED
    speed.Parent = statsFolder

    -- Keep character in sync when these values change
    health.Changed:Connect(function(newValue)
        local character = player.Character
        if character and character:FindFirstChild("Humanoid") then
            local humanoid = character.Humanoid
            humanoid.MaxHealth = newValue
            if humanoid.Health > newValue then
                humanoid.Health = newValue
            end
        end
    end)

    speed.Changed:Connect(function(newValue)
        local character = player.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.WalkSpeed = newValue
        end
    end)

    -- Apply stats to current/next character spawns
    player.CharacterAdded:Connect(function(character)
        applyStatsToCharacter(player, character)
    end)

    if player.Character then
        applyStatsToCharacter(player, player.Character)
    end
end

Players.PlayerAdded:Connect(createStats)