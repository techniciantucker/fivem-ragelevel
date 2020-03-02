RegisterNetEvent('dispatch:notify')
AddEventHandler('dispatch:notify', function(alert)
 if DecorGetBool(GetPlayerPed(-1), 'isInService') or DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  exports.pNotify:SendNotification({text = "<font color='white'>Aviso: <font color='white'>".. alert, timeout=25000})
 end
end)


--== CDS Reports
RegisterNetEvent("dispatch:noInsurance")
AddEventHandler("dispatch:noInsurance", function()
 local suspectSex = getSuspectSex()
 local suspectLocation = getSuspectLocation()
 local vehicle = GetVehiclePedIsTryingToEnter(GetPlayerPed(-1))
 local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
 local vehiclePlate = GetVehicleNumberPlateText(vehicle)
 local vehicleColour = getVehicleColours(vehicle)
 TriggerServerEvent('dispatch:noInsurance', suspectLocation, suspectSex, vehicleName, vehiclePlate, vehicleColour)
end)

RegisterNetEvent('dispatch:noInsurancePos')
AddEventHandler('dispatch:noInsurancePos', function(pos)
 if DecorGetBool(GetPlayerPed(-1), 'isInService') or DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  local transT = 250
  local thiefBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
  SetBlipSprite(thiefBlip, 10)
  SetBlipColour(thiefBlip, 1)
  SetBlipAlpha(thiefBlip, transT)
  SetBlipAsShortRange(thiefBlip, 1)
  while transT ~= 0 do
   Wait(250)
   transT = transT - 1
   SetBlipAlpha(thiefBlip,  transT)
   if transT == 0 then
    SetBlipSprite(thiefBlip,  2)
    return
   end
  end
 end
end)

RegisterNetEvent("dispatch:custom")
AddEventHandler("dispatch:custom", function(name)
 local suspectSex = getSuspectSex()
 local suspectLocation = getSuspectLocation()
 TriggerServerEvent('dispatch:custom', name, suspectLocation, suspectSex)
  if DecorGetBool(GetPlayerPed(-1), 'isInService') or DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  if math.random(1,3) > 1 then
 TriggerServerEvent('InteractSound_SV:PlayOnSource', 'demo', 0.05)
end
end
end)

RegisterNetEvent('dispatch:customPos')
AddEventHandler('dispatch:customPos', function(name, pos)
	if DecorGetBool(GetPlayerPed(-1), 'isInService') or DecorGetBool(GetPlayerPed(-1), "isOfficer") then
		local transG = 250
		local customBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
		SetBlipSprite(customBlip, 66)
		SetBlipColour(customBlip, 18)
		SetBlipAlpha(customBlip, transG)
		SetBlipAsShortRange(customBlip,  1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name..' Report')
    EndTextCommandSetBlipName(customBlip)
		while transG ~= 0 do
			Wait(25 * 6)
			transG = transG - 1
			SetBlipAlpha(customBlip,  transG)
			if transG == 0 then
				SetBlipSprite(customBlip,  2)
				return
			end
		end
	end
end)
--== CDS Reports
RegisterNetEvent("dispatch:cds")
AddEventHandler("dispatch:cds", function()
 local suspectSex = getSuspectSex()
 local suspectLocation = getSuspectLocation()
 TriggerServerEvent('dispatch:cds', suspectLocation, suspectSex)
 if DecorGetBool(GetPlayerPed(-1), 'isInService') or DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  if math.random(1,3) > 1 then
 TriggerServerEvent('InteractSound_SV:PlayOnSource', 'demo', 0.05)
end
end 
end)

