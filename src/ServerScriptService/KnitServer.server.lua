local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)
local Loader = require(ReplicatedStorage.Packages.Loader)

Knit.AddServices(ServerStorage.src.Services)

Knit.Start():andThen(function()
    print("Knit started server")
    Loader.LoadChildren(ServerStorage.src.Components)
end):catch(warn)