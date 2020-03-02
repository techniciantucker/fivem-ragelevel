local group 

RegisterNetEvent('es_admin:setGroup')
AddEventHandler('es_admin:setGroup', function(g)
	print('group setted ' .. g)
	group = g
end)

RegisterNetEvent("textsent")
AddEventHandler('textsent', function(tPID, names2)
	TriggerEvent('chatMessage', "", {3, 252, 161}, " Respuesta enviada a:^0 " .. names2 .."  ".."^0  [ID " .. tPID .. "]")
end)

RegisterNetEvent("textmsg")
AddEventHandler('textmsg', function(source, textmsg, names2, names3 )
	TriggerEvent('chatMessage', "", {252, 140, 0}, "  ^*[Respuesta de /ayuda] " .. names3 .."".."^0: " .. textmsg)
end)
