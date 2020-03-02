local safezones = {
	{x = -192.84, y = 6216.4, z = 31.48}, --GARAE
	{x = -367.3, y = 6132.29, z = 31.44}, --HOSPITAL
	{x = -328.84, y = 6080.26, z = 31.44}, --ARMERIA
	{x = -448.22, y = 6033.39, z = 31.44}, --COMISARIA
	{x = -464.62, y = 5991.42, z = 31.44}, --COMISARIA2
	{x = -110.16, y = 6450.18, z = 31.44}, --BANCO PALETO
	{x = 6.84, y = 6514.27, z = 31.44}, --ROPA PALETO
	{x = -365.08, y = 6054.1, z = 31.44}, --ATM COMISARIA PALETO
	{x = -246.41, y = 6330.16, z = 31.44}, --CONCESIONARIO PALETO
	{x = 1730.22, y = 6411.07, z = 31.44}, --TIENDA AUTOPISTA
	{x = -206.83, y = 6541.4, z = 11.14}, --GARAJE PALETO BEACH
	{x = -380.64, y = 6229.4, z = 33.54}, --CASAS 1
	{x = -329.64, y = 6305.4, z = 33.54}, --CASAS 2
	{x = -239.64, y = 6378.4, z = 33.54}, --CASAS 3
	{x = -190.64, y = 6418.4, z = 33.54}, --CASAS 4
	{x = -391.8, y = 6281.4, z = 33.54}, --CASAS 5
	{x = -288.8, y = 6364.4, z = 33.54}, --CASAS 6

}
local distance = 50.0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for i,v in pairs(safezones) do
			if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < distance then
				drawTxt("Estas en ~g~zona segura",4, 1, 0.500, 0.935, 0.85,255,255,255,255)
			end
		end
	end
end)

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x , y)
end
