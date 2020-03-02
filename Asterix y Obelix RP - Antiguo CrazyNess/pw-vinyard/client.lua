Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    local myCoords = GetEntityCoords(GetPlayerPed(-1))
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1890.98, 2039.05, 140.88, true ) < 80 then
      ClearAreaOfPeds(-1890.98, 2039.05, 140.88, 58.0, 0)
    end
  end
end)