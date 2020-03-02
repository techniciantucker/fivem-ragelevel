local menuOpen = false
local garage = {}
local menu = nil
local demo = { car = nil, model = nil, price = 0 }

local locations = {
 {garage = {x = -795.765, y = -220.138, z = 37.080}, spawn = {x = -772.234, y = -233.188, z = 37.080, heading=222.537}, preview = {x = -783.526, y = -223.429, z = 37.322, heading=77.256}}
 --{garage = {x=1224.850, y=2727.356, z=38.004}, spawn = {x=1230.095, y=2717.908, z=37.502, heading=131.941}, preview = {x=1218.155, y=2717.167, z=37.501, heading=204.264}}
}

Citizen.CreateThread(function()
 for _, v in pairs(locations) do
  local blip = AddBlipForCoord(v.garage.x, v.garage.y, v.garage.z)
  SetBlipSprite(blip, 326)
  SetBlipDisplay(blip, 4)
  SetBlipScale(blip, 0.6)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Vehicle Shop")
  EndTextCommandSetBlipName(blip)
 end
 while true do
  Wait(5)
  for _, info in pairs(locations) do
   if DecorGetInt(GetPlayerPed(-1), 'Faction') == 208 then
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), info.garage.x, info.garage.y, info.garage.z, true) < 25 then
    DrawMarker(23, info.garage.x, info.garage.y, info.garage.z-0.98, 0, 0, 0, 0, 0, 0, 2.5,2.5,0.5, 200, 50, 50, 75, 0, 0, 2, 0, 0, 0, 0)
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), info.garage.x, info.garage.y, info.garage.z, true) < 1.4 then
     drawTxt("~b~Press ~g~E~b~ To Access Vehicle Store")
     if IsControlPressed(0, 38) then
      garage = info
      menuOpen = true
      menu = nil
      currentOption = 1
     end
    end
   end
   end
  end
  if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -45.357, -1082.406, 26.207, true) < 25 then
   DrawMarker(27, -45.357, -1082.406, 25.807, 0, 0, 0, 0, 0, 0, 2.5, 2.5, 0.5, 0,155,255,200,0,0,0,0)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -45.357, -1082.406, 26.207, true) < 2.5 then
    drawTxt('~b~Press ~g~E~b~ To Access Sell Vehicle For 50% Of The Purchase Price')
    if IsControlJustPressed(0, 38) then
     TriggerServerEvent('carshop2:sell2', GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false)))
    end
   end
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  Wait(5)
  if menuOpen then
   if menu == nil then
    Menu.Title("Vehicle Shop")
    spawnMenu("Audi")	
    spawnMenu("Buick")
    spawnMenu("Cadillac")
    spawnMenu("Chevrolet")
    spawnMenu("Dodge")
    spawnMenu("Fiat")
    spawnMenu("Ford")
    spawnMenu("Honda")
    spawnMenu("Jeep")
    spawnMenu("Kia")
    spawnMenu("Lexus")
    --spawnMenu("Mazda")	
    spawnMenu("Mercedes")		
    Menu.updateSelection()
    if IsControlJustPressed(0, 202) then
     menuOpen = false
    end
   else
    if type(vehicles[menu]) == "table" then
     Menu.Title(menu)
     for _, v in pairs(vehicles[menu]) do
      local price = v.price
      spawnCar(v.name, v.model, price)
     end
     Menu.updateSelection()
     if IsControlJustPressed(0, 202) then
      menu = nil
      if demo.car ~= nil then
       SetEntityCoords(GetPlayerPed(-1), garage.garage.x, garage.garage.y, garage.garage.z-0.95)
       Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(demo.car, false))
      SetModelAsNoLongerNeeded(GetHashKey(demo.model))
       scaleform = nil
      end
     end
    end
   end
  end
 end
end)

function spawnMenu(option)
 if Menu.Option(option, true) then
  menu = option
  if demo.car ~= nil then
   SetEntityCoords(GetPlayerPed(-1), garage.garage.x, garage.garage.y, garage.garage.z)
   Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(demo.car, false))
   SetEntityAsNoLongerNeeded(demo.car)
   SetModelAsNoLongerNeeded(GetHashKey(demo.model))
   scaleform = nil
  end
  currentOption = 1
 end
end

