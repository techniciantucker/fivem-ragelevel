function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end
Citizen.CreateThread(function()
    AddTextEntry('F288GTO', '1986 Ferrari 288 GTO') -- Enter Gamename from vehicles.lua and what you want it to display.
    AddTextEntry('F599GTO', '2009 Ferrari 599 GTO')
    AddTextEntry('F430', '2017 Ferrari 430')
    AddTextEntry('F812', '2017 Ferrari 812 Superfast')
    AddTextEntry('F599GTO', '2009 Ferrari 599 GTO Fiorano')
    AddTextEntry('CALIFORNIAT', '2006 Ferrari California T')
    AddTextEntry('enzofxx', '2006 Ferrari FXX')
end)