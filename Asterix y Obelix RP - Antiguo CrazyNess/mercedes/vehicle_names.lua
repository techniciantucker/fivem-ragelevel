function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end
Citizen.CreateThread(function()
    AddTextEntry('CLA45SB', '2016 Mercedes-AMG') -- Enter Gamename from vehicles.lua and what you want it to display.
    AddTextEntry('G65', '2013 Mercedes G65 AMG')
    AddTextEntry('AMGGT', '2016 Mercedes AMG-GT')
	AddTextEntry('300SL', '1955 Mercedes-Benz 300SL')
	AddTextEntry('V250', 'Mercedes V-Class 250')
	AddTextEntry('600sel', 'Mercedes 600 SEL')
	AddTextEntry('E63AMG', 'Mercedes E63 AMG')
	--AddTextEntry('', '')
	--AddTextEntry('', '')
	--AddTextEntry('', '')
	--AddTextEntry('', '')
	
end)