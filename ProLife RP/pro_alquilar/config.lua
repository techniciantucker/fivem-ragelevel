Config                            = {}
Config.Locale                     = 'es'

--- #### BASICO
Config.EnablePrice = true -- false = bikes for free
Config.EnableEffects = false
Config.EnableBlips = true


--- #### PRECIOS
Config.PriceTriBike = 5000
Config.PriceScorcher = 99
Config.PriceCruiser = 129
Config.PriceSeashark = 20000


--- #### BLIPS
Config.TypeMarker = 27
Config.MarkerScale = {{x = 2.000,y = 2.000,z = 0.500}}
Config.MarkerColor = {{r = 0,g = 255,b = 255}}
	
Config.MarkerZones = { 

    {x = -378.71,y = 6516.26,z = 0.23},

}


-- Edita el blip
Config.BlipZones = { 

   {title="Alquiler marítimo", colour=2, id=316, x = -378.71, y = 6516.26, z = 0.23},
}
