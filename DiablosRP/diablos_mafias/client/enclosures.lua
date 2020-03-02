local enclosures = {
	[1] = {
		name = "Centro Vinewood",
		weapon = {x= -812.07, y= 174.89, z= 76.75},
		garage = {x= -810.32, y= 187.99, z= 72.48},
		spawnCar = {x= -834.3, y= 160.33, z= 68.21},
		saveCar = {x= -829.25, y= 178.96, z= 71.2},
		attack  = {x= -812.14, y= 157.57, z= 71.34},
		owner = nil
	},
	[2] = { 
		name = "Alamo Sea",
		weapon = {x= 714.32, y= 4197.28, z= 40.88},
		garage = {x= 726.96, y= 4168.96, z= 40.72},
		spawnCar = {x= 714.52, y= 4174.8, z= 40.72},
		saveCar = {x= 726.56, y= 4175.28, z= 40.72},
		attack = {x= 711.16, y= 4185.44, z= 41.08},
		owner = nil
	},
	[3] = {
		name = "Casino",
		weapon = {x= 972.99, y= 40.94, z= 116.16},
		garage = {x= 914.22, y= 55.73, z= 79.9},
		saveCar = {x= 931.03, y= 72.7, z= 78.85},
		spawnCar = {x= 931.04, y= 86.31, z= 78.85},
		attack = {x= 915.58, y= 34.26, z= 79.9},
		owner = nil
	},
	[4] = {
		name = "Monte Gordo",
		weapon = {x= 3304.0, y= 5185.0, z= 18.72},
		garage = {x= 3316.72, y= 5182.2, z= 18.6},
		saveCar = {x= 3333.28, y= 5160.28, z= 17.32},
		spawnCar = {x= 3318.16, y= 5147.84, z= 17.24},
		attack = {x= 3311.28, y= 5175.96, z= 18.6},
		owner = nil
	},
	[5] = {
		name = "Monte Gordo",
		weapon = {x= 3304.0, y= 5185.0, z= 18.72},
		garage = {x= 2668.65, y= 1312.6, z= 91.98},
		saveCar = {x= 2669.03, y= 1304.83, z= 147.12},
		spawnCar = {x= 2660.18, y= 1308.44, z= 147.12},
		attack = {x= 3311.28, y= 5175.96, z= 18.6},
		owner = nil
	},
	[6] = {
		name = "Galilee",
		weapon = {x= 1364.2, y= 4315.48, z= 37.64},
		garage = {x= 1321.48, y= 4314.32, z= 38.32},
		saveCar = {x= 1304.48, y= 4322.2, z= 38.2},
		spawnCar = {x= 1312.12, y= 4320.12, z= 38.12},
		attack = {x= 1332.68, y= 4325.12, z= 38.24},
		owner = nil
	}
}
local donationsfinish = false

local prices = {
	[1] = 150000,
	[2] = 90000,
	[3] = 100000,
	[4] = 20000,
	[5] = 1000,
	[6] = 1000,
	[7] = 30,
	[8] = 15,
	[9] = 8000,
	[10] = 60000,
	[11] = 80000,
	[12] = 20000,
	[13] = 115000,
	[14] = 100000,
	[15] = 55000,
	[16] = 125000
}

if donationsfinish == true then
	for i,c in pairs(prices) do
		TriggerServerEvent("tm1_mafias:print",c)
		c = c * 0.5
	end
