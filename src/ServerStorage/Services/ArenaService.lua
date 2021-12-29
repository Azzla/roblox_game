local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")
local Knit = require(ReplicatedStorage.Packages.Knit)
local Component = require(ReplicatedStorage.Packages.Component)

local ArenaService = Knit.CreateService {
    Name = "ArenaService",
    Client = {
        Throw = Knit.CreateSignal()
    },
    RunSpeed = 32,
    BallRunSpeed = 22
}

function ArenaService:GetArena()
    local ArenaComp = require(ServerStorage.src.Components.Arena)
    return Component.FromInstance(workspace.Arena, ArenaComp)
end

function ArenaService:_startGame()
    local arena = self:GetArena()
    arena:SetScore("Red", 0)
    arena:SetScore("Blue", 0)
end

function ArenaService:KnitStart()
    Knit.OnComponentsLoaded():await()
    self:_startGame()
end

function ArenaService:KnitInit()
    local function PlayerAdded(player)
        local function CharacterAdded(character)
            local humanoid = character:WaitForChild("Humanoid", 30)
            if not humanoid then return end
            humanoid.WalkSpeed = self.RunSpeed
        end
        CharacterAdded(player.Character or player.CharacterAdded:Wait())
        player.CharacterAdded:Connect(CharacterAdded)
    end
    Players.PlayerAdded:Connect(PlayerAdded)
    for _,player in ipairs(Players:GetPlayers()) do
        task.spawn(PlayerAdded, player)
    end
end

return ArenaService