RegisterNetEvent('dispatch:cdsPos')
AddEventHandler('dispatch:cdsPos', function(pos)
	if DecorGetBool(GetPlayerPed(-1), 'isInService') or DecorGetBool(GetPlayerPed(-1), "isOfficer") then
		local transG = 250
		local gunshotBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
		SetBlipSprite(gunshotBlip,  538)
		SetBlipColour(gunshotBlip,  46)
		SetBlipAlpha(gunshotBlip,  transG)
		SetBlipAsShortRange(gunshotBlip,  1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('CDS Report')
    EndTextCommandSetBlipName(gunshotBlip)
		while transG ~= 0 do
			Wait(25 * 6)
			transG = transG - 1
			SetBlipAlpha(gunshotBlip,  transG)
			if transG == 0 then
				SetBlipSprite(gunshotBlip,  2)
				return
			end
		end
	end
end)



RegisterNetEvent("dispatch:gansua")
AddEventHandler("dispatch:gansua", function()
   local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
   local vehiclePlate = GetVehicleNumberPlateText(vehicle)
  -- local vehicleColour = getVehicleColours(vehicle)
   local suspectSex = getSuspectSex()
   local suspectLocation = getSuspectLocation()
   if not exports['clrp_garage']:HasKey(vehiclePlate) then 
   TriggerServerEvent('dispatch:vehicle', suspectLocation, suspectSex, vehicleName, vehiclePlate)
    Wait(500)
	end
end)

-- RegisterNetEvent("dispatch:robbery")
-- AddEventHandler("dispatch:robbery", function()
 -- local suspectSex = getSuspectSex()
 -- local suspectLocation = getSuspectLocation()
 -- TriggerServerEvent('dispatch:robbery', suspectLocation, suspectSex)
-- end)

-- RegisterNetEvent('dispatch:robberyPos')
-- AddEventHandler('dispatch:robberyPos', function(pos)
  -- if DecorGetBool(GetPlayerPed(-1), 'isInService') or DecorGetBool(GetPlayerPed(-1), "isOfficer") then
    -- local transG = 250
    -- local gunshotBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
    -- SetBlipSprite(gunshotBlip,  1)
    -- SetBlipColour(gunshotBlip,  46)
    -- SetBlipAlpha(gunshotBlip,  transG)
    -- SetBlipAsShortRange(gunshotBlip,  1)
    -- while transG ~= 0 do
      -- Wait(25 * 6)
      -- transG = transG - 1
      -- SetBlipAlpha(gunshotBlip,  transG)
      -- if transG == 0 then
        -- SetBlipSprite(gunshotBlip,  2)
        -- return
      -- end
    -- end
  -- end
-- end)

RegisterNetEvent("dispatch:robbery")
AddEventHandler("dispatch:robbery", function()
 local suspectSex = getSuspectSex()
 local suspectLocation = getSuspectLocation()
 TriggerServerEvent('dispatch:robbery', suspectLocation, suspectSex)
 if DecorGetBool(GetPlayerPed(-1), 'isInService') or DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  if math.random(1,3) > 1 then
 TriggerServerEvent('InteractSound_SV:PlayOnSource', 'demo', 0.05)
end
end
end)

RegisterNetEvent('dispatch:robberyPos')
AddEventHandler('dispatch:robberyPos', function(pos)
	if isInService then
		local transG = 250
		local gunshotBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
		SetBlipSprite(gunshotBlip,  1)
		SetBlipColour(gunshotBlip,  44)
		SetBlipAlpha(gunshotBlip,  transG)
		SetBlipAsShortRange(gunshotBlip,  1)
		while transG ~= 0 do
			Wait(25 * 6)
			transG = transG - 1
			SetBlipAlpha(gunshotBlip,  transG)
			if transG == 0 then
				SetBlipSprite(gunshotBlip,  2)
				return
			end
		end
	end
end)

--== Hospital
RegisterNetEvent("dispatch:hospital")
AddEventHandler("dispatch:hospital", function()
 local suspectSex = getSuspectSex()
 local suspectLocation = getSuspectLocation()
 TriggerServerEvent('dispatch:hospital', suspectLocation, suspectSex)
 if DecorGetBool(GetPlayerPed(-1), 'isInService') or DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  if math.random(1,3) > 1 then
 TriggerServerEvent('InteractSound_SV:PlayOnSource', 'demo', 0.05)
end
end
end)

RegisterNetEvent('dispatch:hospitalPos')
AddEventHandler('dispatch:hospitalPos', function(pos)
	if isInService then
		local transG = 250
		local gunshotBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
		SetBlipSprite(gunshotBlip,  1)
		SetBlipColour(gunshotBlip,  44)
		SetBlipAlpha(gunshotBlip,  transG)
		SetBlipAsShortRange(gunshotBlip,  1)
		while transG ~= 0 do
			Wait(25 * 6)
			transG = transG - 1
			SetBlipAlpha(gunshotBlip,  transG)
			if transG == 0 then
				SetBlipSprite(gunshotBlip,  2)
				return
			end
		end
	end
end)

RegisterNetEvent("dispatch:illegalActivity")
AddEventHandler("dispatch:illegalActivity", function()
 local suspectSex = getSuspectSex()
 local suspectLocation = getSuspectLocation()
 TriggerServerEvent('dispatch:robbery', suspectLocation, suspectSex)
  if DecorGetBool(GetPlayerPed(-1), 'isInService') or DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  if math.random(1,3) > 1 then
 TriggerServerEvent('InteractSound_SV:PlayOnSource', 'demo', 0.05)
end
end
end)

RegisterNetEvent('dispatch:illegalPos')
AddEventHandler('dispatch:illegalPos', function(pos)
  if DecorGetBool(GetPlayerPed(-1), 'isInService') or DecorGetBool(GetPlayerPed(-1), "isOfficer") then
    local transG = 250
    local gunshotBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
    SetBlipSprite(gunshotBlip, 1)
    SetBlipColour(gunshotBlip, 61)
    SetBlipAlpha(gunshotBlip, transG)
    SetBlipAsShortRange(gunshotBlip, 1)
    while transG ~= 0 do
      Wait(25 * 6)
      transG = transG - 1
      SetBlipAlpha(gunshotBlip,  transG)
      if transG == 0 then
        SetBlipSprite(gunshotBlip,  2)
        return
      end
    end
  end
end)


--== Reports
RegisterNetEvent('dispatch:vehiclePos')
AddEventHandler('dispatch:vehiclePos', function(pos)
 if DecorGetBool(GetPlayerPed(-1), 'isInService') or DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  local transT = 250
  local thiefBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
  SetBlipSprite(thiefBlip, 10)
  SetBlipColour(thiefBlip, 1)
  SetBlipAlpha(thiefBlip, transT)
  SetBlipAsShortRange(thiefBlip, 1)
  while transT ~= 0 do
   Wait(250)
   transT = transT - 1
   SetBlipAlpha(thiefBlip,  transT)
   if transT == 0 then
    SetBlipSprite(thiefBlip,  2)
    return
   end
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  Wait(1000)
  if IsPedTryingToEnterALockedVehicle(GetPlayerPed(-1)) or IsPedJacking(GetPlayerPed(-1)) then
   local vehicle = GetVehiclePedIsTryingToEnter(GetPlayerPed(-1))
   local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
   local vehiclePlate = GetVehicleNumberPlateText(vehicle)
   local vehicleColour = getVehicleColours(vehicle)
   local suspectSex = getSuspectSex()
   local suspectLocation = getSuspectLocation()

   if not exports['clrp_garage']:HasKey(vehiclePlate) then 
    --TriggerServerEvent('dispatch:vehicle', suspectLocation, suspectSex, vehicleName, vehiclePlate, vehicleColour)
    Wait(500)
   end
  end
 end
end)

--== Gun Shots Reports
RegisterNetEvent('dispatch:shotPos')
AddEventHandler('dispatch:shotPos', function(pos)
 if DecorGetBool(GetPlayerPed(-1), 'isInService') or DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  local transG = 250
  local gunshotBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
  SetBlipSprite(gunshotBlip,  458)
  SetBlipColour(gunshotBlip,  1)
  SetBlipAlpha(gunshotBlip,  transG)
  SetBlipAsShortRange(gunshotBlip,  1)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Gunshot Report')
  EndTextCommandSetBlipName(gunshotBlip)
  while transG ~= 0 do
   Wait(350)
   transG = transG-1
   SetBlipAlpha(gunshotBlip, transG)
   if transG == 0 then
    SetBlipSprite(gunshotBlip,  2)
    return
   end
  end		   
 end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(50)
  if IsPedShooting(GetPlayerPed(-1)) then
   if GetSelectedPedWeapon(GetPlayerPed(-1)) ~= 317205821 and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= 883325847 and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= 101631238 and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= 911657153 and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= 1198879012 and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= GetHashKey("WEAPON_BALL") then
    if not IsSuppressed() and NearestNPC() then
	 local suspectSex = getSuspectSex()
	 local suspectLocation = getSuspectLocation()
	 TriggerServerEvent('dispatch:shot', suspectLocation, suspectSex)	 
	 Wait(100)	 
  if DecorGetBool(GetPlayerPed(-1), 'isInService') or DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  if math.random(1,3) > 1 then
 TriggerServerEvent('InteractSound_SV:PlayOnSource', 'demo', 0.1)
   --TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 8, "lock", 0.1)
end
end	 
	end
   end
  end
 end
end)