end
function getShop()
	local shop = {
			{label = "Francotirador - "..prices[1].."$", value = "WEAPON_SNIPERRIFLE", money = prices[1],whatItIs = "weapon"},
			{label = "Subfusil - "..prices[2].."$", value = "WEAPON_SMG", money = prices[2],whatItIs = "weapon"},
			{label = "AK47 - "..prices[3].."$", value = "WEAPON_ASSAULTRIFLE", money = prices[3],whatItIs = "weapon"},
			{label = "Rifle Avanzado - "..prices[13].."$", value = "WEAPON_ADVANCEDRIFLE", money = prices[13],whatItIs = "weapon"},
			{label = "Pistola de combate - "..prices[4].."$", value = "WEAPON_COMBATPISTOL", money = prices[4],whatItIs = "weapon"},
			{label = "Pistola vintage - "..prices[10].."$", value = "WEAPON_VINTAGEPISTOL", money = prices[10],whatItIs = "weapon"},
			{label = "Tec 9 - "..prices[11].."$", value="WEAPON_MACHINEPISTOL", money = prices[11], whatItIs = "weapon"},
			{label = "Molotov - "..prices[15].."$", value="WEAPON_MOLOTOV", money = prices[15], whatItIs = "weapon"},
			{label = "C4 - "..prices[16].."$", value="WEAPON_STICKYBOMB", money = prices[16], whatItIs = "weapon"},
			{label = "Navaja - "..prices[12].."$", value="WEAPON_SWITCHBLADE",money = prices[12], whatItIs = "weapon"},
			{label = "Bate - "..prices[9].."$", value = "WEAPON_BAT", money = prices[9], whatItIs = "weapon"},
			{label = "Esposas - "..prices[5].."$", value = "grilletes", money = prices[5],whatItIs = "item"},
			{label = "Llaves de esposas - "..prices[6].."$", value = "keys", money = prices[6],whatItIs = "item"},
			{label = "Paracaidas - "..prices[14].."$", value = "GADGET_PARACHUTE", money = prices[14],whatItIs = "weapon"},
			{label = "Pan - "..prices[7].."$", value = "bread", money = prices[7],whatItIs = "item"},
			{label = "Agua - "..prices[8].."$", value = "water", money = prices[8],whatItIs = "item"},
			{label = "Salir", whatItIs = "exit"}
		}
	return shop
end

local state = true
local seconds = 0
local isStarted = 0
local isIn = false
local isPosible = true
--===========
-- BLIPS
--===========
Citizen.CreateThread(function()
	for _, info in pairs(enclosures) do
      info.blip = AddBlipForCoord(info.attack.x, info.attack.y, info.attack.z)
      SetBlipSprite(info.blip, 374)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.9)
      SetBlipColour(info.blip, 47)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.name)
      EndTextCommandSetBlipName(info.blip)
    end
end)

--===========
-- RECUPERAR DATOS SOBRE RECINTOS
--===========
AddEventHandler('playerSpawned', function(spawn)
	local enclosuresa = {}
	for _, info in pairs(enclosures) do
	    enclosuresa[_] = info.name      	
	end
	TriggerServerEvent('tm1_mafias:enclosureComprobate',enclosuresa)
end)
local enclosuresa = {}
	for _, info in pairs(enclosures) do
	    enclosuresa[_] = info.name      	
	end
TriggerServerEvent('tm1_mafias:enclosureComprobate',enclosuresa)

RegisterNetEvent('tm1_mafias:puttedGroupsInEnclosures')
AddEventHandler('tm1_mafias:puttedGroupsInEnclosures',function()
	Citizen.CreateThread(function()
		local enclosuresa = {}
		for _, info in pairs(enclosures) do
	      	enclosuresa[_] = info.name      	
	    end
	    TriggerServerEvent('tm1_mafias:enclosureComprobate',enclosuresa)
	end)
end)

--===========
-- AÑADIENDO DATOS A EL ENCLOUSERS
--===========
RegisterNetEvent('tm1_mafias:putGroupsInEnclosures')
AddEventHandler('tm1_mafias:putGroupsInEnclosures',function(enclosuresInfo)
	for i,v in pairs(enclosuresInfo) do
		for a,b in pairs(enclosures) do
			if v.name == b.name then
				b.owner = v.groupid
			end
		end
	end
	if isStarted == 1 then

	else
		varReady()
		isStarted = 1
	end
	
end)

RegisterNetEvent('tm1_mafias:changeIsPosible')
AddEventHandler('tm1_mafias:changeIsPosible',function(isPosiblea)
	isPosible = isPosiblea
end)

RegisterNetEvent('tm1_mafias:activeAttack')
AddEventHandler('tm1_mafias:activeAttack',function(x1,x2,x3,name,gr,gr1,groupToGroup)
	if groupToGroup then
		backOperation(5,"attackWithIn1",name,x1,x2,x3,gr,gr1)
	else
		backOperation(5,"attackWithIn",name,x1,x2,x3,gr,gr1)
	end
	TriggerServerEvent('tm1_mafias:advert',"Has empezado el ataque, ten cuidado y no te alejes mas de 15 metros.")
	TriggerServerEvent('tm1_mafias:refreshIsPosible',false)
	state = false
end)
--===========
-- BORRAR VEHÍCULO
--===========
RegisterNetEvent('tm1_mafias:clearV')
AddEventHandler('tm1_mafias:clearV',function(x,y,z)
	local vehicleu = GetClosestVehicle(x,y,z, 6.5, 0, 70)
	SetEntityAsMissionEntity( vehicleu, true, true )
	Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( vehicleu ) )