function spawnCar(option, model, price)
 if not IsModelValid(GetHashKey(model)) then
  return
 end

 RequestModel(GetHashKey(model))

 while not HasModelLoaded(GetHashKey(model)) do
  Citizen.Wait(5)
  drawTxt('~y~Loading Vehicle')
  RequestModel(GetHashKey(model))
  SetModelAsNoLongerNeeded(GetHashKey(demo.model))
 end

 if currentOption ~= nil then
  if currentOption ~= nil then
   if vehicles[menu][currentOption] ~= nil and demo.model ~= vehicles[menu][currentOption].model then
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(demo.car, false))
    SetEntityAsNoLongerNeeded(demo.car)
    SetModelAsNoLongerNeeded(GetHashKey(demo.model))

    demo.model = vehicles[menu][currentOption].model
    demo.price = math.floor(vehicles[menu][currentOption].price)
    demo.car = CreateVehicle(GetHashKey(demo.model), garage.preview.x, garage.preview.y, garage.preview.z, garage.preview.heading, false, false)

    SetVehicleOnGroundProperly(demo.car)
    SetVehicleEngineOn(demo.car, false)
    SetPedIntoVehicle(GetPlayerPed(-1), demo.car, -1)
    FreezeEntityPosition(demo.car, true)
    SetModelAsNoLongerNeeded(GetHashKey(demo.model))
   end
  end
 end
  if Menu.OptionData(option, tostring(price)) then
   menuOpen = false
   Wait(100)
   local vehicleProps = GetVehProps(GetVehiclePedIsIn(GetPlayerPed(-1), false))
   local model = GetDisplayNameFromVehicleModel(vehicleProps.model)
   Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(demo.car, false))
   TriggerServerEvent('carshop2:buy2', vehicleProps, demo.price, model, menu, currentOption)
   scaleform = nil
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


function drawUI(x,y ,width,height,scale, text, r,g,b,a, center)
 SetTextFont(4)
 SetTextProportional(0)
 SetTextScale(scale, scale)
 SetTextColour(r, g, b, a)
 SetTextDropShadow(0, 0, 0, 0,255)
 SetTextEdge(2, 0, 0, 0, 255)
 SetTextDropShadow()
 SetTextOutline()
 SetTextEntry("STRING")
 AddTextComponentString(text)
 DrawText(x - width/2, y - height/2 + 0.005)
end

RegisterNetEvent("carshop2:bought2")
AddEventHandler("carshop2:bought2",function(data, plate)
 FreezeEntityPosition(GetPlayerPed(-1),false)
 SetEntityVisible(GetPlayerPed(-1),true)
 RequestModel(data.model)
 while not HasModelLoaded(data.model) do
 Citizen.Wait(0)
 end
 spawned = CreateVehicle(data.model, garage.spawn.x, garage.spawn.y, garage.spawn.z, garage.spawn.heading, true, false)
 SetVehicleProperties(spawned, data)
 SetVehicleNumberPlateText(spawned, plate)
 SetEntityAsMissionEntity(spawned, true, true)
 SetVehicleIsConsideredByPlayer(spawned, true)
 TaskWarpPedIntoVehicle(GetPlayerPed(-1), spawned, -1)
end)

