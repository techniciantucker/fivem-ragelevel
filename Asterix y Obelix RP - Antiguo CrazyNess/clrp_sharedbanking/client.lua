inMenu = true
local bankMenu = true
local showBanking = false 
local currentBank = 0
local accounts = {}
local enableShared = false

AddEventHandler('shared_banking:status', function(status)
 if status then 
  while status do 
   local result = GetResult()
   for _,v in pairs(accounts) do 
    if result == v.account then
     TriggerServerEvent('shared_bank:getbalance', v.id)
     inMenu = true
     currentBank = v.id
     SetNuiFocus(true, true)
     SendNUIMessage({type = 'openGeneral'})
     SetPlayerControl(GetPlayerPed(-1), true, 16)
     showBanking = true 
     status = false 
    end
   end
  end
 else
  inMenu = false
  SetNuiFocus(false, false)
  SendNUIMessage({type = 'close'})
  showBanking = false 
 end
end)

RegisterNetEvent('currentbalsh')
AddEventHandler('currentbalsh', function(balance)	
	SendNUIMessage({type = "balanceHUD",balance = balance,player = 'SHARED ACCOUNT'})
end)

RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('shared_bank:deposit', currentBank, tonumber(data.amount))
end)

RegisterNUICallback('withdrawl', function(data)
	TriggerServerEvent('shared_bank:withdraw', currentBank, tonumber(data.amountw))
end)

RegisterNetEvent('balance:back')
AddEventHandler('balance:back', function(balance)
	SendNUIMessage({type = 'balanceReturn', bal = balance})
end)

RegisterNUICallback('transfer', function(data)
 TriggerEvent('chatMessage', 'Transfer Disabled')
end)

RegisterNetEvent('shared_bank:result')
AddEventHandler('shared_bank:result', function(type, message)
	SendNUIMessage({type = 'result', m = message, t = type})
end)

RegisterNetEvent('shared_bank:getaccounts')
AddEventHandler('shared_bank:getaccounts', function(acc)
 accounts = acc
end)

RegisterNUICallback('NUIFocusOff', function()
	inMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeAll'})
	showBanking = false 
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if (showBanking) then
      EnableControlAction(0, 249, true)
      DisableControlAction(0, 1, true) -- LookLeftRight
      DisableControlAction(0, 2, true) -- LookUpDown
      DisableControlAction(0, 24, true) -- Attack
      DisablePlayerFiring(GetPlayerPed(-1), true) -- Disable weapon firing
      DisableControlAction(0, 142, true) -- MeleeAttackAlternate
      DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
      DisableAllControlActions(0)
    end
  end
end)

function GetResult()
 local amount = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
 showLoadingPrompt("Enter Account Number", 8)
 DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 6)
  while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0);
    Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
    local option = GetOnscreenKeyboardResult()
    stopLoadingPrompt()
    if(option ~= nil and option ~= 0) then
     amount = ""..option
     if (amount ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj" and tonumber(amount) > 0) then
      return tonumber(amount)
     end
    end
  end
end

function showLoadingPrompt(showText, showType)
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        N_0xaba17d7ce615adbf("STRING") -- set type
        AddTextComponentString(showText) -- sets the text
        N_0xbd12f8228410d9b4(showType) -- show promt (types = 3)
    end)
end

function stopLoadingPrompt()
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        N_0x10d373323e5b9c0d()
    end)
end
