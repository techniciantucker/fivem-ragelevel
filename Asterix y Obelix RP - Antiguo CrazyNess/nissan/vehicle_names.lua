function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end
Citizen.CreateThread(function()
    AddTextEntry('SkylineGTR', 'Nissan Skyline GT-R') -- Enter Gamename from vehicles.lua and what you want it to display.
    AddTextEntry('370Z', 'Nissan 300ZX')
	AddTextEntry('QASHQAI', '2016 Nissan Qashqai')
	AddTextEntry('s15rb', 'Nissan Silva S15') 
	AddTextEntry('NISMO20', 'Nissan Nismo 20') 
	AddTextEntry('nissantitan17', '2017 Nissan Titan') 
	AddTextEntry('SKYLINEGTR', '1999 Nissan Skyline (2F2F)') 
	AddTextEntry('gtr2020', '2020 Nissan Concept Vision') 
end)