function GetVehProps(vehicle)
  local color1, color2 = GetVehicleColours(vehicle)
  local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)

  return {
    model            = GetEntityModel(vehicle),
    plate            = GetVehicleNumberPlateText(vehicle),
    plateIndex       = GetVehicleNumberPlateTextIndex(vehicle),
    health           = GetVehicleBodyHealth(vehicle),
    dirtLevel        = GetVehicleDirtLevel(vehicle),
    color1           = color1,
    color2           = color2,
    pearlescentColor = pearlescentColor,
    wheelColor       = wheelColor,
    wheels           = GetVehicleWheelType(vehicle),
    customTires      = GetVehicleModVariation(vehicle, 23),
    windowTint       = GetVehicleWindowTint(vehicle),
    neonEnabled      = {
     IsVehicleNeonLightEnabled(vehicle, 0),
     IsVehicleNeonLightEnabled(vehicle, 1),
     IsVehicleNeonLightEnabled(vehicle, 2),
     IsVehicleNeonLightEnabled(vehicle, 3),
    },
    neonColor        = table.pack(GetVehicleNeonLightsColour(vehicle)),
    tyreSmokeColor   = table.pack(GetVehicleTyreSmokeColor(vehicle)),
    modSpoilers      = GetVehicleMod(vehicle, 0),
    modFrontBumper   = GetVehicleMod(vehicle, 1),
    modRearBumper    = GetVehicleMod(vehicle, 2),
    modSideSkirt     = GetVehicleMod(vehicle, 3),
    modExhaust       = GetVehicleMod(vehicle, 4),
    modFrame         = GetVehicleMod(vehicle, 5),
    modGrille        = GetVehicleMod(vehicle, 6),
    modHood          = GetVehicleMod(vehicle, 7),
    modFender        = GetVehicleMod(vehicle, 8),
    modRightFender   = GetVehicleMod(vehicle, 9),
    modRoof          = GetVehicleMod(vehicle, 10),
    modEngine        = GetVehicleMod(vehicle, 11),
    modBrakes        = GetVehicleMod(vehicle, 12),
    modTransmission  = GetVehicleMod(vehicle, 13),
    modHorns         = GetVehicleMod(vehicle, 14),
    modSuspension    = GetVehicleMod(vehicle, 15),
    modArmor         = GetVehicleMod(vehicle, 16),
    modTurbo         = IsToggleModOn(vehicle,  18),
    modSmokeEnabled  = IsToggleModOn(vehicle,  20),
    modXenon         = IsToggleModOn(vehicle,  22),
    modFrontWheels   = GetVehicleMod(vehicle, 23),
    modBackWheels    = GetVehicleMod(vehicle, 24),
    modPlateHolder    = GetVehicleMod(vehicle, 25),
    modVanityPlate    = GetVehicleMod(vehicle, 26),
    modTrimA        = GetVehicleMod(vehicle, 27),
    modOrnaments      = GetVehicleMod(vehicle, 28),
    modDashboard      = GetVehicleMod(vehicle, 29),
    modDial         = GetVehicleMod(vehicle, 30),
    modDoorSpeaker      = GetVehicleMod(vehicle, 31),
    modSeats        = GetVehicleMod(vehicle, 32),
    modSteeringWheel    = GetVehicleMod(vehicle, 33),
    modShifterLeavers   = GetVehicleMod(vehicle, 34),
    modAPlate       = GetVehicleMod(vehicle, 35),
    modSpeakers       = GetVehicleMod(vehicle, 36),
    modTrunk        = GetVehicleMod(vehicle, 37),
    modHydrolic       = GetVehicleMod(vehicle, 38),
    modEngineBlock      = GetVehicleMod(vehicle, 39),
    modAirFilter      = GetVehicleMod(vehicle, 40),
    modStruts       = GetVehicleMod(vehicle, 41),
    modArchCover      = GetVehicleMod(vehicle, 42),
    modAerials        = GetVehicleMod(vehicle, 43),
    modTrimB        = GetVehicleMod(vehicle, 44),
    modTank         = GetVehicleMod(vehicle, 45),
    modWindows        = GetVehicleMod(vehicle, 46),
    modLivery       = GetVehicleMod(vehicle, 48),
    maxFuelLevel = DecorGetInt(vehicle, "_Max_Fuel_Level")
  }

end

RegisterNetEvent('vehstore:delete')
AddEventHandler('vehstore:delete', function()
 local ped = GetPlayerPed(-1)
 local vehicle = GetVehiclePedIsIn(ped, false)
 SetEntityAsMissionEntity(vehicle, true, true)
 DeleteVehicle(vehicle)
 DeleteEntity(vehicle)
end)

