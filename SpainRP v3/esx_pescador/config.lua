Config = {}
	---------------------------------------------------------------
	--=====How long should it take for player to catch a fish=======--
	---------------------------------------------------------------
	--Time in miliseconds
	Config.FishTime = {a = 20000, b = 44000}
	
	--------------------------------------------------------
	--=====Prices of the items players can sell==========--
	--------------------------------------------------------
	--First amount minimum price second maximum amount (the amount player will get is random between those two numbers)
	Config.FishPrice = 15 --Will get clean money THIS PRICE IS FOR EVERY 5 FISH ITEMS (5 kg)
	Config.TurtlePrice = 100 --Will get dirty money
	Config.SharkPrice = 300 --Will get dirty money

	--------------------------------------------------------
	--=====Locations where players can sell stuff========--
	--------------------------------------------------------

	Config.SellFish = {x = -3251.2, y = 991.5, z = 11.49} --Place where players can sell their fish
	Config.SellTurtle = {x = 3804.0, y = 4443.3, z = 3.0} --Place where players can sell their turtles 
	Config.SellShark = {x = 1302.31 , y = 4320.04, z = 37.22} --Place where players can sell their sharks

	--------------------------------------------------------
	--=====Locations where players can rent boats========--
	--------------------------------------------------------
Config.MarkerZones = { 
    {x = -3426.7   ,y = 955.66 ,z = 7.35, xs = -3426.2  , ys = 942.4, zs = 1.1 },
	{x = 3855.0        ,y =  4463.7 ,z = 1.6, xs = 3885.2 , ys =  4507.2, zs = 1.0 },
--[[ 	{x = 1330.8        ,y =  4226.6 ,z = 32.9, xs = 1334.2 , ys =  4192.4, zs = 30.0 },]]
}

Config.FishingZone = {x = 4435.21, y = 4829.60, z = 0.34}
Config.FishingZone2 = {x = -3744.35, y = 929.64, z = 0.34}

Config.deleteVehicleZones = { 
	{ x = 3848.35, y = 4480.70, z = 0 },
	{ x = -3438.81, y = 940.68, z = 0 },
}

--[[ Config.FishingZone3 = {x = 997.64, y = 3909.19, z = 29.00}]]