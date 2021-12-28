local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)
local Component = require(ReplicatedStorage.Packages.Component)

local ArenaService = Knit.CreateService {
    Name = "ArenaService",
    Client = {}
}

function ArenaService:GetArena()
    local ArenaComp = require(ServerStorage.src.Components.Arena)
    return Component.FromInstance(workspace.Arena, ArenaComp)
end

function ArenaService:_startGame()
    local arena = self:GetArena()
    arena:SetScore(0)
end

function ArenaService:KnitStart()
    Knit.OnComponentsLoaded():await()
    self:_startGame()
end

function ArenaService:KnitInit()

end

return ArenaService