function SetVehicleProperties(vehicle, props)
  SetVehicleModKit(vehicle,  0)

  if props.plate ~= nil then
    SetVehicleNumberPlateText(vehicle,  props.plate)
  end

  if props.plateIndex ~= nil then
    SetVehicleNumberPlateTextIndex(vehicle,  props.plateIndex)
  end

  if props.health ~= nil and not IsThisModelABike(GetEntityModel(vehicle)) then
    if tonumber(props.health) < 750 then
     SetEntityHealth(vehicle, 500)
     SetVehicleDamage(vehicle, 0.0, 1.0, 0.1, 250.0, 1850.0, true) --800
     SetVehicleDamage(vehicle, -0.2, 1.0, 0.5, 250.0, 650.0, true) -- 50
     SetVehicleDamage(vehicle, -0.7, -0.2, 0.3, 250.0, 500.0, true) --00 50
     SetEntityHealth(vehicle, 500)
     SetVehicleBodyHealth(vehicle, 500)
     SetVehicleEngineHealth(vehicle, 250)
    end
  end

  if props.dirtLevel ~= nil then
    SetVehicleDirtLevel(vehicle,  props.dirtLevel)
  end

  if props.color1 ~= nil then
    local color1, color2 = GetVehicleColours(vehicle)
    SetVehicleColours(vehicle, props.color1, color2)
  end

  if props.color2 ~= nil then
    local color1, color2 = GetVehicleColours(vehicle)
    SetVehicleColours(vehicle, color1, props.color2)
  end

  if props.pearlescentColor ~= nil then
    local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
    SetVehicleExtraColours(vehicle,  props.pearlescentColor,  wheelColor)
  end

  if props.wheelColor ~= nil then
    local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
    SetVehicleExtraColours(vehicle,  pearlescentColor,  props.wheelColor)
  end

  if props.wheels ~= nil then
    SetVehicleWheelType(vehicle,  props.wheels)
  end

  if props.windowTint ~= nil then
    SetVehicleWindowTint(vehicle,  props.windowTint)
  end

  if props.neonEnabled ~= nil then
    SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
    SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
    SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
    SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
  end

  if props.neonColor ~= nil then
    SetVehicleNeonLightsColour(vehicle,  props.neonColor[1], props.neonColor[2], props.neonColor[3])
  end

  if props.modSmokeEnabled ~= nil then
    ToggleVehicleMod(vehicle, 20, true)
  end

  if props.tyreSmokeColor ~= nil then
    SetVehicleTyreSmokeColor(vehicle,  props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3])
  end

  if props.modSpoilers ~= nil then
    SetVehicleMod(vehicle, 0, props.modSpoilers, false)
  end

  if props.modFrontBumper ~= nil then
    SetVehicleMod(vehicle, 1, props.modFrontBumper, false)
  end

  if props.modRearBumper ~= nil then
    SetVehicleMod(vehicle, 2, props.modRearBumper, false)
  end

  if props.modSideSkirt ~= nil then
    SetVehicleMod(vehicle, 3, props.modSideSkirt, false)
  end

  if props.modExhaust ~= nil then
    SetVehicleMod(vehicle, 4, props.modExhaust, false)
  end

  if props.modFrame ~= nil then
    SetVehicleMod(vehicle, 5, props.modFrame, false)
  end

  if props.modGrille ~= nil then
    SetVehicleMod(vehicle, 6, props.modGrille, false)
  end

  if props.modHood ~= nil then
    SetVehicleMod(vehicle, 7, props.modHood, false)
  end

  if props.modFender ~= nil then
    SetVehicleMod(vehicle, 8, props.modFender, false)
  end

  if props.modRightFender ~= nil then
    SetVehicleMod(vehicle, 9, props.modRightFender, false)
  end

  if props.modRoof ~= nil then
    SetVehicleMod(vehicle, 10, props.modRoof, false)
  end

  if props.modEngine ~= nil then
    SetVehicleMod(vehicle, 11, props.modEngine, false)
  end

  if props.modBrakes ~= nil then
    SetVehicleMod(vehicle, 12, props.modBrakes, false)
  end

  if props.modTransmission ~= nil then
    SetVehicleMod(vehicle, 13, props.modTransmission, false)
  end

  if props.modHorns ~= nil then
    SetVehicleMod(vehicle, 14, props.modHorns, false)
  end

  if props.modSuspension ~= nil then
    SetVehicleMod(vehicle, 15, props.modSuspension, false)
  end

  if props.modArmor ~= nil then
    SetVehicleMod(vehicle, 16, props.modArmor, false)
  end

  if props.modTurbo ~= nil then
    ToggleVehicleMod(vehicle,  18, props.modTurbo)
  end

  if props.modXenon ~= nil then
    ToggleVehicleMod(vehicle,  22, props.modXenon)
  end

  if props.modFrontWheels ~= nil then
    SetVehicleMod(vehicle, 23, props.modFrontWheels, false)
  end

  if props.modBackWheels ~= nil then
    SetVehicleMod(vehicle, 24, props.modBackWheels, false)
  end

  if props.modPlateHolder ~= nil then
    SetVehicleMod(vehicle, 25, props.modPlateHolder , false)
  end

  if props.modVanityPlate ~= nil then
    SetVehicleMod(vehicle, 26, props.modVanityPlate , false)
  end

  if props.modTrimA ~= nil then
    SetVehicleMod(vehicle, 27, props.modTrimA , false)
  end

  if props.modOrnaments ~= nil then
    SetVehicleMod(vehicle, 28, props.modOrnaments , false)
  end

  if props.modDashboard ~= nil then
    SetVehicleMod(vehicle, 29, props.modDashboard , false)
  end

  if props.modDial ~= nil then
    SetVehicleMod(vehicle, 30, props.modDial , false)
  end

  if props.modDoorSpeaker ~= nil then
    SetVehicleMod(vehicle, 31, props.modDoorSpeaker , false)
  end

  if props.modSeats ~= nil then
    SetVehicleMod(vehicle, 32, props.modSeats , false)
  end

  if props.modSteeringWheel ~= nil then
    SetVehicleMod(vehicle, 33, props.modSteeringWheel , false)
  end

  if props.modShifterLeavers ~= nil then
    SetVehicleMod(vehicle, 34, props.modShifterLeavers , false)
  end

  if props.modAPlate ~= nil then
    SetVehicleMod(vehicle, 35, props.modAPlate , false)
  end

  if props.modSpeakers ~= nil then
    SetVehicleMod(vehicle, 36, props.modSpeakers , false)
  end

  if props.modTrunk ~= nil then
    SetVehicleMod(vehicle, 37, props.modTrunk , false)
  end

  if props.modHydrolic ~= nil then
    SetVehicleMod(vehicle, 38, props.modHydrolic , false)
  end

  if props.modEngineBlock ~= nil then
    SetVehicleMod(vehicle, 39, props.modEngineBlock , false)
  end

  if props.modAirFilter ~= nil then
    SetVehicleMod(vehicle, 40, props.modAirFilter , false)
  end

  if props.modStruts ~= nil then
    SetVehicleMod(vehicle, 41, props.modStruts , false)
  end

  if props.modArchCover ~= nil then
    SetVehicleMod(vehicle, 42, props.modArchCover , false)
  end

  if props.modAerials ~= nil then
    SetVehicleMod(vehicle, 43, props.modAerials , false)
  end

  if props.modTrimB ~= nil then
    SetVehicleMod(vehicle, 44, props.modTrimB , false)
  end

  if props.modTank ~= nil then
    SetVehicleMod(vehicle, 45, props.modTank , false)
  end

  if props.modWindows ~= nil then
    SetVehicleMod(vehicle, 46, props.modWindows , false)
  end

  if props.modLivery ~= nil then
    SetVehicleMod(vehicle, 48, props.modLivery , false)
  end
  if props.customTires == 1 then
  SetVehicleMod(vehicle, 23, GetVehicleMod(vehicle, 23), true)
  SetVehicleMod(vehicle, 24, GetVehicleMod(vehicle, 23), true)
  end
