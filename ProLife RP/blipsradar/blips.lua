local blips = {
    -- Example {title="", colour=, id=, x=, y=, z=},
	-- Postes de polices
	-- {title="Los Pamplinas (en proceso)", colour=2, id=78, x = -399.08, y = 6315.38, z = 32.52},
	{title="Radar Autopista Señora Paleto", colour=3, id=184, x = 1080.31, y = 6485.99, z = 21.06},
    {title="Radar Autopista Señora Sandy", colour=3, id=184, x = 2415.18, y = 5727.9, z = 45.48}, 
    {title="Radar Frontera", colour=1, id=184, x = 695.6, y = 6515.2, z = 45.48}, 
  }

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
