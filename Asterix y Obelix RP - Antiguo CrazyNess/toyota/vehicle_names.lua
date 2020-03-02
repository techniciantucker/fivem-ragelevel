function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end
Citizen.CreateThread(function()
    AddTextEntry('rav4', 'Toyota Rav4') -- Enter Gamename from vehicles.lua and what you want it to display.
    AddTextEntry('GT86', 'Toyota GT86')
    AddTextEntry('SUPRA2', 'Toyota Supra JZA80')
	AddTextEntry('camry55', '2016 Toyota Camry')
	AddTextEntry('DILETTAN', 'Toyota Prius')
	AddTextEntry('SUPRAMK4', '1993 Toyota Supra MK IV')
	AddTextEntry('SUPRA4MK', '1993 Toyota Supra MK IV (FnF)')
	AddTextEntry('', '')

	
end)