local safezones = {
    {x = 144.74, y = 6427.3, z = 31.3}, --MECANICO
    {x = 161.81, y = 6595.87, z = 31.8}, --GASOLINERA PALETO
    {x = 184.81, y = 6602.87, z = 31.8}, --GASOLINERA PALETO2
    {x = 126.24, y = 6604.87, z = 31.8}, --GASOLINERA PALETO3
    {x = 939.11, y = 37.37, z = 75.00}, --CASINO1
    {x = 884.74, y = -42.2, z = 78.24}, --CASINOGARAJE
    {x = 942.53, y = 40.49, z = 112.55}, --CASINO3
    {x = 984.24, y = 71.17, z = 73.35}, --CASINO4
    {x = 1022.64, y = 43.08, z = 73.28}, --CASINO5
    {x = 889.64, y = 8.76, z = 78.69}, --CASINO6
    {x = 927.32, y = -88.76, z = 77.92}, --CASINO7
    {x = 933.32, y = -32.76, z = 77.92}, --CASINO8
    {x = 843.44, y = -22.22, z = 77.92}, --CASINO9
    {x = 926.32, y = 81.76, z = 77.91}, --CASINO10

}
local distance = 40.0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for i,v in pairs(safezones) do
			if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < distance then
				drawTxt("Estas en ~r~zona de relax",4, 1, 0.500, 0.935, 0.85,255,255,255,255)
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
