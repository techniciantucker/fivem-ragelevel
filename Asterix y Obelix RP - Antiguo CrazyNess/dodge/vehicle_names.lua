function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end
Citizen.CreateThread(function()
    AddTextEntry('16DCHAL', '2016 Dodge Challenger')
	AddTextEntry('69CHARGER', '1969 Dodge Charger')
	AddTextEntry('RT70', '1970 Dodge Charger')
	AddTextEntry('VIPERGTSACR', '1999 Dodge Viper')
	AddTextEntry('chall70', '1970 Dodge Challenger')
	AddTextEntry('3500cc', '1999 Dodge Ram 3500 King Cab')
	AddTextEntry('dodgesrt2', '2004 Dodge Ram SRT')
	AddTextEntry('19ram', '2019 Dodge Ram 1500 Slammed')
	--AddTextEntry('', '')
	
    
end)