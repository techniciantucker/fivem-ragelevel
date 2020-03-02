 


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  TriggerServerEvent('chaini_registro:loaded')
end)

