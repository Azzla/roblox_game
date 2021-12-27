local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Component = require(ReplicatedStorage.Packages.Component)
local Trove = require(ReplicatedStorage.Packages.Trove)

local Goal = Component.new({
    Tag = "Goal"
})

function Goal:Construct()
    print("Goal created")
    self._trove = Trove.new()
    self._trove:Add(function()
        print("Goal destroyed")
    end)
end

function Goal:Destroy()
    self._trove:Destroy()
end

return Goal