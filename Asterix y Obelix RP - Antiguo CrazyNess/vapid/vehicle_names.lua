function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end
Citizen.CreateThread(function()
    AddTextEntry('EXECUTIONER', 'Vapid Executioner') -- Enter Gamename from vehicles.lua and what you want it to display.
    AddTextEntry('DOMC', 'Vapid Dominator')
    AddTextEntry('CARA', 'Vapid Caracara')
    AddTextEntry('SCOUT', 'Vapid Scout')
    AddTextEntry('RANCHERXLEXTREME', 'Racher XL Extreme')
    AddTextEntry('SANDKINGHD', 'Sandking HD')
    AddTextEntry('MEGARAM', 'Megaram')
    AddTextEntry('SANDKINGHDXL', 'Sandking HD XL')

end)