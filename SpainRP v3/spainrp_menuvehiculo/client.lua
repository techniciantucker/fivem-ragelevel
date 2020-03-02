local options = {
    x = 0.875,
    y = 0.327,
    width = 0.2,
    height = 0.0329,
    scale = 0.29,
    font = 1,
    menu_title = "Control del vehiculo",
    color_r = 0,
    color_g = 0,
    color_b = 0,
}

local elements = {}
local menuopen = false
local isInVehicle = false
local limiteur = false
speed = 0
local regulateur = 50

engineoff = false

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsControlJustPressed(1, 244) and IsPedInAnyVehicle(GetPlayerPed(-1)) then
            MainMenu()
            Menu.hidden = not Menu.hidden
            menuopen = not menuopen
       end
        Menu.renderGUI(options)
    end
end)

function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function MainMenu()
    options.menu_subtitle = "CATEGORÍAS"  
    ClearMenu()
    Menu.addButton("Encender / Apagar motor", "engine", nil)
    Menu.addButton("Puertas", "DoorMenu", nil)
    Menu.addButton("Cerrar menú", "closemenu", nil)
end

function DoorMenu()
    options.menu_subtitle = "Categorías"  
    ClearMenu()
    Menu.addButton("Capó", "capot", nil)
    Menu.addButton("Maletero", "coffre", nil)
    Menu.addButton("Puertas delanteras", "avant", nil)    
    Menu.addButton("Puertas traseras", "arriere", nil)
    Menu.addButton("Todas las puertas", "toute", nil)    
    Menu.addButton("Atrás", "MainMenu", nil)
end

function avant()
    options.menu_subtitle = "Puertas"  
    ClearMenu()
    Menu.addButton("Delantera izquierda", "avantgauche", nil)
    Menu.addButton("Delantera derecha", "avantdroite", nil)
    Menu.addButton("Atrás", "DoorMenu", nil)
end

function arriere()
    options.menu_subtitle = "Puertas"  
    ClearMenu()
    Menu.addButton("Trasera izquierda", "arrieregauche", nil)
    Menu.addButton("Trasera derecha", "arrieredroite", nil)
  Menu.addButton("Atrás", "DoorMenu", nil)
end

function capot()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 4) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 4, false)
       else
         SetVehicleDoorOpen(playerVeh, 4, false)
         frontleft = true        
      end
   end
end

function coffre()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 5) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 5, false)
       else
         SetVehicleDoorOpen(playerVeh, 5, false)
         frontleft = true        
      end
   end
end

function maxspeed()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   enableCruise = not enableCruise -- inverts bool
   cruiseSpeed = GetEntitySpeed(veh)  
   GetEntitySpeed(playerVeh, 10)
end

function avantgauche()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 0) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 0, false)
       else
         SetVehicleDoorOpen(playerVeh, 0, false)
         frontleft = true        
      end
   end
end

function MyPed()
   return GetPlayerPed(-1)
end


function avantdroite()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 1) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 1, false)
       else
         SetVehicleDoorOpen(playerVeh, 1, false)
         frontleft = true        
      end
   end
end

function arrieredroite()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 3) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 3, false)
       else
         SetVehicleDoorOpen(playerVeh, 3, false)
         frontleft = true        
      end
   end
end

function toute()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 1) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 5, false)        
         SetVehicleDoorShut(playerVeh, 4, false)
         SetVehicleDoorShut(playerVeh, 3, false)
         SetVehicleDoorShut(playerVeh, 2, false)
         SetVehicleDoorShut(playerVeh, 1, false)
         SetVehicleDoorShut(playerVeh, 0, false)         
       else
         SetVehicleDoorOpen(playerVeh, 5, false)        
         SetVehicleDoorOpen(playerVeh, 4, false)
         SetVehicleDoorOpen(playerVeh, 3, false)
         SetVehicleDoorOpen(playerVeh, 2, false)
         SetVehicleDoorOpen(playerVeh, 1, false)
         SetVehicleDoorOpen(playerVeh, 0, false)  
         frontleft = true        
      end
   end
