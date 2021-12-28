local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)
local Loader = require(ReplicatedStorage.Packages.Loader)
local Promise = require(Knit.Util.Promise)

Knit.ComponentsLoaded = false
function Knit.OnComponentsLoaded()
    if Knit.ComponentsLoaded then
        return Promise.Resolve()
    end
    return Promise.new(function(resolve)
        local heartbeat
        heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
            if Knit.ComponentsLoaded then
                heartbeat:Disconnect()
                resolve()
            end
        end)
    end)
end

Knit.AddServices(ServerStorage.src.Services)

Knit.Start():andThen(function()
    print("Knit started server")
    Loader.LoadChildren(ServerStorage.src.Components)
    Knit.ComponentsLoaded = true
end):catch(warn)