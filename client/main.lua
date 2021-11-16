local IsRobbingRegister = false

Citizen.CreateThread(function() --cash register steal function 
local sleep = 500
    while true do
        Citizen.Wait(sleep)
        for k,v in ipairs(Config.Marker)do   
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.x, v.y, v.z)
            if dist <= 3 then
                sleep = 0 
                if IsControlPressed(0, 19) then
                    Draw3DText(v.x, v.y, v.z-0.7, "~y~Cash Register ~w~ Press ~g~E~w~ To ~r~ Rob Cash Register", 0.4)
                    if IsControlJustPressed(0, 38) then 
                        TriggerServerEvent('RobRegister')
                        TriggerEvent('RobberyAnimation')
                        Citizen.Wait(15000)
                        IsRobbingRegister = false
                    end
                end
            end 
        end
    end
end)

function Draw3DText(x, y, z, text, scale) -- draws 3DText function
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoord())
    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(true)
    SetTextColour(255, 255, 255, 215)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 700
    DrawRect(_x, _y + 0.0150, 0.10 + factor, 0.03, 41, 11, 41, 100)
end

AddEventHandler('RobberyAnimation', function()
IsRobbingRegister = true
loadAnimDict('oddjobs@shop_robbery@rob_till')
    while IsRobbingRegister do
        if not IsEntityPlayingAnim(PlayerPedId(), "oddjobs@shop_robbery@rob_till", "enter", 3) then
            TaskPlayAnim(PlayerPedId(), "oddjobs@shop_robbery@rob_till", "enter", 0.5, 0.5, 2.0, 2, 2.0, 0, 0, 0)
            Citizen.Wait(3000)
            ClearPedTasks(PlayerPedId())
        end
        Citizen.Wait(1)
    end
ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent("StopRobberyAnimation", function()
    IsRobbingRegister = false 
    ClearPedTasks(PlayerPedId())
end)
     
function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(5)
    end
end
