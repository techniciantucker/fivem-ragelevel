--================================================================================================
--==                                VARIABLES - DO NOT EDIT                                     ==
--================================================================================================
ESX                         = nil
inMenu                      = true
local showblips = true
local atbank = false
local bankMenu = true
local banks = {
  {name="Banco", id=108, x=150.266, y=-1040.203, z=29.374},
  {name="Banco", id=108, x=-1212.980, y=-330.841, z=37.787},
  {name="Banco", id=108, x=-2962.582, y=482.627, z=15.703},
  {name="Banco", id=108, x=-112.202, y=6469.295, z=31.626},
  {name="Banco", id=108, x=314.187, y=-278.621, z=54.170},
  {name="Banco", id=108, x=-351.534, y=-49.529, z=49.042},
  {name="Banco", id=108, x=241.727, y=220.706, z=106.286},
  {name="Banco", id=108, x=1175.0643310547, y=2706.6435546875, z=38.094036102295}
}	

local atms = {
  {name="ATM", id=277, x = -386.733,  y = 6045.953,  z = 31.501},
  {name="ATM", id=277, x = 155.4300,  y = 6641.991,  z = 31.784},
  {name="ATM", id=277, x = 174.6720,  y = 6637.218,  z = 31.784},
  {name="ATM", id=277, x = 1703.138,  y = 6426.783,  z = 32.730},
  {name="ATM", id=277, x = 1735.114,  y = 6411.035,  z = 35.164},
  {name="ATM", id=277, x = 1702.842,  y = 4933.593,  z = 42.051},
  {name="ATM", id=277, x = 1967.333,  y = 3744.293,  z = 32.272},
  {name="ATM", id=277, x = 1174.532,  y = 2705.278,  z = 38.027},
  {name="ATM", id=277, x = 2564.399,  y = 2585.100,  z = 38.016},
  {name="ATM", id=277, x = 2558.683,  y = 349.6010,  z = 108.050},
  {name="ATM", id=277, x = 2558.051,  y = 389.4817,  z = 108.660},
  {name="ATM", id=277, x = 1077.692,  y = -775.796,  z = 58.218},
  {name="ATM", id=277, x = 1139.018,  y = -469.886,  z = 66.789},
  {name="ATM", id=277, x = 1168.975,  y = -457.241,  z = 66.641},
  {name="ATM", id=277, x = 1153.884,  y = -326.540,  z = 69.245},
  {name="ATM", id=277, x = 236.4638,  y = 217.4718,  z = 106.840},
  {name="ATM", id=277, x = 265.0043,  y = 212.1717,  z = 106.780},
  {name="ATM", id=277, x = -164.568,  y = 233.5066,  z = 94.919},
  {name="ATM", id=277, x = -1827.04,  y = 785.5159,  z = 138.020},
  {name="ATM", id=277, x = -1409.39,  y = -99.2603,  z = 52.473},
  {name="ATM", id=277, x = -1215.64,  y = -332.231,  z = 37.881},
  {name="ATM", id=277, x = -2072.41,  y = -316.959,  z = 13.345},
  {name="ATM", id=277, x = -2975.72,  y = 379.7737,  z = 14.992},
  {name="ATM", id=277, x = -2962.60,  y = 482.1914,  z = 15.762},
  {name="ATM", id=277, x = -3144.13,  y = 1127.415,  z = 20.868},
  {name="ATM", id=277, x = -1091.44, y = 2708.6, z = 17.96},
  {name="ATM", id=277, x = 1822.68, y = 3683.16, z = 33.28},
  {name="ATM", id=277, x = 1967.333, y = 3744.293, z = 32.272},
  {name="ATM", id=277, x = 174.6720, y = 6637.218, z = 31.784},
  {name="ATM", id=277, x = -97.44, y = 6455.16, z = 30.48},
  {name="ATM", id=277, x = -386.64, y = 6045.88, z = 31.52},
  {name="ATM", id=277, x = 2222.08, y = 5608.28, z = 54.72},
  {name="ATM", id=277, x = 3312.52, y = 5178.92, z = 19.6},
  {name="ATM", id=277, x = 81.90, y = 3706.72, z = 41.8},
  {name="ATM", id=277, x = -1115.4, y = 4940.08, z = 218.6},
	{name="ATM", id=277, x = 775.8, y = 4186.44, z = 41.76},
	{name="ATM", id=277, x = 114.92, y = 6440.33, z = 31.76},
	{name="ATM", id=277, x = 977.02, y = 39.22, z = 73.86},
  {name="ATM", id=277, x = 1366.88, y = 4311.88, z = 37.92}
}
--================================================================================================
--==                                THREADING - DO NOT EDIT                                     ==
--================================================================================================

--===============================================
--==           Base ESX Threading              ==
--===============================================
Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)





--===============================================
--==             Core Threading                ==
--===============================================
if bankMenu then
	Citizen.CreateThread(function()
  while true do
    Wait(0)
	if nearBank() or nearATM() then
			DisplayHelpText("Presiona ~INPUT_PICKUP~ para acceder al banco ~b~")
	
		if IsControlJustPressed(1, 38) then
			inMenu = true
			SetNuiFocus(true, true)
			SendNUIMessage({type = 'openGeneral'})
			TriggerServerEvent('bank:balance')
			local ped = GetPlayerPed(-1)
		end
	end
        
    if IsControlJustPressed(1, 322) then
	  inMenu = false
      SetNuiFocus(false, false)
      SendNUIMessage({type = 'close'})
    end
	end
  end)
end


--===============================================
--==             Map Blips	                   ==
--===============================================
Citizen.CreateThread(function()
	if showblips then
	  for k,v in ipairs(banks)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, v.id)
		SetBlipScale(blip, 1.0)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(tostring(v.name))
		EndTextCommandSetBlipName(blip)
	  end
	end
end)

Citizen.CreateThread(function()
	if showblips then
	  for k,v in ipairs(atms)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 431)
		SetBlipScale(blip, 1.0)
		SetBlipAsShortRange(blip, true)
		SetBlipColour (blip, 2)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(tostring(v.name))
		EndTextCommandSetBlipName(blip)
	  end
	end
end)

--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNetEvent('currentbalance1')
AddEventHandler('currentbalance1', function(balance)
	local id = PlayerId()
	local playerName = GetPlayerName(id)
	
	SendNUIMessage({
		type = "balanceHUD",
		balance = balance,
		player = playerName
		})
end)
--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('bank:deptoniositarPop', tonumber(data.amount))
end)

--===============================================
--==          Withdraw Event                   ==
--===============================================
RegisterNUICallback('withdrawl', function(data)
	TriggerServerEvent('bank:quitarPop', tonumber(data.amountw))
end)

--===============================================
--==         Balance Event                     ==
--===============================================
RegisterNUICallback('balance', function()
	TriggerServerEvent('bank:balancePop')
end)

RegisterNetEvent('balance:back')
AddEventHandler('balance:back', function(balance)

	SendNUIMessage({type = 'balanceReturn', bal = balance})

end)


--===============================================
--==         Transfer Event                    ==
--===============================================
RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('bank:trantonisferir', data.to, data.amountt)
	
end)




--===============================================
--==               NUIFocusoff                 ==
--===============================================
RegisterNUICallback('NUIFocusOff', function()
  inMenu = false
  SetNuiFocus(false, false)
  SendNUIMessage({type = 'closeAll'})
end)


--===============================================
--==            Capture Bank Distance          ==
--===============================================
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

function nearATM()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)
	
	for _, search in pairs(atms) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
		
		if distance <= 3 then
			return true
		end
	end
end


function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end