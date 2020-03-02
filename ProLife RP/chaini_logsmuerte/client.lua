local log = {}
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
function openMenu()

	local elements = {}
	for i=1,#log,1 do
		--Citizen.Trace(log[i].fecha)
		local texto = "["..log[i].fecha.."]"..log[i].texto
		table.insert(elements,{label = texto, value = "yes"})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'get_job',
		{
			title  = 'LOGS',
			align    = 'bottom-right',
			elements = elements
		},
		function(data, menu)	
			if data.current.value == 'yes' then
			end
			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end
RegisterNetEvent('logskills:menu')
AddEventHandler('logskills:menu',function(data)
	log = data
	openMenu()


end)