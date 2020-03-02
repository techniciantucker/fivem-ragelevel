function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end
Citizen.CreateThread(function()
    AddTextEntry('CONTGT', 'Bently Continental GT') -- Enter Gamename from vehicles.lua and what you want it to display.
    AddTextEntry('BBENTAYGA', 'Bently Bentayga')
    AddTextEntry('BCFS', '2010 Bentley Flying Spur')
end)