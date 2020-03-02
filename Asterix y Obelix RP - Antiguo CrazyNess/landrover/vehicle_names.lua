function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end
Citizen.CreateThread(function()
    AddTextEntry('def90', '1987 Landrover Defender') -- Enter Gamename from vehicles.lua and what you want it to display.
    AddTextEntry('FX4', 'Landrover Discovery')
    AddTextEntry('landseries3', '1988 Landrover Series 3')
    AddTextEntry('LRII109A', 'Landrover Series 2 109A')
    --AddTextEntry('', '')
    --AddTextEntry('', '')
    --AddTextEntry('', '')
    --AddTextEntry('', '')
end)