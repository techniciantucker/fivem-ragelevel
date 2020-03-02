local blips = {
	{title="Debugeador", colour=75, id=206, x = -329.44, y = 6154.28, z = 32.22},
	x = -329.44, y = 6154.28, z = 32.22 - 1
}

-------------------------------------------
--------------------BLIPS------------------
-------------------------------------------

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x,info.y,info.z)
      SetBlipSprite(info.blip, 206)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.9)
      SetBlipColour(info.blip, 75)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		DrawMarker(1, blips.x,blips.y,blips.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,252,255,0, 200, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(blips.x,blips.y,blips.z, GetEntityCoords(GetPlayerPed(-1),true)) < 1.5 then
			drawTxt("PULSA <E> PARA DEBUGEARTE",2, 1, 0.5, 0.03, 0.80,255,51,255,255)
			if IsControlJustPressed(1,38) then
				TriggerServerEvent('pop_llamada:removeCharacter')
			end
		end
	end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    RemoveAllPickupsOfType(0xDF711959) -- carbine rifle
    RemoveAllPickupsOfType(0xF9AFB48F) -- pistol
    RemoveAllPickupsOfType(0xA9355DCD) -- pumpshotgun
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