end)

--===========
-- HILO PRINCIPAL
--===========
function varReady()
	Citizen.CreateThread(function ()
		while true do
			Citizen.Wait(0)
			local coords = GetEntityCoords(GetPlayerPed(-1))
			if not(group.enclosure == nil) and group.aprove == 2 then
				for i,v in pairs(enclosures) do
					if v.name == group.enclosure then
						DrawMarker(1,v.garage.x,v.garage.y,v.garage.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,0,0, 200, 0, 0, 0, 0)
						DrawMarker(1,v.spawnCar.x,v.spawnCar.y,v.spawnCar.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,0,0, 200, 0, 0, 0, 0)
						DrawMarker(1,v.saveCar.x,v.saveCar.y,v.saveCar.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,0,0, 200, 0, 0, 0, 0)
						DrawMarker(1,v.weapon.x,v.weapon.y,v.weapon.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,0,0, 200, 0, 0, 0, 0)
						if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.garage.x,v.garage.y,v.garage.z, true) < 1.5 then
							drawTxt("PULSA E PARA ABRIR EL GARAJE",1, 1, 0.5, 0.9, 0.75,255,0,0,255)
							if IsControlJustReleased(0, 38) then
								local coords = {x = v.spawnCar.x,y = v.spawnCar.y,z = v.spawnCar.z}
								local coords1 = {x = v.saveCar.x,y = v.saveCar.y,z = v.saveCar.z}
								TriggerEvent('esx_eden_garage:activemenu',1,coords,coords1)
							end
						elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.spawnCar.x,v.spawnCar.y,v.spawnCar.z, true) < 1.5 then
							drawTxt("EN ESTE SITIO EL MAYORDOMO TE TRAERA EL COCHE",1, 1, 0.5, 0.9, 0.75,255,0,0,255)
						elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.saveCar.x,v.saveCar.y,v.saveCar.z, true) < 1.5 then
							drawTxt("PON EL COCHE AQUÍ Y AVISA AL MAYORDOMO QUE LO RECOJA EN EL MÚSCULO E",1, 1, 0.5, 0.9, 0.75,255,0,0,255)
							if IsControlJustReleased(0, 38) then
								if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
									StockVehicleMenuc()
								else
									TriggerEvent('esx:showNotification', "No hay ningun coche para meter")
								end
							end
						elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.weapon.x,v.weapon.y,v.weapon.z, true) < 1.5 then
							drawTxt("PULSA E PARA ABRIR EL MENÚ DE COMPRAS DE MAFIA",1, 1, 0.5, 0.9, 0.75,255,0,0,255)
							if IsControlJustReleased(0, 38) then
								OpenShopMenub()
							end
						end
					else
						DrawMarker(1,v.attack.x,v.attack.y,v.attack.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,0,0, 200, 0, 0, 0, 0)
						if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.attack.x,v.attack.y,v.attack.z, true) < 1.5 then
							if state then
								drawTxt("PULSA E PARA INTENTAR ATACAR LA ZONA",1, 1, 0.5, 0.9, 0.75,255,0,0,255)
								if v.owner == nil then
									if IsControlJustReleased(0, 38) then
										if isPosible then
											backOperation(15,"attackWithout1",v.name,v.attack.x,v.attack.y,v.attack.z)
											TriggerServerEvent('tm1_mafias:advert',"Has empezado el ataque, ten cuidado y no te alejes mas de 15 metros.")
											TriggerServerEvent('tm1_mafias:refreshIsPosible',false)
											state = false
										else
											TriggerServerEvent('tm1_mafias:advert',"No es posible hacer el robo ahora mismo")
										end
									end
								else
									if IsControlJustReleased(0, 38) then
										if isPosible then
											TriggerServerEvent('tm1_mafias:getZoneWithin',v.owner,v.attack.x,v.attack.y,v.attack.z,v.name,group.groupid,true)
											TriggerServerEvent('tm1_mafias:advert',"Procesando información, no toques nada")
										else
											TriggerServerEvent('tm1_mafias:advert',"No es posible hacer el robo ahora mismo")
										end
									end
								end
							else
								drawTxt("QUEDAN "..seconds.." SEGUNDOS",1, 1, 0.5, 0.9, 0.75,255,0,0,255)
							end
						end
					end
				end
			else
				if group.aprove == 2 then
					for i,v in pairs(enclosures) do
						DrawMarker(1,v.attack.x,v.attack.y,v.attack.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,0,0, 200, 0, 0, 0, 0)
						if state then
							if GetDistanceBetweenCoords(coords, v.attack.x,v.attack.y,v.attack.z, true) < 1.5 then
								drawTxt("PULSA E PARA INTENTAR ATACAR LA ZONA",1, 1, 0.5, 0.9, 0.75,255,0,0,255)
								if IsControlJustReleased(0, 38) then
									if v.owner == nil then
										if isPosible then
											backOperation(15,"attackWithout",v.name,v.attack.x,v.attack.y,v.attack.z)
											TriggerServerEvent('tm1_mafias:advert',"Has empezado el ataque, ten cuidado y no te alejes mas de 15 metros.")
											TriggerServerEvent('tm1_mafias:refreshIsPosible',false)
											state = false
										else
											TriggerServerEvent('tm1_mafias:advert',"No es posible hacer el robo ahora mismo")
										end
									else
										if isPosible then
											TriggerServerEvent('tm1_mafias:getZoneWithin',v.owner,v.attack.x,v.attack.y,v.attack.z,v.name,group.groupid)
											TriggerServerEvent('tm1_mafias:advert',"Procesando información, no toques nada")
										else
											TriggerServerEvent('tm1_mafias:advert',"No es posible hacer el robo ahora mismo")
										end
									end
								end
							end
						else
							drawTxt("QUEDAN "..seconds.." SEGUNDOS",1, 1, 0.5, 0.9, 0.75,255,0,0,255)
						end
					end
				end
			end
		end
	end)
