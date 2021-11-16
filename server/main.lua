LastRobbery = {}

if Config.usingOldESX then 
   ESX = nil
   TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

if not Config.QBUS then
   function Message(Chat, Player) TriggerClientEvent('esx:showNotification', Player, Chat) end
   RegisterServerEvent('RobRegister', function()
      local src = source 
      local xPlayer = ESX.GetPlayerFromId(src)
      local amount = math.random(300, 850)
      local timer = math.random (13000, 20000)
      local timeNow = os.clock()
      if xPlayer.getInventoryItem('advancedlockpick').count > 0 then
         if not LastRobbery[source] or timeNow - LastRobbery[source] > 600 then -- 600 seconds robbery cooldown for player on server side
            LastRobbery[source] = timeNow
   			math.randomseed(os.time())
            Message('Robbing Register!', src)

            Wait(timer)

            if Config.usingMoneyItem then 
               xPlayer.addInventoryItem('money', amount)
            else
               xPlayer.addMoney(amount)
            end
         
            if Config.findWeapons then
               local RandomString = math.random(1,100)
               if tonumber(RandomString) <= tonumber(Config.findWeaponsChance) then -- if randomstring is = or below the number dictated by Config.findWeaponsChance it will give you a weapon we tonumber it just incase some weird shit happens
                  randomWeapon = math.random(1, #Config.Weapons) -- counts the weapons in the table then prints out a number
                  -- could be math.random(1, 3) for example if you had 3 weapons and it will give you the weapon based off the number for the weapon in the config table eg pistol would be 1
                  xPlayer.addWeapon(Config.Weapons[randomWeapon].weapon, Config.Weapons[randomWeapon].ammo)
                  Message("You found a weapon: "..Config.Weapons[randomWeapon].fancyName)
               end
            end

            Message('You have successfully robbed the store for $'..amount..'', src)
            TriggerClientEvent("StopRobberyAnimation", src)
         else
            Message('You must wait 5 minutes before you can rob this again', src)
            TriggerClientEvent("StopRobberyAnimation", src)
         end
      else 
         Message('You don\'t have any lockpicks available', src)
         TriggerClientEvent("StopRobberyAnimation", src)
      end     
   end)
else 
   QBCore = exports["qb-core"]:GetCoreObject()
   function Message(Chat, src) TriggerClientEvent('QBCore:Notify', src, Chat) end
   RegisterServerEvent('RobRegister', function()
      local src = source 
      local Player = QBCore.Functions.GetPlayer(src)
      local amount = math.random(300, 850)
      local timer = math.random (13000, 20000)
      local timeNow = os.clock()
      if Player.Functions.GetItemByName('advancedlockpick') then
            if Player.Functions.GetItemByName('advancedlockpick').amount > 0 then
               if not LastRobbery[source] or timeNow - LastRobbery[source] > 600 then -- 600 seconds robbery cooldown for player on server side
                  LastRobbery[source] = timeNow
   	      		math.randomseed(os.time())
                  Message('Robbing Register!', src)
               
                  Wait(timer)
               
                  if Config.usingMoneyItem then 
                     Player.Functions.AddItem('money', amount)
                  else
                     Player.Functions.AddMoney('cash', amount)
                  end
               
                  if Config.findWeapons then
                     local RandomString = math.random(1,100)
                     if tonumber(RandomString) <= tonumber(Config.findWeaponsChance) then -- if randomstring is = or below the number dictated by Config.findWeaponsChance it will give you a weapon we tonumber it just incase some weird shit happens
                        randomWeapon = math.random(1, #Config.Weapons) -- counts the weapons in the table then prints out a number
                        -- could be math.random(1, 3) for example if you had 3 weapons and it will give you the weapon based off the number for the weapon in the config table eg pistol would be 1
                        Player.Functions.AddItem(Config.Weapons[randomWeapon].weapon, 1)
                        Message("You found a weapon: "..Config.Weapons[randomWeapon].fancyName)
                     end
                  end
               
                  Message('You have successfully robbed the store for $'..amount..'', src)
                  TriggerClientEvent("StopRobberyAnimation", src)
               else
                  Message('You must wait 5 minutes before you can rob this again', src)
                  TriggerClientEvent("StopRobberyAnimation", src)
               end
            else 
               Message('You don\'t have any lockpicks available', src)
               TriggerClientEvent("StopRobberyAnimation", src)
            end
         else 
            Message('You don\'t have any lockpicks available', src)
            TriggerClientEvent("StopRobberyAnimation", src)
         end       
   end)
end