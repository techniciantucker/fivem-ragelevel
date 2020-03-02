
ESX                             = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

local options = {
    x = 0.1,
    y = 0.2,
    width = 0.2,
    height = 0.04,
    scale = 0.4,
    font = 0,
    menu_title = "Vehículo",
    menu_subtitle = "Categories",
    color_r = 127,
    color_g = 200,
    color_b = 255,
}
local ped = GetPlayerPed(-1)
local currentVehicle
------------------------------------------------------------------------------------------------------------------------

-- Base du menu
function PersonnalMenu()
    options.menu_subtitle = "CATEGORIES"  
    ClearMenu()
    Menu.addButton("Motor", "moteur", nil)
    Menu.addButton("Puertas", "portieres", nil) 
	  Menu.addButton("Cerrar", "CloseMenu", nil)
end

function moteur()
    options.menu_subtitle = "CATEGORIES"  
    ClearMenu()
    Menu.addButton("Encender", "moteurOn", nil)
    Menu.addButton("Apagar", "moteurOff", nil)
	  Menu.addButton("Atrás", "PersonnalMenu", nil)
end

function portieres()
    options.menu_subtitle = "CATEGORIES"  
    ClearMenu()
    Menu.addButton("Todas", "all", nil)
    Menu.addButton("Capó", "capot", nil)
    Menu.addButton("Maletero", "coffre", nil)
    Menu.addButton("Puertas delanteras", "avant", nil)    
    Menu.addButton("Puertas traseras", "arriere", nil)
	  Menu.addButton("Atrás", "PersonnalMenu", nil)
end

function avant()
    options.menu_subtitle = "DOORS"  
    ClearMenu()
    Menu.addButton("Delantera izquierda", "avantgauche", nil)
    Menu.addButton("Delantera derecha", "avantdroite", nil)
	  Menu.addButton("Atrás", "portieres", nil)
end

function arriere()
    options.menu_subtitle = "DOORS"  
    ClearMenu()
    Menu.addButton("Trasera izquierda", "arrieregauche", nil)
    Menu.addButton("Trasera derecha", "arrieredroite", nil)
	  Menu.addButton("Atrás", "portieres", nil)
end

function CloseMenu()
    Menu.hidden = not Menu.hidden
end

------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------
function drawTxt(options)
    SetTextFont(options.font)
    SetTextProportional(0)
    SetTextScale(options.scale, options.scale)
    SetTextColour(255, 255, 255, 255)
    SetTextCentre(0)
    SetTextEntry('STRING')
    AddTextComponentString(options.text)
    DrawRect(options.xBox,options.y,options.width,options.height,0,0,0,150)
    DrawText(options.x - options.width/2 + 0.005, options.y - options.height/2 + 0.0028)