function IsSuppressed()
 local currentWeaponHash = GetSelectedPedWeapon(GetPlayerPed(-1))
 local havesilence = false
 if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), GetHashKey("component_at_pi_supp_02"))
 elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
 elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPISTOL") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
 elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_APPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
 elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
 elseif currentWeaponHash == GetHashKey("WEAPON_VINTAGEPISTOL") then
   havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_VINTAGEPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
 elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
   havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_AT_PI_SUPP"))
 elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
 elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSMG") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSMG"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
 elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
 elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
 elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
 elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
 elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
 elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP"))
 elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
 elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
 elseif currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), GetHashKey("COMPONENT_AT_SR_SUPP"))
 elseif currentWeaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
 elseif currentWeaponHash == GetHashKey("WEAPON_SNIPERRIFLE") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_SNIPERRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
 elseif currentWeaponHash == GetHashKey("WEAPON_STUNGUN") then
  havesilence = true
 end
 return havesilence
end


function NearestNPC()
 local playerCoords = GetEntityCoords(GetPlayerPed(-1))
 local handle, ped = FindFirstPed()
 local success
 local rped = nil
 local distanceFrom
 repeat
  local pos = GetEntityCoords(ped)
  local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
  if canPedBeUsed(ped) and distance < 300.0 and (distanceFrom == nil or distance < distanceFrom) then
   distanceFrom = distance
   rped = ped
  end
  success, ped = FindNextPed(handle)
  Wait(10)
  until not success
  EndFindPed(handle)
  
  if DoesEntityExist(rped) then
   return true
  end
