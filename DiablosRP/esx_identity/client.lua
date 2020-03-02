--==================================================================================
--======               ESX_IDENTITY BY ARKSEYONET @Ark                        ======
--======    YOU CAN FIND ME ON MY DISCORD @Ark - https://discord.gg/cGHHxPX   ======
--======    IF YOU ALTER THIS VERSION OF THE SCRIPT, PLEASE GIVE ME CREDIT    ======
--======     Special Thanks To Alphakush and CMD.Telhada For Help Testing     ======
--==================================================================================

--===============================================
--==                 VARIABLES                 ==
--===============================================
local guiEnabled = false
local myIdentity = {}

--===============================================
--==                 VARIABLES                 ==
--===============================================
function EnableGui(enable)
    SetNuiFocus(enable)
    guiEnabled = enable

    SendNUIMessage({
        type = "enableui",
        enable = enable
    })
end

function openRegistry()
  TriggerEvent('esx_identity:showRegisterIdentity')
  
end

--===============================================
--==           Show Registration               ==
--===============================================
RegisterNetEvent("esx_identity:showRegisterIdentity")
AddEventHandler("esx_identity:showRegisterIdentity", function()
   -- SetEntityCoords(GetPlayerPed(-1), tonumber("-1038.57"), tonumber("-2739.09"), tonumber("13.83"), 1, 0, 0, 1)
   EnableGui(true)
 
end)

--===============================================
--==              Close GUI                    ==
--===============================================
RegisterNUICallback('escape', function(data, cb)
    EnableGui(false)
end)

--===============================================
--==           Register Callback               ==
--===============================================
RegisterNUICallback('register', function(data, cb)
  myIdentity = data
  TriggerServerEvent('esx_identity:setIdentity', data)
  EnableGui(false)
  Wait (500)
        
        local x 	=	-1040.05
        local y	=	-2737.98
        local z	=	13.83
  		---------------- REVIVE -----------------------------------
          SetEntityCoordsNoOffset(myPlayerPed, x, y, z, false, false, false, true)
          NetworkResurrectLocalPlayer(x, y, z, 333.64, true, false)
          SetPlayerInvincible(myPlayerPed, false)
          --TriggerEvent('playerSpawned', 333.84, -579.35, 43.32)
          ClearPedBloodDamage(myPlayerPed)
          StopScreenEffect('DeathFailOut')
          DoScreenFadeIn(800)
          SetEntityCoords(myPlayerPed, x, y, z, 1, 0, 0, 1)
          SetEntityHeading(myPlayerPed, 333.64)
          NetworkFadeInEntity(myPlayerPed, 0)
          ---------------------------------------------------------------------
  TriggerEvent('esx_skin:openSaveableMenu')
end)



--===============================================
--==                 THREADING                 ==
--===============================================
Citizen.CreateThread(function()
    while true do
        if guiEnabled then
            DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
            DisableControlAction(0, 2, guiEnabled) -- LookUpDown
            DisableAllControlActions(0)
			--print ("Desactivo controles")
            DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate
            DisableControlAction(0, 18, guiEnabled) -- Enter
            DisableControlAction(0, 322, guiEnabled) -- ESC
            DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride

            if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({
                    type = "click"
                })
            end
        end
        Citizen.Wait(0)
    end
end)
