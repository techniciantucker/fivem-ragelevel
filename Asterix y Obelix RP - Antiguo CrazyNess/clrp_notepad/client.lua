local guiEnabled = false
local page = '1'

RegisterNUICallback('escape', function(data, cb) 
 if guiEnabled then 
  EnableGui(false, data.text)
  guiEnabled = false
  cb('ok')
 end
end)

RegisterNetEvent('notepad:load')
AddEventHandler('notepad:load', function(text, pageg)
 guiEnabled = not guiEnabled
 page = pageg
 EnableGui(guiEnabled, text)
end)

function EnableGui(enable, txt)
 SetNuiFocus(enable, false)
 SendNUIMessage({type = "enableui", enable = enable, text = txt})
 if enable then 
  if not IsPedInAnyVehicle(PlayerPedId(), false) then
   TaskStartScenarioInPlace(PlayerPedId(), "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 0, false)
  end
 else 
  TriggerServerEvent('notepad:save', txt, page)
  if not IsPedInAnyVehicle(PlayerPedId(), false) then
   ClearPedTasksImmediately(PlayerPedId())
  end
 end
end 