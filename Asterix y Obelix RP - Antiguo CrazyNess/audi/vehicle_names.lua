function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end
Citizen.CreateThread(function()
    AddTextEntry('A8AUDI', 'Audi A8') -- Enter Gamename from vehicles.lua and what you want it to display.
    AddTextEntry('r8ppi', 'Audi R8 PPI Razor GTR')
    AddTextEntry('Rs4avant', 'Audi RS4')
    AddTextEntry('s5', '2017 Audi S5')
    AddTextEntry('RS5C', 'Audi RS5 Coupe')
    AddTextEntry('SQ72016', 'Audi SQ7')
    AddTextEntry('rs3', '2018 Audi RS3 Sportback')
    AddTextEntry('r820', '2020 Audi R8')
    AddTextEntry('rs6', '2016 Audi RS6')
end)