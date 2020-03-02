RegisterNetEvent("pw:progressbar:progress")
AddEventHandler("pw:progressbar:progress", function(action, finish)
	Process(action, nil, nil, finish)
end) 

RegisterNetEvent("pw:progressbar:ProgressWithStartEvent")
AddEventHandler("pw:progressbar:ProgressWithStartEvent", function(action, start, finish)
	Process(action, start, nil, finish)
end)

RegisterNetEvent("pw:progressbar:ProgressWithTickEvent")
AddEventHandler("pw:progressbar:ProgressWithTickEvent", function(action, tick, finish)
	Process(action, nil, tick, finish)
end)

RegisterNetEvent("pw:progressbar:ProgressWithStartAndTick")
AddEventHandler("pw:progressbar:ProgressWithStartAndTick", function(action, start, tick, finish)
	Process(action, start, tick, finish)
end)

RegisterNetEvent("pw:progressbar:cancel")
AddEventHandler("pw:progressbar:cancel", function()
	Cancel()
end)

RegisterNUICallback('actionFinish', function(data, cb)
	Finish()
end)