local ragdoll = false

function setRagdoll(flag)
	ragdoll = flag
end

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(100)
	if ragdoll then
		SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
	end
  end
end)

ragdol = true

RegisterNetEvent("Ragdoll")
AddEventHandler("Ragdoll", function()
	if (ragdol) then
	    ExecuteCommand ("me se cae al suelo")
		setRagdoll(true)
		ragdol = false
	else
	    ExecuteCommand ("me se levanta")
		setRagdoll(false)
		ragdol = true
	end
end)

RegisterCommand("suelo", function(source, args, raw)
    TriggerEvent("Ragdoll")
end, false)
