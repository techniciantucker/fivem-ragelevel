local enclosures = {
	[1] = {
		name = "Asentamiento Monte Chiliad",
		weapon = {x= 2224.52, y= 5604.76, z= 53.92},
		garage = {x= 2194.52, y= 5595.64, z= 52.76},
		saveCar = {x= 2200.76, y= 5572.56, z= 53.76},
		spawnCar = {x= 2206.72, y= 5597.6, z= 52.68},
		attack = {x= 2221.04, y= 5614.48, z= 53.72},
		vestPoint = {x = 2232.48, y = 5611.69, z = 54.93},
		inventoryPoint = {x = 2201.90, y = 5600.64, z = 53.96},
		society = "society_mafia1",
		vest = nil,
		owner = nil
	},
	[2] = {
        name = "E.T.A",
        weapon = {x= -2775.25, y= -25.71, z= 14.4},
        garage = {x= -2756.53, y= -31.25, z= 17.6},
        saveCar = {x= -2738.47, y= -40.93, z= 17.6},
        spawnCar = {x= -2762.34, y= -22.09, z= 17.40},
        attack = {x= -2767.47, y= -24.83, z= 17.63},
        vestPoint = {x = -2793.42 , y = -39.88, z = 10.77},
        inventoryPoint = {x = -2775.78, y = -32.81, z = 11.24},
        society = "society_mafia2",
        vest = nil,
        owner = nil
	},
	[3] = {
        name = "Shishi Gang",
        weapon = {x= 2432.85, y= 4971.37, z= 42.35},
        garage = {x= 2429.94, y= 4972.08, z= 45.94},
        saveCar = {x= 2412.23, y= 4989.93, z= 46.25},
        spawnCar = {x= 2417.57, y= 4970.91, z= 46.13},
        attack = {x= 2434.53, y= 4976.94, z= 46.57},
        vestPoint = {x = 2441.04, y = 4976.22, z = 51.59},
        inventoryPoint = {x = 2441.21, y = 4976.95, z = 46.81},
        society = "society_mafia3",
        vest = nil,
        owner = nil
	},
	[4] = {
        name = "C.A.P.O.",
        weapon = {x= 3310.7, y= 5176.54, z= 19.61},
        garage = {x= 3336.43, y= 5171.78, z= 18.29},
        saveCar = {x= 3327.79, y= 5166.16, z= 18.46},
        spawnCar = {x= 3333.76, y= 5160.5, z= 18.3},
        attack = {x= 3304.22, y= 5184.49, z= 19.71},
        vestPoint = {x = 3318.59 , y = 5178.18, z = 18.42},
        inventoryPoint = {x = 3309.8, y = 5190.13, z = 19.71},
        society = "society_mafia4",
        vest = nil,
        owner = nil
	},
	[5] = {
        name = "Veni Vidi Vici",
        weapon = {x= -2603.69, y= 1915.34, z= 163.47},
        garage = {x= -2597.68, y= 1929.87, z= 167.31},
        saveCar = {x= -2584.79, y= 1925.46, z= 167.31},
        spawnCar = {x= -2576.49, y= 1928.59, z= 167.5},
        attack = {x= -2587.6, y= 1912.01, z= 167.5},
        vestPoint = {x = -2602.59, y = -1896.36, z = 163.75},
        inventoryPoint = {x = -2601.3, y = -1901.28, z = 163.75},
        society = "society_mafia5",
        vest = nil,
        owner = nil
    }
}

local donationsfinish = false

local prices = {
	[1] = 100000,
  	[2] = 30000,
	[3] = 25000,
	[4] = 15000,
	[5] = 13000,
	[6] = 10000,
  	[7] = 8000,
	[8] = 5000,
	[9] = 1500,
	[10] = 1000,
	[11] = 900,
	[12] = 500,
	[13] = 100,
	[14] = 10,
	[15] = 5
}

if donationsfinish == true then
	for i,c in pairs(prices) do
		TriggerServerEvent("tm1_mafias:print",c)
		c = c * 0.5
	end
