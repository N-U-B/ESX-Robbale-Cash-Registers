ESX = nil
local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
   }

Citizen.CreateThread(function()

 while ESX == nil do
 TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
 Citizen.Wait(0)



PlayerData = ESX.GetPlayerData()
end
end)

Citizen.CreateThread(function() --cash register steal function 
    local sleep = 500
    while true do
       Citizen.Wait(sleep)
       for k,v in ipairs(Config.Marker)do   
       local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
          local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.x, v.y, v.z)
          if IsControlPressed(0, Keys['LEFTALT']) then
           -- for k,v in ipairs(Config.DrawDistance)do
            if dist <= 3 then
            sleep = 0 
                  if dist <= 2 then
                  Draw3DText(v.x, v.y, v.z-0.7, "~y~Cash Register ~w~ Press ~g~E~w~ To ~r~ Rob Cash Register", 0.4)
                if IsControlJustPressed(0, Keys['E']) then 
                    IsRobbingRegister = false
                    TriggerServerEvent('RobRegister')
                TriggerEvent('RobberyAnimation')
                Citizen.Wait(15000)
                IsRobbingRegister = false
                Citizen.Wait(500000)
            --  end
            end
      end
    end
  end 
  end
end
end)
function Draw3DText(x, y, z, text, scale)
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

RegisterNetEvent('RobberyAnimation')
  AddEventHandler('RobberyAnimation', function()
      IsRobbingRegister = false 
      IsRobbingRegister = true
      loadAnimDict('oddjobs@shop_robbery@rob_till')
      controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = true,
          disableCombat = true,
      }
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
     
     function loadAnimDict(dict)
      RequestAnimDict(dict)
      while not HasAnimDictLoaded(dict) do
       Citizen.Wait(5)
      end
     end
