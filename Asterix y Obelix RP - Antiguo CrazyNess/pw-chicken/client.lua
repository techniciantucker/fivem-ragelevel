Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    local myCoords = GetEntityCoords(GetPlayerPed(-1))
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 172.95, -1043.41, 34.38, true ) < 80 then
      ClearAreaOfPeds(172.95, -1043.41, 34.38, 58.0, 0)
    end
  end
end)