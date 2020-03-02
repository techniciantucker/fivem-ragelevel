Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX          = nil
local IsDead = false
local IsAnimated = false
local IsAlreadyDrunk = false
local DrunkLevel     = -1

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

locksound = false
local pillused = true

RegisterNetEvent('dix-oblivionpill:piluleoubli')
AddEventHandler('dix-oblivionpill:piluleoubli', function()
	pillused = true
Citizen.CreateThread(function()
   while true do
       Citizen.Wait(0)      
			if pillused == true then
				
				if not IsAnimated then
					prop_name = prop_name or 'prop_cs_pills'
					IsAnimated = true
			
					Citizen.CreateThread(function()
						local playerPed = PlayerPedId()
						local x,y,z = table.unpack(GetEntityCoords(playerPed))
						local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
						local boneIndex = GetPedBoneIndex(playerPed, 18905)
						AttachEntityToEntity(prop, playerPed, boneIndex, 0.11, 0.045, 0.02, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
			
						ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
							TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
			
							Citizen.Wait(3000)
							IsAnimated = false
							ClearPedSecondaryTask(playerPed)
							DeleteObject(prop)
						end)
					end)
			
				end
				Citizen.Wait(1700)
					StartScreenEffect("DeathFailOut", 0, 0)
					if not locksound then
                    PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)
					locksound = true
					pillused = true
					end
					ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
					
					local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")

					if HasScaleformMovieLoaded(scaleform) then
				
						Citizen.Wait(0)

						PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
						BeginTextComponent("STRING")
						AddTextComponentString(_U('fall_oubli'))
						EndTextComponent()
						PopScaleformMovieFunctionVoid()

						Citizen.Wait(100)
						PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)
							
							while pillused == true do
							DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
							SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
							DisableAllControlActions(0)
							EnableControlAction(0, Keys['LEFTSHIFT'], true)
							EnableControlAction(0, Keys['G'], true)
							EnableControlAction(0, Keys['T'], true)
							EnableControlAction(0, Keys['E'], true)
							EnableControlAction(0, Keys['L'], true)
							EnableControlAction(0, Keys['ENTER'], true)
							EnableControlAction(0, Keys['BACKSPACE'], true)
							EnableControlAction(0, Keys['TOP'], true)
							EnableControlAction(0, Keys['DOWN'], true)
							Citizen.Wait(0)
							end

						StopScreenEffect("DeathFailOut")
						locksound = false
					end
			end
		end
	end)
end)

RegisterNetEvent('dix-oblivionpill:stoppill')
AddEventHandler('dix-oblivionpill:stoppill', function()
        stopPill()
end)

function stopPill()
    pillused = false
end
