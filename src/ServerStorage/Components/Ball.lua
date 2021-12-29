local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Component = require(ReplicatedStorage.Packages.Component)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Knit = require(ReplicatedStorage.Packages.Knit)

local Ball = Component.new({
    Tag = "Ball"
})

function Ball:Construct()
    self._trove = Trove.new()
end

function Ball:_listenForTouches()
    local playerTrove = Trove.new()

    local function GetPlayerFromPart(part)
        return Players:GetPlayerFromCharacter(part.Parent)
    end

    local function DetachFromPlayer()
        playerTrove:Clean()
    end

    local function CreateHold(player)
        local att = Instance.new("Attachment")
        att.Position = Vector3.new(0, 0.5, -2)
        att.Parent = player.Character.UpperTorso
        local alignPos = Instance.new("AlignPosition")
        alignPos.RigidityEnabled = true
        alignPos.Attachment0 = self.Instance.Attachment
        alignPos.Attachment1 = att
        alignPos.Parent = self.Instance
        local alignOrien = Instance.new("AlignOrientation")
        alignOrien.RigidityEnabled = true
        alignOrien.Attachment0 = self.Instance.Attachment
        alignOrien.Attachment1 = att
        alignOrien.Parent = self.Instance
        playerTrove:Add(att)
        playerTrove:Add(alignPos)
        playerTrove:Add(alignOrien)
    end

    local function AttachToPlayer(player, humanoid)
        self.Instance:SetAttribute("PlayerId", player.UserId)
        playerTrove:Add(function()
            self.Instance:SetAttribute("PlayerId", 0)
            humanoid.WalkSpeed = Knit.GetService("ArenaService").RunSpeed
        end)
        playerTrove:Add(Players.PlayerRemoving:Connect(function(plr)
            if plr == player then
                DetachFromPlayer()
            end
        end))
        CreateHold(player)
        humanoid.WalkSpeed = Knit.GetService("ArenaService").BallRunSpeed
    end

    self._trove:Add(self.Instance.Touched:Connect(function(part)
        if self.Instance:GetAttribute("PlayerId") ~= 0 then return end
        local player = GetPlayerFromPart(part)
        if not player then return end
        AttachToPlayer(player, part.Parent.Humanoid)
    end))
end

function Ball:Start()
    self:_listenForTouches()
end


function Ball:Stop()
    self._trove:Destroy()
end

return Ball