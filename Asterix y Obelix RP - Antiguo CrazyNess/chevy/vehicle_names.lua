function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end
Citizen.CreateThread(function()
    AddTextEntry('IMPALASSL', '1964 Impala SS Lowrider') -- Enter Gamename from vehicles.lua and what you want it to display.
    AddTextEntry('C7', '2014 Chevy Corvette C7 Stingray')
	AddTextEntry('subn', ' 2006 Chevy Suburban')
	AddTextEntry('z2879', '1979 Chevy Camaro Z28')
	AddTextEntry('CN69', '1969 Chevrolet Nova (Standard)')
	AddTextEntry('CD69', '1969 Chevrolet Nova (Drag Racer)')
	AddTextEntry('CM69', '1969 Chevrolet Nova (Monster)')
	AddTextEntry('z112017', '2017 Chevy Camaro Z71')
	AddTextEntry('80silverado', '1980 Chevy Silverado')
	AddTextEntry('wheel_ltz_01', 'Testing Wheel Addon')
	--AddTextEntry('', '')
	--AddTextEntry('', '')
	--AddTextEntry('', '')
	

end)