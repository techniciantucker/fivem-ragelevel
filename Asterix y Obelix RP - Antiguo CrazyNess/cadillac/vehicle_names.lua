function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end
Citizen.CreateThread(function()
    AddTextEntry('CadCTSV', '2016 Cadillac CTS-V') -- Enter Gamename from vehicles.lua and what you want it to display.
    AddTextEntry('GMT900ESCALADE', 'Cadillac Escalade')
    AddTextEntry('ROYALE', 'Cadillac XTS Lino Royal')
    AddTextEntry('CATS', '2016 Cadillac ATS-V')
    AddTextEntry('sixtyone41', '1941 Cadillac Seris 61')
end)