end

function canPedBeUsed(ped)
    if ped == nil then
        return false
    end
    if ped == GetPlayerPed(-1) then
        return false
    end
    if not DoesEntityExist(ped) then
        return false
    end
    return true
end

local vehicleColors = {['0'] = "Negro", ['1'] = "Negro", ['2'] = "Negro", ['3'] = "Plateado oscuro", ['4'] = "Plateado", ['5'] = "Azul", ['6'] = "Gris", ['7'] = "Plateado", ['8'] = "Plateado", ['9'] = "Plateado oscuro", ['10'] = "Plateado", ['11'] = "Gris", ['12'] = "Negro mate", ['13'] = "Gris Mate", ['14'] = "Gris", ['15'] = "Negro", ['16'] = "Negro", ['17'] = "Plateado", ['18'] = "Plateado", ['19'] = "Metalico", ['20'] = "Plateado", ['21'] = "Negro", ['22'] = "Grafito", ['23'] = "Gris", ['24'] = "Plateado", ['25'] = "Azul", ['26'] = "Plateado", ['27'] = "Rojo", ['28'] = "Rojo", ['29'] = "Rojo", ['30'] = "Rojo", ['31'] = "Rojo", ['32'] = "Rojo", ['33'] = "Rojo", ['34'] = "Rojo", ['35'] = "Rojo", ['36'] = "Naranja", ['37'] = "Amarillo Oro", ['38'] = "Naranja", ['39'] = "Rojo Mate", ['40'] = "Rojo", ['41'] = "Naranja", ['42'] = "Amarillo", ['43'] = "Rojo", ['44'] = "Rojo", ['45'] = "Rojo", ['46'] = "Rojo", ['47'] = "Rojo", ['48'] = "Rojo", ['49'] = "Verde", ['50'] = "Verde", ['51'] = "Verde", ['52'] = "Verde", ['53'] = "Verde", ['54'] = "Verde", ['55'] = "Verde lima", ['56'] = "Verde", ['57'] = "Verde", ['58'] = "Verde", ['59'] = "Verde", ['60'] = "Azul", ['61'] = "Azul oscuro", ['62'] = "Azul oscuro", ['63'] = "Azul", ['64'] = "Azul", ['65'] = "Azul", ['66'] = "Azul", ['67'] = "Azul", ['68'] = "Azul", ['69'] = "Azul", ['70'] = "Azul", ['71'] = "Azul", ['72'] = "Azul", ['73'] = "Azul", ['74'] = "Azul", ['75'] = "Azul", ['76'] = "Azul oscuro", ['77'] = "Azul", ['78'] = "Azul", ['79'] = "Azul", ['80'] = "Azul", ['81'] = "Azul", ['82'] = "Azul", ['83'] = "Azul Mate", ['84'] = "Azul", ['85'] = "Azul", ['86'] = "Azul", ['87'] = "Azul", ['88'] = "Amarillo", ['89'] = "Amarillo", ['90'] = "Amarillo bronce", ['91'] = "Amarillo", ['92'] = "Lima", ['93'] = "Amarillo", ['94'] = "Beige", ['95'] = "Marfil", ['96'] = "Marron", ['97'] = "Marron", ['98'] = "Marron", ['99'] = "Beige", ['100'] = "Marron", ['101'] = "Marron", ['102'] = "Marron", ['103'] = "Marron", ['104'] = "Naranja", ['105'] = "Marron", ['106'] = "Marron", ['107'] = "Creama", ['108'] = "Marron", ['109'] = "Marron", ['110'] = "Marron", ['111'] = "Blanco", ['112'] = "Blanco", ['113'] = "Blanco", ['114'] = "Marron", ['115'] = "Marron", ['116'] = "Beige", ['117'] = "Plateado", ['118'] = "Negro", ['119'] = "Plateado", ['120'] = "Cromado", ['121'] = "Blanco", ['122'] = "Blanco", ['123'] = "Naranja", ['124'] = "Naranja", ['125'] = "Verde", ['126'] = "Amarillo", ['127'] = "Azul", ['128'] = "Verde", ['129'] = "Marron", ['130'] = "Naranja", ['131'] = "Blanco", ['132'] = "Blanco", ['133'] = "Verde", ['134'] = "Blanco", ['135'] = "Rosa", ['136'] = "Rosa", ['137'] = "Rosa", ['138'] = "Naranja", ['139'] = "Verde", ['140'] = "Azul", ['141'] = "Azul", ['142'] = "Rosa", ['143'] = "Rojo", ['144'] = "Verde", ['145'] = "Morado", ['146'] = "Azul", ['147'] = "Negro", ['148'] = "Morado", ['149'] = "Morado", ['150'] = "Rojo", ['151'] = "Verde", ['152'] = "Verde", ['153'] = "Marron", ['154'] = "Marron", ['155'] = "Verde", ['156'] = "Rotulado", ['157'] = "Azul",}
function getVehicleColours(vehicle)
 local primary, secondary = GetVehicleColours(vehicle)
 return {primary = vehicleColors[tostring(primary)], secondary = vehicleColors[tostring(secondary)]}
