RegisterNetEvent('pw:notification:SendAlert')
AddEventHandler('pw:notification:SendAlert', function(data)
	SendAlert(data.type, data.text, data.length, data.style)
end)

RegisterNetEvent('pw:notification:SendUniqueAlert')
AddEventHandler('pw:notification:SendUniqueAlert', function(data)
	SendUniqueAlert(data.id, data.type, data.text, data.length, data.style)
end)


RegisterNetEvent('pw:notification:PersistentAlert')
AddEventHandler('pw:notification:PersistentAlert', function(data)
	PersistentAlert(data.action, data.id, data.type, data.text, data.style)
end)

function SendAlert(type, text, length, style)
	SendNUIMessage({
		type = type,
		text = text,
		length = length,
		style = style
	})
end

function SendUniqueAlert(id, type, text, length, style)
	SendNUIMessage({
		id = id,
		type = type,
		text = text,
		style = style
	})
end

function PersistentAlert(action, id, type, text, style)
	if action:upper() == 'START' then
		TriggerEvent('pw_base:addPersistentID', id)
		SendNUIMessage({
			persist = action,
			id = id,
			type = type,
			text = text,
			style = style
		})
	elseif action:upper() == 'END' then
		SendNUIMessage({
			persist = action,
			id = id
		})
	end
end