end

function arrieregauche()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 2) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 2, false)
       else
         SetVehicleDoorOpen(playerVeh, 2, false)
         frontleft = true        
      end
   end
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0) 
    if regulateur == 50 then
    else      
        speedo(regulateur)
      end
    end
end)

function setregul()
        local ped = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(ped, false)  
        local currSpeed = GetEntitySpeed(vehicle)*3.6  
        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 20)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            local vitesse = GetOnscreenKeyboardResult()
          if not vitesse ~= nil then
          Notify("NIL")
          else  
          local res = tonumber(vitesse)  
          if currSpeed > res then
            Notify("~r~No puede hacer esto porque su velocidad es mayor a ~g~50 ~r~kph.")
        else             
            speedo(res)
            regulateur = res
            MainMenu()
            Wait(1)
            MenuSpeedo()  
            Menu.selection = 1    
            end      
          end
        end      
end

function suprregu()
  print("1")
  speedo(0)
  regulateur = 50
  MainMenu()
  Wait(1)
  MenuSpeedo()
  Menu.selection = 2
end

function uprregu()
    local ped = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(ped, false)  
    local currSpeed = GetEntitySpeed(vehicle)*3.6
    if currSpeed > regulateur then
      Notify("~r~No puede hacer esto porque su velocidad es mayor a ~g~50 ~r~kph.")
    else
      if regulateur < 200 then
        regulateur = regulateur +10
      else
        Notify("~r~La limitacion maxima es de ~g~120 ~r~kph.")
      end
  MainMenu()
  Wait(1)
  MenuSpeedo()
end
end

function downrregu()
  if regulateur < 60 then
    regulateur = 50
  MainMenu()
  Wait(1)
  MenuSpeedo()      
else
  if regulateur == 50 then
  regulateur = 50
  speedo(0)
else  
  regulateur = regulateur -10
  MainMenu()
  Wait(1)
  MenuSpeedo()  
  Menu.selection = 1
end
end
end

function speedo(vit)
    local player = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(player, false)  
    local currSpeed = GetEntitySpeed(vehicle)*3.6
    speed = vit/3.62
   
    local vehicleModel = GetEntityModel(vehicle)
    local float Max = GetVehicleMaxSpeed(vehicleModel)  
    
    if (vit == 0) then
    SetEntityMaxSpeed(vehicle, Max)
    end      
    
    if currSpeed > vit then
    else
   
        if (vit == 0) then
        SetEntityMaxSpeed(vehicle, Max)
        else
        
            if vit == 0 and currSpeed < 5 then  
            else
              SetEntityMaxSpeed(vehicle, speed)
            end
        
        end
    end
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
        if limiteur then
          local player = GetPlayerPed(-1)
          local vehicle = GetVehiclePedIsIn(player, false)          
          SetEntityMaxSpeed(vehicle, speed) 
       end
    end
end)

IsEngineOn = true

function engine()

  local player = GetPlayerPed(-1)
  
  local vehicle = GetVehiclePedIsIn(player,false)

	if (IsPedSittingInAnyVehicle(player)) then 
		
    if IsEngineOn == true then
      
      SetVehicleEngineOn(vehicle,false,false,false)
      IsEngineOn = false

    else
      
			SetVehicleUndriveable(vehicle,false)
      SetVehicleEngineOn(vehicle,true,false,false)
      IsEngineOn = true

		end
		
    if IsEngineOn == false then
      
      SetVehicleUndriveable(vehicle,true)
      
    end
    
  end
  
end

function closemenu()
  Menu.hidden = not Menu.hidden
  menuopen = not menuopen
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
      if IsControlJustPressed(1, 177) and menuopen then
        closemenu()
      end

      local IsInVehicle = IsPedInAnyVehicle(PlayerPedId(), false)

        if not IsInVehicle and menuopen then
          closemenu()
          suprregu()
        end

    end
end)