end

function getSuspectSex()
 local sex = 'Hombre'
 if GetEntityModel(GetPlayerPed(-1)) == -1667301416 then 
  sex = "Mujer" 
 else 
  sex = "Hombre" 
 end
 return sex
end

function getSuspectLocation()
 local pos = GetEntityCoords(GetPlayerPed(-1),  true)
 local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
 if s2 == 0 then 
  return {street1 = GetStreetNameFromHashKey(s1), street2 = GetStreetNameFromHashKey(s2), both = false, pos = {x = pos.x, y = pos.y, z = pos.z}}
 else 
  return {street1 = GetStreetNameFromHashKey(s1), street2 = GetStreetNameFromHashKey(s2), both = true, pos = {x = pos.x, y = pos.y, z = pos.z}}
 end
 
 
 --1 basic notification
--2 error msg
--3 System Msg / Admin shit

-- same color notification
--4 Seat Belt
--5 Police vehicle actions
--6 Body Stress
--7 housing related
--8 purchase item
--9 engine toggle
--10 phone noticiations
--11 cruise actived
--12 fish winner
--14 race countdown
--15 Gang Update notification
-- TriggerEvent("DoLongHudText","Your house editing has been reset but has not saved!",91)
-- TriggerEvent('DoShortHudText',"You have no chip balance with player " .. player .. ".",101)
-- TriggerEvent("DoShortHudText","Inside Vehicle.",2)

RegisterNetEvent('DoLongHudText')
AddEventHandler('DoLongHudText', function(text,color,length)
    if HudStage > 2 then return end
    if not color then color = 1 end
    if not length then length = 12000 end
    TriggerEvent("tasknotify:guiupdate",color, text, 12000)
end)

RegisterNetEvent('DoShortHudText')
AddEventHandler('DoShortHudText', function(text,color,length)
    if not color then color = 1 end
    if not length then length = 10000 end
    if HudStage > 2 then return end
    TriggerEvent("tasknotify:guiupdate",color, text, 10000)
end)
end