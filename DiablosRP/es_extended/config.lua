Config                      = {}
Config.Locale = 'en'

Config.Accounts             = { 'bank', 'black_money', 'diablo_coins' }
Config.AccountLabels        = { bank = _U('bank'), black_money = _U('black_money') ,diablo_coins='Moneda Donador'}

Config.EnableSocietyPayouts = false -- pay from the society account that the player is employed at? Requirement: esx_society
Config.DisableWantedLevel   = true
Config.EnableHud            = false -- enable the default hud? Display current job and accounts (black, bank & cash)

Config.PaycheckInterval     = 7 * 80000

Config.EnableDebug          = false


Config.MaxPlayers           = GetConvarInt('sv_maxclients', 255) -- set this value to 255 if you're running OneSync