end

function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

function backOperation(s,operation,encl,x,y,z,gr,gr1)
	Citizen.CreateThread(function ()
	seconds = s
	while true do
		Citizen.Wait(1000)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), x,y,z, true) < 15 then
			isIn = true
		else
			isIn = false
		end
		if isIn == false then
			TriggerServerEvent('tm1_mafias:advert',"Se ha suspendido el ataque por alejarte demasiado")
			state = 1
			break
		end
		if IsEntityDead(GetPlayerPed(-1)) then
			TriggerServerEvent('tm1_mafias:advert',"Ataque suspendido.")
			state = 1
			break
		end
		if seconds == 0 then
			if operation == "attackWithout" then
				state = 1
				TriggerServerEvent('tm1_mafias:advert',"La zona ya es tuya")
				TriggerServerEvent('tm1_mafias:getZoneFinished',encl,group.groupid,operation)
				Citizen.Wait(1000)
				TriggerServerEvent('tm1_mafias:refreshIsPosible',true)
			elseif operation == "attackWithout1" then
				state = 1
				TriggerServerEvent('tm1_mafias:advert',"La zona ya es tuya")
				TriggerServerEvent('tm1_mafias:getZoneFinished',encl,group.groupid,operation)
				Citizen.Wait(1000)
				TriggerServerEvent('tm1_mafias:refreshIsPosible',true)
			elseif operation == "attackWithIn" then
				state = 1
				TriggerServerEvent('tm1_mafias:advert',"La zona ya es tuya")
				TriggerServerEvent('tm1_mafias:getZoneFinished',encl,gr1,operation,gr)
				Citizen.Wait(1000)
				TriggerServerEvent('tm1_mafias:refreshIsPosible',true)
			elseif operation == "attackWithIn1" then
				state = 1
				TriggerServerEvent('tm1_mafias:advert',"La zona ya es tuya")
				TriggerServerEvent('tm1_mafias:getZoneFinished',encl,gr1,operation,gr)
				Citizen.Wait(1000)
				TriggerServerEvent('tm1_mafias:refreshIsPosible',true)
			end
			break
		else
			seconds = seconds - 1
		end
	end
	end)
end