end

--
--
--
--
-- scaleform = nil
-- function Initialize(scaleform, price, vehName, speed, acce, brake, trac)
--   scaleform = RequestScaleformMovie(scaleform)
--   while not HasScaleformMovieLoaded(scaleform) do
--     Citizen.Wait(0)
--   end
--   PushScaleformMovieFunction(scaleform, "SET_VEHICLE_INFOR_AND_STATS")
--   PushScaleformMovieFunctionParameterString('Name: '..vehName)
--   PushScaleformMovieFunctionParameterString('Price: $'..price)
--   PushScaleformMovieFunctionParameterString("MPCarHUD")
--   PushScaleformMovieFunctionParameterString("Benefactor")
--   PushScaleformMovieFunctionParameterString("Top Speed")
--   PushScaleformMovieFunctionParameterString("Acceleration")
--   PushScaleformMovieFunctionParameterString("Braking")
--   PushScaleformMovieFunctionParameterString("Traction")
--   PushScaleformMovieFunctionParameterInt(speed or 100)
--   PushScaleformMovieFunctionParameterInt(acce or 100)
--   PushScaleformMovieFunctionParameterInt(brake or 100)
--   PushScaleformMovieFunctionParameterInt(trac or 100)
--   PopScaleformMovieFunctionVoid()
--   return scaleform
-- end
--
-- Citizen.CreateThread(function()
--   while true do
--     Citizen.Wait(0)
--     if(scaleform ~= nil)then
--       local x = 0.5
--       local y = -0.12
--       local width = 0.85
--       local height = 1.00
--       DrawScaleformMovie(scaleform, x, y, width, height)
--     end
--   end
-- end)

function isInVehicleShop()
 return menuOpen
end
