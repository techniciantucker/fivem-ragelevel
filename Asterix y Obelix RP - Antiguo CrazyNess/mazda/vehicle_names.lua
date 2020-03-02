function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end
Citizen.CreateThread(function()
    AddTextEntry('RX7TUNABLE', 'Mazda RX7 Spirit R') -- Enter Gamename from vehicles.lua and what you want it to display.
    AddTextEntry('na6', 'Mazda MX-5 Miata')
    AddTextEntry('miata3', '1989 Mazda Miata 3')
    AddTextEntry('MRX7', '1995 Mazda RX7')
    AddTextEntry('RX7', '1984 Mazda RX7')
    AddTextEntry('2011mazda2', '2001 Mazda 2')
    AddTextEntry('RX3', '1984 Mazda RX3')
end)