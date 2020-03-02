Config	=	{}

 -- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Limit = 15000

-- Default weight for an item:
	-- weight == 0 : The item do not affect character inventory weight
	-- weight > 0 : The item cost place on inventory
	-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 0 

-- WIP Holding more and more stuff make you slower and slower (Do not work at this time.. Try some native, look at client/main.lua)
Config.userSpeed = false

-- TODO, see server/main.lua
--Config.Config.BagIsSkin = true

-- If true, ignore rest of file
Config.WeightSqlBased = true

-- I Prefer to edit weight on the config.lua and I have switched Config.WeightSqlBased to false:
Config.localWeight = {
}