Config = {}
Config.Locale = 'es'

Config.Price = 400

Config.DrawDistance = 100.0
Config.MarkerSize   = {x = 1.5, y = 1.5, z = 1.0}
Config.MarkerColor  = {r = 102, g = 102, b = 204}
Config.MarkerType   = 1

Config.Zones = {}

Config.Shops = {
	{x=123.29,    y=-220.87,  z=53.56},
	{x=-711.07,    y=-151.83,  z=36.42},
	{x=428.15,	y=-800.22,	z=28.49}
}

for i=1, #Config.Shops, 1 do

	Config.Zones['Shop_' .. i] = {
	 	Pos   = Config.Shops[i],
	 	Size  = Config.MarkerSize,
	 	Color = Config.MarkerColor,
	 	Type  = Config.MarkerType
  }

end
