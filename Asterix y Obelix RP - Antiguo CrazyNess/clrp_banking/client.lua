inMenu			= true
local showblips	= true
local atbank	= false
local banks = {
	{name="Bank", id=108, x=150.266, y=-1040.203, z=29.374},
	{name="Bank", id=108, x=-1212.980, y=-330.841, z=37.787},
	{name="Bank", id=108, x=-2962.582, y=482.627, z=15.703},
	{name="Bank", id=108, x=-112.202, y=6469.295, z=31.626},
	{name="Bank", id=108, x=314.187, y=-278.621, z=54.170},
	{name="Bank", id=108, x=-351.534, y=-49.529, z=49.042},
	{name="Bank", id=106, x=241.727, y=220.706, z=106.286},
	{name="Bank", id=108, x=1175.064, y=2706.643, z=38.094}
}	

Citizen.CreateThread(function()
 while true do
  Wait(5)
  if nearBank() then
   drawTxt("~b~Pulse ~g~E~b~ Para acceder a la banco \n~b~Pulse ~g~H~b~ Para acceder a la banco compartida")
   if IsControlJustPressed(0, 38) then
    inMenu = true
    SetNuiFocus(true, true)
    SendNUIMessage({type = 'openGeneral'})
    TriggerServerEvent('bank:balance')
   elseif IsControlJustPressed(0, 74) then 
   	TriggerEvent('shared_banking:status', true)
   end
   if IsControlJustPressed(1, 322) then
   	TriggerEvent('shared_banking:status', false)
	inMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'close'})
   end
  elseif nearATM() then 
   drawTxt("~b~Pulse ~g~E~b~ Para acceder a la banco")
   if IsControlJustPressed(1, 38) then
    inMenu = true
    SetNuiFocus(true, true)
    SendNUIMessage({type = 'openGeneral'})
    TriggerServerEvent('bank:balance')
    TaskStartScenarioInPlace(GetPlayerPed(-1), 'PROP_HUMAN_ATM', false, true) Wait(5000) ClearPedTasksImmediately(GetPlayerPed(-1))
   end
   if IsControlJustPressed(1, 322) then
	inMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'close'})
   end
  end 
 end
end)

Citizen.CreateThread(function()
 for k,v in ipairs(banks)do
  local blip = AddBlipForCoord(v.x, v.y, v.z)
  SetBlipSprite(blip, v.id)
  SetBlipScale(blip, 0.6)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(tostring(v.name))
  EndTextCommandSetBlipName(blip)
 end
end)

RegisterNetEvent('banking:updateBalance')
AddEventHandler('banking:updateBalance', function(balance, playerName)
 SendNUIMessage({type = "balanceHUD", balance = balance, player = playerName})
end)

RegisterNUICallback('deposit', function(data)
 if nearBank() == true then 
  TriggerServerEvent('bank:deposit', tonumber(data.amount))
  TriggerServerEvent('bank:balance')
 else
  --exports.pNotify:SendNotification({text = "Solo puedes depositar dinero en el banco"})
  exports['clrp_notify']:DoLongHudText ('inform', 'Solo puedes depositar dinero en el banco')
 end
end)

RegisterNUICallback('withdrawl', function(data)
 if nearATM() == true and tonumber(data.amountw) < 5000 then 
  TriggerServerEvent('bank:withdraw', tonumber(data.amountw))
  TriggerServerEvent('bank:balance')
 elseif nearBank() == true then 
  TriggerServerEvent('bank:withdraw', tonumber(data.amountw))
  TriggerServerEvent('bank:balance')
 else
  --exports.pNotify:SendNotification({text = "Límite de retirada, $5000"})
  exports['clrp_notify']:DoLongHudText ('inform', 'Límite de retirada, $5000')  
 end
end)

RegisterNUICallback('balance', function()
	TriggerServerEvent('bank:balance')
end)

RegisterNetEvent('balance:back')
AddEventHandler('balance:back', function(balance)
	SendNUIMessage({type = 'balanceReturn', bal = balance})
end)

RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('bank:transfer', tonumber(data.player), tonumber(data.amount))
end)

RegisterNetEvent('bank:result')
AddEventHandler('bank:result', function(type, message)
	SendNUIMessage({type = 'result', m = message, t = type})
end)

RegisterNUICallback('NUIFocusOff', function()
	inMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeAll'})
end)

function nearBank()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)
	
	for _, search in pairs(banks) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
		
		if distance <= 3 then
			return true
		end
	end
end


function drawTxt(text)
  SetTextFont(0)
  SetTextProportional(0)
  SetTextScale(0.32, 0.32)
  SetTextColour(0, 255, 255, 255)
  SetTextDropShadow(0, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(1)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(0.5, 0.93)
end



local nearObject = false 
local isNearObject = false
local objectLoc = {}
local clostestProp = nil
local models = {
  [1] = 'prop_atm_01',
  [2] = 'prop_atm_02',
  [3] = 'prop_atm_03',
  [4] = 'prop_fleeca_atm',
}

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(1500)
  nearObject = false
  isNearObject = false
  local myCoords = GetEntityCoords(GetPlayerPed(-1))
   
  for i = 1, #models do
   clostestProp = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 2.5, GetHashKey(models[i]), false, false)
   if clostestProp ~= nil and clostestProp ~= 0 then
    local coords = GetEntityCoords(clostestProp)
    isNearObject = true
    objectLoc = {['x'] = coords.x, ['y'] = coords.y, ['z'] = coords.z + 1.2}
    break
   end
  end
 end
end)

function nearATM()
 if isNearObject then 
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), objectLoc.x, objectLoc.y, objectLoc.z, true) < 1.0) then
   return true 
  end
 end
end 
