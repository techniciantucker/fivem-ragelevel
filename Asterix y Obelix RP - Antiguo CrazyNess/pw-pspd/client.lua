Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    local myCoords = GetEntityCoords(GetPlayerPed(-1))
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 840.19, -1293.65, 29.09, true ) < 80 then
      ClearAreaOfPeds(840.19, -1293.65, 29.09, 58.0, 0)
    end
  end
end)