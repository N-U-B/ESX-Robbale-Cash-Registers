ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

function Message(Chat, Player)
	TriggerClientEvent('esx:showNotification', Player.source, Chat)
end

RegisterServerEvent('RobRegister')
AddEventHandler('RobRegister', function()
   local _source = source 
   local xPlayer = ESX.GetPlayerFromId(_source)
 local amount = math.random(300, 850)
 local timer = math.random (13000, 20000)
 --local bobbypin = math.random(1,1000)
 --if bobbypin < 500 then 
  if xPlayer.getInventoryItem('advancedlockpick').count > 0 then
Message('Robbing Register!', xPlayer)
 Citizen.Wait(timer)
 xPlayer.addInventoryItem('money', amount)
Message('You must wait 5 minutes before you can rob this again', xPlayer)
   else 
      Message('You don\'t have any lockpicks available', xPlayer)
   end     
end)
