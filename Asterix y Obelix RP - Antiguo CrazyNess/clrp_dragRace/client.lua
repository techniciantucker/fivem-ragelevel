local checkPoints = {
 {x = 1120.046, y = 195.695, z = 81.871, checked = false}, 
 {x = 990.833, y = -9.947, z = 81.879, checked = false}, 
 {x = 1108.339, y = -61.357, z = 81.874, checked = false}, 
 {x = 1267.197, y = 188.561, z = 81.874, checked = false}, 
 {x = 1194.402, y = 289.555, z = 81.871, checked = false}, 
}

RegisterNetEvent("dragRace:start")
AddEventHandler("dragRace:start", function(dragRace)
 myCheckPoints = checkPoints
 local totalChecks = 0
 local isRacing = true
 print('halloo')
 Citizen.CreateThread(function()
  while isRacing do 
   Citizen.Wait(5)
   for id,v in pairs(myCheckPoints) do 
   	if not v.checked then 
	 DrawMarker(1, v.x, v.y, v.z-2.0, 0, 0, 0, 0, 0, 0, 4.5,4.5,10.0, 255, 25, 25, 50, 1, 1, 2, 0, 0, 0, 0)
     if GetDistanceBetweenCoords(v.x, v.y, v.z, GetEntityCoords(GetPlayerPed(-1))) < 12.0 then
      v.checked = true
 	  totalChecks = totalChecks + 1 
 	  if totalChecks == 5 then 
 	   TriggerServerEvent('dragRace:winner', dragRace)
   	   isRacing = false
 	  end
     end 
    end 
   end
  end
 end)
end)