end
function getShop()
	local shop = {}
	if WEAPONLEVEL == 0 then
		shop = {
			{label = "Esposas - "..prices[5].."$", value = "grilletes", money = prices[5],whatItIs = "item"},
			{label = "Llaves de esposas - "..prices[6].."$", value = "keys", money = prices[6],whatItIs = "item"},
			{label = "Paracaidas - "..prices[14].."$", value = "GADGET_PARACHUTE", money = prices[14],whatItIs = "weapon"},
			{label = "Pan - "..prices[7].."$", value = "bread", money = prices[7],whatItIs = "item"},
			{label = "Agua - "..prices[8].."$", value = "water", money = prices[8],whatItIs = "item"},
			{label = "Salir", whatItIs = "exit"}
		}
	elseif WEAPONLEVEL == 1 then
		shop = {
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
	elseif WEAPONLEVEL == 2 then
		shop = {
			{label = "Subfusil - "..prices[2].."$", value = "WEAPON_SMG", money = prices[2],whatItIs = "weapon"},
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
	elseif WEAPONLEVEL == 3 then
		shop = {
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
	end
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
--[[
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
]]--

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
			if not(group.enclosure == nil) then
				for i,v in pairs(enclosures) do
					if v.name == group.enclosure then
						DrawMarker(1,v.garage.x,v.garage.y,v.garage.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,0,0, 200, 0, 0, 0, 0)
						DrawMarker(1,v.spawnCar.x,v.spawnCar.y,v.spawnCar.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,0,0, 200, 0, 0, 0, 0)
						DrawMarker(1,v.saveCar.x,v.saveCar.y,v.saveCar.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,0,0, 200, 0, 0, 0, 0)
						DrawMarker(1,v.weapon.x,v.weapon.y,v.weapon.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,0,0, 200, 0, 0, 0, 0)
						DrawMarker(1,v.vestPoint.x,v.vestPoint.y,v.vestPoint.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,0,0, 200, 0, 0, 0, 0)
						DrawMarker(1,v.inventoryPoint.x,v.inventoryPoint.y,v.inventoryPoint.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,0,0, 200, 0, 0, 0, 0)
						if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.garage.x,v.garage.y,v.garage.z, true) < 1.5 then
							drawTxt("PULSA E PARA ABRIR EL GARAJE",1, 1, 0.5, 0.9, 0.75,255,0,0,255)
							if IsControlJustReleased(0, 38) then
								local coords = {x = v.spawnCar.x,y = v.spawnCar.y,z = v.spawnCar.z}
								local coords1 = {x = v.saveCar.x,y = v.saveCar.y,z = v.saveCar.z}
								TriggerEvent('esx_esx_eden_garage1:activemenu',1,coords,coords1)
							end
						elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.spawnCar.x,v.spawnCar.y,v.spawnCar.z, true) < 1.5 then
							drawTxt("EN ESTE SITIO EL MAYORDOMO TE TRAERA EL COCHE",1, 1, 0.5, 0.9, 0.75,255,0,0,255)
						elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.vestPoint.x,v.vestPoint.y,v.vestPoint.z, true) < 1.5 then
							drawTxt("PULSA E PARA PONERTE TU CHALECO DE MAFIA",1, 1, 0.5, 0.9, 0.75,255,0,0,255)
							if IsControlJustReleased(0, 38) then
								if v.vest then
									ESX.TriggerServerCallback('tm1_mafias:hasEnoughMoney', function(bool)
										if bool == true then
											ESX.ShowNotification("Te has puesto tu chaleco")
											ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
											if skin.sex == 0 then
												TriggerEvent('skinchanger:change', 'bproof_1', v.vest.male['bproof_1'])
												TriggerEvent('skinchanger:change', 'bproof_2', v.vest.male['bproof_2'])
											else
												TriggerEvent('skinchanger:change', 'bproof_1', v.vest.female['bproof_1'])
												TriggerEvent('skinchanger:change', 'bproof_2', v.vest.female['bproof_2'])
											end
											end)
											SetPedArmour(GetPlayerPed(-1), 100)
										end
									end, 5000)
								else
									ESX.TriggerServerCallback('tm1_mafias:hasEnoughMoney', function(bool)
										if bool == true then
											ESX.ShowNotification("Te has puesto tu chaleco")
											SetPedArmour(GetPlayerPed(-1), 100)
										end
									end, 10000)
								end
							end
						elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.inventoryPoint.x,v.inventoryPoint.y,v.inventoryPoint.z, true) < 1.5 then
							drawTxt("PULSA E PARA ABRIR EL INVENTARIO DE LA MAFIA",1, 1, 0.5, 0.9, 0.75,255,0,0,255)
							if IsControlJustReleased(0, 38) then
								ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mafia_inventory', {
									title    = "Inventario de mafia",
									align    = 'top-left',
									elements = {
										{label = "Depositar objetos",    value = 'deposit'},
										{label = "Retirar objetos", value = 'withdraw'}
								}}, function(data, menu)
									if data.current.value == 'deposit' then
										OpenPutStocksMenu(v)
									elseif data.current.value == 'withdraw' then
										OpenGetStocksMenu(v)
									end
								end, function(data, menu)
									menu.close()
								end)
							end
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
				TriggerServerEvent('esx_shop:comprarItemPop',data.current.value,1,data.current.money)
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

