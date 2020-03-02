function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end
Citizen.CreateThread(function()
    AddTextEntry('boxsters', '2018 Porche 718 Boxster') -- Enter Gamename from vehicles.lua and what you want it to display.
    AddTextEntry('PANAMERA', '2017 Porche Panamera')
	AddTextEntry('911R', '2017 Porche 911-R/GTE')
end)