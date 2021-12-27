local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)

local ArenaService = Knit.CreateService {
    Name = "ArenaService",
    Client = {}
}

ArenaService.BlueScore = 0
ArenaService.RedSCore = 0

function ArenaService:StartGame()
    
end

function ArenaService:KnitStart()
    
end

function ArenaService:KnitInit()

end

return ArenaService