-- CONFIG --

-- Blacklisted weapons
weaponblacklist = {
  "WEAPON_HAMMER",
  "WEAPON_GOLFCLUB",
  "WEAPON_CROWBAR",
  "WEAPON_COMBATMG",
  "WEAPON_PUMPSHOTGUN",
  "WEAPON_SAWNOFFSHOTGUN",
  "WEAPON_ASSAULTSHOTGUN",
  "WEAPON_BULLPUPSHOTGUN",
  "WEAPON_GRENADELAUNCHER",
  "WEAPON_GRENADELAUNCHER_SMOKE",
  "WEAPON_RPG",
  "WEAPON_STINGER",
  "WEAPON_MINIGUN",
  "WEAPON_GRENADE",
  "WEAPON_BALL",
  "WEAPON_BOTTLE",
  "WEAPON_GUSENBERG",
  "WEAPON_BULLPUPRIFLE",
  "WEAPON_DAGGER",
  "WEAPON_MUSKET",
  "WEAPON_HEAVYSHOTGUN",
  "WEAPON_MARKSMANRIFLE",
  "WEAPON_FLAREGUN",
  "WEAPON_GARBAGEBAG",
  "WEAPON_MARKSMANPISTOL",
  "WEAPON_KNUCKLE",
  "WEAPON_RAILGUN",
  "WEAPON_MACHETE",
  "WEAPON_SNOWBALL"
	}
-- Don't allow any weapons at all (overrides the blacklist)
disableallweapons = false

-- CODE --

Citizen.CreateThread(function()
	while true do
		Wait(1)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			nothing, weapon = GetCurrentPedWeapon(playerPed, true)
			if disableallweapons then
				RemoveAllPedWeapons(playerPed, true)
			else
				if isWeaponBlacklisted(weapon) then
					SetEntityAsMissionEntity( weapon, true, true )
					RemoveWeaponFromPed(playerPed, weapon)
					sendForbiddenMessage("Arma en lista negra")
				end
			end
		end
	end
end)

function isWeaponBlacklisted(model)
	for _, blacklistedWeapon in pairs(weaponblacklist) do
		if model == GetHashKey(blacklistedWeapon) or model == 2210333304 then
			return true
		end
	end

	return false
end