function OpenPutStocksMenu(enclosure)
	ESX.TriggerServerCallback('tm1_mafias:getPlayerInventory', function(inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = "Inventario",
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = "Cantidad"
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification("Cantidad invalida")
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('tm1_mafias:putStockItems', itemName, count, enclosure.society)

					Citizen.Wait(300)
					OpenPutStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenGetStocksMenu(enclosure)
	ESX.TriggerServerCallback('tm1_mafias:getMafiasInventory', function(items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = "Inventario de la mafia",
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title ="Cantidad"
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification("Cantidad inválida")
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('tm1_mafias:getStockItem', itemName, count, enclosure.society)

					Citizen.Wait(300)
					OpenGetStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end, enclosure.society)
end


function StockVehicleMenuc()
		local playerPed  = GetPlayerPed(-1)
		if IsPedSittingInAnyVehicle(playerPed) then
			local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			SetEntityAsMissionEntity( vehicle, true, true )
			local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
			local current 	    = GetPlayersLastVehicle(GetPlayerPed(-1), true)
			local engineHealth  = GetVehicleEngineHealth(current)

			ESX.TriggerServerCallback('esx_eden_garage1:stockv',function(valid)

			if (valid) then
				TriggerServerEvent('esx_eden_garage1:debug', vehicle)
				TriggerServerEvent('esx_eden_garage1:modifystate', true, vehicleProps.plate)
				deleteCar( vehicle )
					------------------------------------------------------- sauvegarde de l'etat du vehicule
				TriggerServerEvent('esx_eden_garage1:logging', "engineHealth \t" .. engineHealth.. "\n")
					
				
			if engineHealth < 990 then
				if engineHealth < 960  then
					if engineHealth < 930 then
						if engineHealth < 900 then
							if engineHealth < 870 then
								if engineHealth < 840 then
									if engineHealth < 800 then
										TriggerServerEvent('esx_eden_garage1:payhealth', 2000)
										TriggerServerEvent('esx_eden_garage1:logging', "$2000 has pagado \n")
									else
										TriggerServerEvent('esx_eden_garage1:payhealth', 1800)
										TriggerServerEvent('esx_eden_garage1:logging', "$1800 has pagado \n")
									end
								else 
									TriggerServerEvent('esx_eden_garage1:payhealth', 1700)
									TriggerServerEvent('esx_eden_garage1:logging', "$1700 has pagado \n")
								end
							else 
								TriggerServerEvent('esx_eden_garage1:payhealth', 1600)
								TriggerServerEvent('esx_eden_garage1:logging', "$1600 has pagado \n")
							end
						else 
							TriggerServerEvent('esx_eden_garage1:payhealth', 1500)
							TriggerServerEvent('esx_eden_garage1:logging', "$1500 has pagado \n")
						end
					else 
						TriggerServerEvent('esx_eden_garage1:payhealth', 1000)
						TriggerServerEvent('esx_eden_garage1:logging', "$1000 has pagado \n")
					end
				else
					TriggerServerEvent('esx_eden_garage1:payhealth', 500)
					TriggerServerEvent('esx_eden_garage1:logging', "$500 has pagado \n")
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