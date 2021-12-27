local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)
local Trove = require(ReplicatedStorage.Packages.Trove)

local Goal = {}
Goal.__index = Goal

function Goal.new(instance)
    local self = setmetatable({}, Goal)
    self._trove = Trove.new()
    return self
end

function Goal:Destroy()
    self._trove:Destroy()
end

return Goal