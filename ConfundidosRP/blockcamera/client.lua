Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
		SetPedConfigFlag(PlayerPedId(), 35, false)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(15000)
        N_0xf4f2c0d4ee209e20()
        N_0x9e4cfff989258472()
    end
end)