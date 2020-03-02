Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    local myCoords = GetEntityCoords(GetPlayerPed(-1))
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 243.2615,-1070.525,29.28468, true ) < 80 then
      ClearAreaOfPeds(243.9696,-1091.765,29.3064, 58.0, 0)
    end
  end
end)