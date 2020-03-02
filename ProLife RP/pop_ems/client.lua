local blips = {
  {title="Medico 24/7", colour=1, id=489,x = -388.76, y = 6128.08, z = 30.48}
}
local coordenate = {x = -388.76, y = 6128.08, z = 30.48}

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.9)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
    BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		DrawMarker(1, coordenate.x,coordenate.y,coordenate.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,252,255,0, 200, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(coordenate.x,coordenate.y,coordenate.z, GetEntityCoords(GetPlayerPed(-1),true)) < 3 then
			drawTxt("PULSA <E> PARA CURARTE",2, 1, 0.45, 0.03, 0.80,255,51,255,255)
			if IsControlJustPressed(1,38) then
				TriggerServerEvent('ems:comprobardinero')
			end
		end
	end
end)

RegisterNetEvent('ems:rellenarvida')
AddEventHandler('ems:rellenarvida',function()
	local Ped = GetPlayerPed(-1)
	SetEntityHealth(Ped, 200)
	ClearPedBloodDamage(Ped)
	ResetPedVisibleDamage(Ped)
	ClearPedLastWeaponDamage(Ped)
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
