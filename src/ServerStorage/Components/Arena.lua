local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)
local Component = require(ReplicatedStorage.Packages.Component)
local Trove = require(ReplicatedStorage.Packages.Trove)
-- local Signal = require(Knit.Util.Signal)
local Promise = require(Knit.Util.Promise)

local BALL_PREFAB = game:GetService("ServerStorage").Assets.Ball
local RESPAWN_BALL_TIME = 1

local Arena = Component.new({
    Tag = "Arena"
})

function Arena:Construct()
    self._trove = Trove.new()
    -- self._respawn = Signal.new(self._trove)
end

function Arena:GetScore(teamName)
    return self.Instance:GetAttribute(teamName .. "Score")
end

function Arena:SetScore(teamName, score)
    return self.Instance:SetAttribute(teamName .. "Score", score)
end

function Arena:IncrementScore(teamName)
    return self.Instance:SetAttribute(teamName .. "Score", self:GetScore(teamName) + 1)
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
    self._trove:Add(ball:GetPropertyChangedSignal("Parent"):Connect(function()
        if not ball.Parent then
            self._trove:GivePromise(Promise.delay(RESPAWN_BALL_TIME)):andThen(function()
                self:_spawnBall()
            end)
        end
    end))
end

return Arena