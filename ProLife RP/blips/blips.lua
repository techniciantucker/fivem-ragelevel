local blips = {
    -- Example {title="", colour=, id=, x=, y=, z=},
	-- Postes de polices
	-- {title="Los Pamplinas (en proceso)", colour=2, id=78, x = -399.08, y = 6315.38, z = 32.52},
	  {title="Oficina de apartamentos", colour=3, id=476, x = -136.56, y = 6198.56, z = 32.52},
    {title="Central Paleto Street 1", colour=3, id=40, x = -374.3, y = 6190.88, z = 32.52},
	  {title="Central Paleto Street 3", colour=3, id=40, x = -356.612, y = 6207.22, z = 32.52},
	  {title="Lateral Paleto Street 1", colour=3, id=40, x = 1.47, y = 6612.93, z = 32.52},
    {title="Lateral Paleto Street 17", colour=3, id=40, x = -303.27, y = 6328.44, z = 32.52},
    {title="Lateral Paleto Street 3", colour=3, id=40, x = -26.85, y = 6597.76, z = 32.52},	
    {title="Isla rica", colour=3, id=375, x = -5867.29, y = 1152.05, z = 32.52},	
    {title="Barrio Las Favelas", colour=1, id=88, x = 1016.03, y = 4408.48, z = 32.52},	
    {title="Quedadas de ProLife", colour=1, id=164, x = -1578.28, y = 2099.47, z = 32.52},	
   
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
