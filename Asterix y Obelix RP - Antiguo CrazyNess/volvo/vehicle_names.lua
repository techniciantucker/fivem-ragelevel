function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end
Citizen.CreateThread(function()
    AddTextEntry('V242', 'Volvo 242 Turbo') -- Enter Gamename from vehicles.lua and what you want it to display.
    AddTextEntry('AMAZON', '1960 Volvo Amazon')
    AddTextEntry('850R', '1985 Volvo 850R')
    AddTextEntry('AUDIA4', '2017 Volvo S90')
    AddTextEntry('s60pole', '2015 Volvo S60 Polestar')
end)