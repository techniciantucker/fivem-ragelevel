
ESX = nil

local PlayerData = {}

Citizen.CreateThread(
  function()
    while ESX == nil do
      TriggerEvent(
        "esx:getSharedObject",
        function(obj)
          ESX = obj
        end
      )
      Citizen.Wait(0)
    end
  end
)


RegisterNetEvent("LRP-palancaCL")
AddEventHandler("LRP-palancaCL",function()
   
        local playerPed = GetPlayerPed(-1)
        local coords = GetEntityCoords(playerPed)
        local vehicle
    
     vehicle, distance = ESX.Game.GetClosestVehicle(coords)
 if DoesEntityExist(vehicle) and vehicle ~= nil and distance ~= nil and distance <= 2.8 then
    TriggerEvent("abrirmaletero:contadorporcentaje")
    Citizen.Wait(100)
    TriggerEvent("abrirmaletero:animacion")
else
--exports['mythic_notify']:DoCustomHudText('error', 'No hay un vehiculo cerca',3000)
ESX.ShowNotification('~r~No hay un vehiculo cerca')
end

end)
