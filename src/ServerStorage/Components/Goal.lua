local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Component = require(ReplicatedStorage.Packages.Component)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Knit = require(ReplicatedStorage.Packages.Knit)
local CollectionService = game:GetService("CollectionService")

local Goal = Component.new({
    Tag = "Goal"
})

function Goal:Construct()
    self._trove = Trove.new()
end

function Goal:Start()
    local teamName = self.Instance.Parent.Name
    self:_observeScore(teamName)
    self:_setupScoring(teamName)
end

function Goal:_observeScore(teamName)
    local arena = Knit.GetService("ArenaService"):GetArena()
    local function ScoreChanged(score)
        self.Instance.Top.BillboardGui.TextLabel.Text = tostring(score)
    end
    self._trove:Add(arena:ObserveScore(teamName, ScoreChanged))
end

function Goal:_setupScoring(teamName)
    self.Instance.Sensor.Touched:Connect(function(part)
        if CollectionService:HasTag(part, "Ball") then
            part:Destroy()
            local arena = Knit.GetService("ArenaService"):GetArena()
            arena:IncrementScore(teamName)
        end
    end)
end

function Goal:Stop()
    self._trove:Destroy()
end

return Goal