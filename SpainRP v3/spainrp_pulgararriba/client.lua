-------------------usage : Delete Key-----------------------
Citizen.CreateThread(function()
local dict = "anim@mp_player_intincarthumbs_upbodhi@ps@"
    
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(10)
	                    end
    local thumbsup = false
	while true do
    Citizen.Wait(10)
    local lPed = GetPlayerPed(-1)
    if not IsPedInAnyVehicle(lPed, false) and not IsPedSwimming(lPed) and not IsPedShooting(lPed) and not IsPedClimbing(lPed) and not IsPedCuffed(lPed) and not IsPedDiving(lPed) and not IsPedFalling(lPed) and not IsPedJumping(lPed) and not IsPedJumpingOutOfVehicle(lPed) and IsPedOnFoot(lPed) and not IsPedRunning(lPed) and not IsPedUsingAnyScenario(lPed) and not IsPedInParachuteFreeFall(lPed) then
		if IsControlJustPressed(1, 301) then 
            if not thumbsup then
                TaskPlayAnim(GetPlayerPed(-1), dict, "enter", 8.0, 8.0, -1, 50, 0, false, false, false)
                thumbsup = true
            else
                thumbsup = false
                ClearPedTasks(GetPlayerPed(-1))
            end
        end
    end end
  end)


local ragdoll = false
function setRagdoll(flag)
  ragdoll = flag
end
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if ragdoll then
      SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
    end
  end
end)

ragdol = true
RegisterNetEvent("suelo")
AddEventHandler("suelo", function()
	if ( ragdol ) then
		setRagdoll(true)
		ragdol = false
	else
		setRagdoll(false)
		ragdol = true
	end
end)

RegisterCommand("suelo", function(source, args, raw) --change command here
    TriggerEvent("suelo")
end, false) --False, allow everyone to run it(thnx @Havoc)