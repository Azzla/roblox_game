local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)

Knit.AddServices(ServerStorage.src.Services)

Knit.Start():andThen(function()
    print("Knit started server")
end):catch(warn)