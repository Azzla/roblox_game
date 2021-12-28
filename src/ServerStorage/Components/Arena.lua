local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Component = require(ReplicatedStorage.Packages.Component)
local Trove = require(ReplicatedStorage.Packages.Trove)


local BALL_PREFAB = game:GetService("ServerStorage").Assets.Ball


local Arena = Component.new({
    Tag = "Arena"
})

function Arena:Construct()
    print("Arena created")
    self._trove = Trove.new()
end

function Arena:GetScore(teamName)
    return self.Instance:GetAttribute(teamName .. "Score")
end

function Arena:SetScore(teamName, score)
    return self.Instance:SetAttribute(teamName .. "Score", score)
end

function Arena:IncrementScore(teamName)
    
end

function Arena:ObserveScore(teamName, handler)
    local attrName = teamName .. "Score"
    handler(self.Instance:GetAttribute(attrName))
    local connection = self.Instance:GetAttributeChangedSignal(attrName):Connect(function()
        handler(self.Instance:GetAttribute(attrName))
    end)
    self._trove:Add(connection)
    return connection
end

function Arena:Stop()
    self._trove:Destroy()
end

function Arena:Start()
    self:_spawnBall()
end

function Arena:_spawnBall()
    local ball = BALL_PREFAB:Clone()
    ball.CFrame = self.Instance.Base.BallSpawn.WorldCFrame
    ball.Parent = self.Instance
    self._trove:Add(ball)
end

return Arena