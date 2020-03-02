Config = {}

Config.Map = {
  {name="Coke Farm",       color=6, scale=0.8, id=403, x=2145.9228515625,  y=4778.8076171875,  z=40.253701019287},
  {name="Coke Treatment",  color=6, scale=0.8, id=403, x=-458.13967895508, y=-2278.6174316406, z=7.5158290863037},
  {name="Coke Sales",      color=6, scale=0.8, id=403, x=-1756.1984863281, y=427.31674194336,  z=126.68292999268},
}

Config.Locale = 'en'

Config.Delays = {
	WeedProcessing = 1000 * 10
}

Config.DrugDealerItems = {
	marijuana = 350
}

Config.LicenseEnable = false -- enable processing licenses? The player will be required to buy a license in order to process drugs. Requires esx_license

Config.LicensePrices = {
	weed_processing = {label = _U('license_weed'), price = 15000}
}

Config.GiveBlack = true -- give black money? if disabled it'll give regular cash.

Config.CircleZones = {
	WeedField = {coords = vector3(310.91, 4290.87, 45.15), name = _U('blip_weedfield'), color = 25, sprite = 496, radius = 100.0},
	WeedProcessing = {coords = vector3(2329.02, 2571.29, 46.68), name = _U('blip_weedprocessing'), color = 25, sprite = 496, radius = 100.0},

	DrugDealer = {coords = vector3(-1172.02, -1571.98, 4.66), name = _U('blip_drugdealer'), color = 6, sprite = 378, radius = 25.0},
}