end
function DisplayHelpText(str)
    SetTextComponentFormat('STRING')
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
function notifs(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString( msg )
    DrawNotification(false, false)
end

--------------------------------------------------- NUI CALLBACKS ------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

function all()
   local playerPed = GetPlayerPed(-1)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(currentVehicle, 1) > 0.0 then 
         SetVehicleDoorShut(currentVehicle, 5, false)        
         SetVehicleDoorShut(currentVehicle, 4, false)
         SetVehicleDoorShut(currentVehicle, 3, false)
         SetVehicleDoorShut(currentVehicle, 2, false)
         SetVehicleDoorShut(currentVehicle, 1, false)
         SetVehicleDoorShut(currentVehicle, 0, false)         
       else
         SetVehicleDoorOpen(currentVehicle, 5, false)        
         SetVehicleDoorOpen(currentVehicle, 4, false)
         SetVehicleDoorOpen(currentVehicle, 3, false)
         SetVehicleDoorOpen(currentVehicle, 2, false)
         SetVehicleDoorOpen(currentVehicle, 1, false)
         SetVehicleDoorOpen(currentVehicle, 0, false)  
         frontleft = true        
      end
   end
end

function capot()
   local playerPed = GetPlayerPed(-1)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(currentVehicle, 4) > 0.0 then 
         SetVehicleDoorShut(currentVehicle, 4, false)
       else
         SetVehicleDoorOpen(currentVehicle, 4, false)
         frontleft = true        
      end
   end
end

function coffre()
   local playerPed = GetPlayerPed(-1)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(currentVehicle, 5) > 0.0 then 
         SetVehicleDoorShut(currentVehicle, 5, false)
       else
         SetVehicleDoorOpen(currentVehicle, 5, false)
         frontleft = true        
      end
   end
end

function avantgauche()
   local playerPed = GetPlayerPed(-1)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(currentVehicle, 0) > 0.0 then 
         SetVehicleDoorShut(currentVehicle, 0, false)
       else
         SetVehicleDoorOpen(currentVehicle, 0, false)
         frontleft = true        
      end
   end
end

function avantdroite()
   local playerPed = GetPlayerPed(-1)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(currentVehicle, 1) > 0.0 then 
         SetVehicleDoorShut(currentVehicle, 1, false)
       else
         SetVehicleDoorOpen(currentVehicle, 1, false)
         frontleft = true        
      end
   end
end

function arrieredroite()
   local playerPed = GetPlayerPed(-1)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(currentVehicle, 3) > 0.0 then 
         SetVehicleDoorShut(currentVehicle, 3, false)
       else
         SetVehicleDoorOpen(currentVehicle, 3, false)
         frontleft = true        
      end
   end
end

function arrieregauche()
   local playerPed = GetPlayerPed(-1)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(currentVehicle, 2) > 0.0 then 
         SetVehicleDoorShut(currentVehicle, 2, false)
       else
         SetVehicleDoorOpen(currentVehicle, 2, false)
         frontleft = true        
      end
   end
end

function moteurOn()
   local playerPed = GetPlayerPed(-1)
   SetVehicleUndriveable(currentVehicle,false)
   SetVehicleEngineOn(playerPed, true,false)
   SendNotification("~s~~h~Motor ~g~encendido")
end

function moteurOff()
   local playerPed = GetPlayerPed(-1)
   SetVehicleUndriveable(currentVehicle,true)
   SetVehicleEngineOn(currentVehicle, false,false)
   SendNotification("~s~~h~Motor ~r~apagado")
end

function SendNotification(message)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(message)
    DrawNotification(false, false)
end

function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end

------------------------------------------------------------------------------------------------------------------------
function drawMenuRight(txt,x,y,selected)
  local menu = personnelmenu.menu
  SetTextFont(menu.font)
  SetTextProportional(0)
  SetTextScale(menu.scale, menu.scale)
  SetTextRightJustify(1)
  if selected then
    SetTextColour(0, 0, 0, 255)
  else
    SetTextColour(255, 255, 255, 255)
  end
  SetTextCentre(0)
  SetTextEntry("STRING")
  AddTextComponentString(txt)
  DrawText(x + menu.width/2 - 0.03, y - menu.height/2 + 0.0028) 
end

--------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPedInAnyVehicle(ped) then
            if IsControlJustPressed(1, 249) then
                local matr = GetVehicleNumberPlateText(GetVehiclePedIsIn(ped,false))
                TriggerEvent('llaves:esMillave',matr,function(var)
                    if var then
                        PersonnalMenu() -- Menu to draw
                        Menu.hidden = not Menu.hidden -- Hide/Show the menu
                        currentVehicle = GetVehiclePedIsIn(ped,false)
                    end
                end)
            end
            Menu.renderGUI(options) -- Draw menu on each tick if Menu.hidden = false
            if IsEntityDead(PlayerPedId()) then
                PlayerIsDead()
                -- prevent the death check from overloading the server
                playerdead = true
            else
            end
        end
    end
end)

local working
------------------------------------------------------------------------------------------------------------------------
