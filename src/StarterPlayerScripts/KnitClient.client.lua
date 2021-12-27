local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)

Knit.AddControllers(ReplicatedStorage.src.Controllers)

Knit.Start():andThen(function()
    print("Knit started client")
end):catch(warn)