function OpenShopMenub()

	local elements = getShop()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'promoteMenu',
		{
			title  = "Tienda de Mafia",
			align    = 'bottom-right',
			elements = elements
		},
		function(data, menu)
			if data.current.whatItIs == "weapon" then
				TriggerServerEvent('tm1_mafias:buyWeapon',data.current.value,data.current.money)
			elseif data.current.whatItIs == "item" then
				TriggerServerEvent('esx_shop:comprarItemPop',data.current.value,data.current.money)
			elseif data.current.whatItIs == "exit" then
				menu.close()
			end
			
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function IsInVehicle()
  local ply = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end 

RegisterNetEvent('tm1_mafias:esposar')
AddEventHandler('tm1_mafias:esposar',function(option)
	local player, distance = ESX.Game.GetClosestPlayer()
	if distance ~= -1 and distance <= 3.0 then	
		TriggerServerEvent('tm1_mafias:toClientEsposar',GetPlayerServerId(player),option)
	end
end)

RegisterNetEvent('tm1_mafias:changeEsposar')
AddEventHandler('tm1_mafias:changeEsposar',function(option)
  IsHandcuffed    = option
  local playerPed = GetPlayerPed(-1)

  Citizen.CreateThread(function()

    if IsHandcuffed == true then

      RequestAnimDict('mp_arresting')

      while not HasAnimDictLoaded('mp_arresting') do
        Wait(100)
      end

      TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
      SetEnableHandcuffs(playerPed, true)
      SetPedCanPlayGestureAnims(playerPed, false)
      FreezeEntityPosition(playerPed,  true)

    elseif IsHandcuffed == false then

      ClearPedSecondaryTask(playerPed)
      SetEnableHandcuffs(playerPed, false)
      SetPedCanPlayGestureAnims(playerPed,  true)
      FreezeEntityPosition(playerPed, false)

    end

  end)
end)

function StockVehicleMenuc()
		local playerPed  = GetPlayerPed(-1)
		if IsPedSittingInAnyVehicle(playerPed) then
			local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			SetEntityAsMissionEntity( vehicle, true, true )
			local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
			local current 	    = GetPlayersLastVehicle(GetPlayerPed(-1), true)
			local engineHealth  = GetVehicleEngineHealth(current)

			ESX.TriggerServerCallback('eden_garage:stockv',function(valid)

			if (valid) then
				TriggerServerEvent('eden_garage:debug', vehicle)
				deleteCar( vehicle )
				TriggerServerEvent('eden_garage:modifystate', vehicleProps, true)
					------------------------------------------------------- sauvegarde de l'etat du vehicule
				TriggerServerEvent('eden_garage:logging', "engineHealth \t" .. engineHealth.. "\n")
					
				
			if engineHealth < 990 then
				if engineHealth < 960  then
					if engineHealth < 930 then
						if engineHealth < 900 then
							if engineHealth < 870 then
								if engineHealth < 840 then
									if engineHealth < 800 then
										TriggerServerEvent('eden_garage:payhealth', 2000)
										TriggerServerEvent('eden_garage:logging', "$2000 has pagado \n")
									else
										TriggerServerEvent('eden_garage:payhealth', 1800)
										TriggerServerEvent('eden_garage:logging', "$1800 has pagado \n")
									end
								else 
									TriggerServerEvent('eden_garage:payhealth', 1700)
									TriggerServerEvent('eden_garage:logging', "$1700 has pagado \n")
								end
							else 
								TriggerServerEvent('eden_garage:payhealth', 1600)
								TriggerServerEvent('eden_garage:logging', "$1600 has pagado \n")
							end
						else 
							TriggerServerEvent('eden_garage:payhealth', 1500)
							TriggerServerEvent('eden_garage:logging', "$1500 has pagado \n")
						end
					else 
						TriggerServerEvent('eden_garage:payhealth', 1000)
						TriggerServerEvent('eden_garage:logging', "$1000 has pagado \n")
					end
				else
					TriggerServerEvent('eden_garage:payhealth', 500)
					TriggerServerEvent('eden_garage:logging', "$500 has pagado \n")
				end
			end
						TriggerEvent('esx:showNotification', 'Su vehículo está en el garaje')
			else
				TriggerEvent('esx:showNotification', 'No puede almacenar este vehículo')
			end
			end,vehicleProps)
		else
			TriggerEvent('esx:showNotification', 'No hay vehículo para meter')
		end
end