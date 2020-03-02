ESX                   = nil
local PlayerData      = {}
local base64MoneyIcon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAOUSURBVDhPdVRbaBxVGP7PmdvObSe7k83GtPHS5KGVoJTQgtQH0YAIPggasKCI7YM1ZZFaioIPMQ8WLwkoKEhR8a3EtyIi4lOe6uVBrJK2YGyxWtPdTbLZ2+zOnJnjfzYnu7a7/Q7DOfNfvvlvZwgMwKuLs9Ogt1+AGH5hIbsRo4xqcRo496iiJlnlgW/fLXyysWN9O6jcb4Nl+TeoyY4MDbtfennrm2ze/jqddZY93/0s0VpvVKP1UWnah4GES3OfFsMKFIIoKGmqYZqGbdu6q3MOfxnEeDu3PXVVmvZhIKHAWP3Qz1vV8lLM4ySKIwhYs16pbp4dvnX4wsLCApNmfRhYw13MffjsEw1l/YKpO3bE2qUMTMwsnvz8klQPxF0jRJAGK46ahkNtwwXb9DJFtnrq9AcnRqR+IO5KOLf03ITpmCd8O58ihEDWyal7/H0vbVlXlt/6eO4+adaHgYRn3jvmNvT119K2f5gqSqcsDOuI0ZIRb89jN+H3LwrvvJzrGN8BRe5dzH41q7Dg76Ne2j/tmRlHoSrESQwcl6pooKsGaIp+/wa/vnfm8dnvLn5/MZKuHfQRPvrI5LRuKe/7zsi9hCokjkVDCaR0EyihINLXVV1s+0OjXHvq4PM/rKys8B3vO1I+efZFn6carw+5/gFF0QjHwRMwNAOJeqbi7Fm+xuL2maL760Ep7qBrNT8/T+vW9Wcca+hpU7OoCEGhCmiqjqmKR5OWO6Cow0blmsbGm4WPCoYU9wg3zT/GdN047qbS7m40BNewOwoT+QdhMj8F+0YOYNo7VRIfNHQL0P5JwsuHOkJElzCwyjOO6T78/0hS6DDuT2BTGCScwWhmHHLpe6QWnZHUxgA2ybWjUtQjJMCP6KppitMuDDUFFg413mdoRQFgoyFtZqRWQDTIAJXq01LQI1SIOoYfFKuLVtSEkLXQQUVDiuc2NNo1qZXo1Jqm5FuPENPaFg486U5AJ6q1W6uQ4ByK9DfrRShVb0otBoxTwOIQopgVpahHmAA/32zVak2MgPNESrFZSHL130vwZ/EyXCtdQeewIxdkIoBqs1IhCVnuCBHdwZ48Nr1GS821Fq+PJwnLYu6a6KSIV9wUcfVEpAmPIYzQqrUdbjc2LgdBsJjeGj//08pvbcHT9/s6tXQ8GyaVh2q0PKUp2n4sOnaBO5wQ/MHyEJ8a1vWfmLFVL9z7Yzjsrp175Zy8fgD/Ad/rU4g5OCscAAAAAElFTkSuQmCC'
local base64MoneyIcon2 = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAPnSURBVDhPjZRtbFNVGMf/p71d27WUdmvL1pU5wiADNticmWGCyWAzkgxiNAsomploiIlZYoKJX0iW+RI/6AeIJmZ+AI1RAooYiQuIY/hCptaJ6HQGdHRjdO06urJ2W3t77z0+57QsTBOzf3Jzn3tefud5O5dhmUoNbN5nV253RdPew2dvbjnrytg4z07pew9+slBYIrUsYHd3t3Jo59F3GIxnOecLDGyIdnLAnImo1YcqWy/8WFgKU+H9v6qqCiuMsaCw6W0n2DYytwN6W8CZ3CnG72hZQCmumwsWOPm2qNyt9qGTDzUWvpYHdISrDN2wqMIWMFXlmJs38mCuNW8uG/7suw/bt4r5ZQEnkaj+4vv6wPlQLYZHgxiPWqHmiMagETTCOAubOJMsRe74l2gR++rdDteaVeF1fleqSVPPt8QT9k2qrmA85kU8GUTDurC6ckXs9KRa+ebIWGB0cGLTLHDmv1XuO9JlfbD+UquVJR8Hz7YR3k2uWBiVVsyLMCfiJbh4eWO61IdH9rxwol9uLGhJyB8c2e/aXnfueSuivQR7gob8qQVzUey2wq5FrLg04kQ6Y8JqfwItjb8np+dLyKulWvTw2LFO21M1Px/kuVsvkjNu4clvY3Z89E0pIgkLtQswk1bw0qOTeGBDmpqQZ2ez3s7Stl9PFBBSshVEzoJT2i6baeZlgvnEmKoxHO334YerDjjthoRlcwzTKQUbghm4HYZiM2e9tfc9eerjvpDsACEZ8rmTz3g89rnn6NgyOUqymDkcNl3aRQqHlZ6aigwmE0U4E3LLA8nLjbXlf66XiwqSwErLWB2H1nQn8UImmtm3LSEh43ErFlSGPU1JvLp/Ah3NCXkgxeZb77v2duj4w2vzuwpAg2drKO4SOULSyLHwVBHMJo6u9hg8Dg053YRPBz2wWQyscmsyp3kHjK0NwZHDn/ceKBZ7JZAzVkGT0haKzljwxulyvH4qgCvXi2V4ZR4Vf8eseO+Cl5p6MRApzrUWjzNyr7DzEM4M+S5IeFC/Zh5XIza8P+BFVqNW8aowE2eUoClqnSXiKDYxk8ylnGHQhykj+QqQLFSAzh3TeHpHHLpB90tnGPrLAYXy1rh2Hg7rkvMlAMjK/6K8epcn7vmyxndjgLLXKr6FRGXbtsxilO6t26HD7dThd+XQWD0HW5EoSF7UcpxSecXEzL+I78VkfH187+rmisFX6De1m/K5pEDCw7shQgJE28XPNpTMrXztrW8f6+/p6aF47lJv7wFLnfNmQ13gxv3U5E3UaWXUPy4OZQWYYmH6QppQaSrvFIdxPYPyn/6I+i82dfTFyAk6APgHSpeHHhFJWFsAAAAASUVORK5CYII='
local base64MoneyIcon3 = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAPMSURBVDhPrVRbaBxVGP7OZfa+M9lLLm2amBCD1aTeInhBIX1INFKpgrWKL+INEURowSIiyz74IHnyTbAi4oMY1AfNs4hYrGApBamKpDG4jekme0t2dnYuZ8Z/dpeV0oJ96AfD7Jzzn+98//f//+Jmg/Xe/48A7O3TLw211T8Lusz9Xnz5s196O1fhhggLHzyvV1Mbi7WW+1qt6T80nBE/5RqPPLl8anmvF9KH6L2vi0KhEJl/df9cKVh7p2Kqk0qxGRVAM9vBASO/s/7zN3+d74X2cV2Fx1aOibF6c8oSzRcru/azYGzMSIFHNDpAJ+qhroD/NqVmFotvni51T3VxtULy6UT6uXyUlY5XbfP9eksdTSVYLqODSQ5crigIYkzGGMp1PydzFffepaUfzq2e83sM/xEuL59M3r2eX6yiXKzuOa9LLXLLoYkHhenZlEYLggiDgCMa6SbVajPGJT9kZCqzTzw1/+d3X124Eq6L0Ke54/E7S4k/3t1uNN9Syr8nq7NoMpHEyMAdpCaLqllBRLqIxziYEHADARkRaDk8VtvFbCrvlM98sfZ9SMi92y6+UmrXPqeNF/QUH8pnwGJRRtmbuLh1Bk37b0gpUG8L1FodEmgaQz7DsH8Q9Bts17QeKHxSiHUIm04907CCaU0ymYhztD0OSwnYXhS+66HcuEwpM4wYk9iXTWMkx5FOAk3TQ1QLsI9IW7Y/I9n6aIcw4Y5/lDf4rxFS1eiokFDgSCU4xvNpTA8NYTxzK+4bexRcjSLC0uRlWGkfphWAk6Wux0Za0dpdIaH48dvz5uGnJ61KUz0upBBcMLqVg3NFnWHDp6dhWYhpScQjcTQcskDzMGBIJMjTvRaVzGJMz7rO0vzC2U6VH1s4subFd+73EUwlU5xIBEybwaZmsDyfiuBi2yqhbm+hrTxaA2zVtSdgnArEmO3h9ojhGf3GPvXpkYd3VGVVMc0IqAicB2R6qLS7H6apHAMSA/BEWKh+61Hq1KNXfIwm9ZVeOBC7NHc2m0yc0CSaUZqIsWEOpRRMUyEeJbMpUpeTGIhMYM9knbXwllrVRVYHhnNdbX3CYrHoJTYPfJ1OskvheElJ1Wv52Cq7UCQmVLhZ34QUElGRohMMjuNjmwhdjwac4kP0CTuoT+zqmv6h4zG32ggwPKjh4HSMpoR1JkRPCfisjXjc6YQbusDswQRdRh3S7Cxd++dQ/PKZwxt2ebXtIGEkWd/DEKFSX0kISY3FSHIPDhWp2aKejOsr1xC+9/Ebg5ZoHCX7yMkbR3iv9OMb3a+bBuBf4At/C1PPPhEAAAAASUVORK5CYII='

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function EnableSocietyMoneyHUDElement()

	local societyMoneyHUDElementTpl = '<div><img src="' .. base64MoneyIcon .. '" style="width:20px; height:20px; vertical-align:middle;">&nbsp;{{money}}</div>'

	ESX.UI.HUD.RegisterElement('society_money', 3, 0, societyMoneyHUDElementTpl, {
		money = 0
	})

end

function EnableSociety2MoneyHUDElement()

  local society2MoneyHUDElementTpl = '<div><img src="' .. base64MoneyIcon2 .. '" style="width:20px; height:20px; vertical-align:middle;">&nbsp;{{money}}</div>'

  ESX.UI.HUD.RegisterElement('society2_money', 3, 0, society2MoneyHUDElementTpl, {
    money = 0
  })

end

function EnableSociety3MoneyHUDElement()

  local society3MoneyHUDElementTpl = '<div><img src="' .. base64MoneyIcon3 .. '" style="width:20px; height:20px; vertical-align:middle;">&nbsp;{{money}}</div>'

  ESX.UI.HUD.RegisterElement('society3_money', 3, 0, society3MoneyHUDElementTpl, {
    money = 0
  })

end

function DisableSocietyMoneyHUDElement()
	ESX.UI.HUD.RemoveElement('society_money')
end

function DisableSociety2MoneyHUDElement()
  ESX.UI.HUD.RemoveElement('society2_money')
end

function DisableSociety3MoneyHUDElement()
  ESX.UI.HUD.RemoveElement('society3_money')
end

function UpdateSocietyMoneyHUDElement(money)

	ESX.UI.HUD.UpdateElement('society_money', {
		money = money
	})

end

function UpdateSociety2MoneyHUDElement(money)

  ESX.UI.HUD.UpdateElement('society2_money', {
    money = money
  })

end

function UpdateSociety3MoneyHUDElement(money)

  ESX.UI.HUD.UpdateElement('society3_money', {
    money = money
  })

end

function OpenBossMenu(society, close, options)

	local options  = options or {}
	local elements = {}

	local defaultOptions = {
		withdraw  = true,
		deposit   = true,
		wash      = true,
		employees = true,
		grades    = true
	}

	for k,v in pairs(defaultOptions) do
		if options[k] == nil then
			options[k] = v
		end
	end

	if options.withdraw and PlayerData.job.grade_name == 'boss' or PlayerData.job2.grade_name == 'boss' or PlayerData.job3.grade_name == 'boss' then
		table.insert(elements, {label = _U('withdraw_society_money'), value = 'withdraw_society_money'})
	end

	if options.deposit and PlayerData.job.grade_name == 'boss' or PlayerData.job2.grade_name == 'boss' or PlayerData.job3.grade_name == 'boss' then
		table.insert(elements, {label = _U('deposit_society_money'), value = 'deposit_money'})
	end

	-- if options.wash and PlayerData.job.grade_name == 'boss' or PlayerData.job2.grade_name == 'boss' or PlayerData.job3.grade_name == 'boss' then
	-- 	table.insert(elements, {label = _U('wash_money'), value = 'wash_money'})
	-- end

	if options.employees and PlayerData.job.grade_name == 'boss' or PlayerData.job2.grade_name == 'boss' or PlayerData.job3.grade_name == 'boss' then
		table.insert(elements, {label = _U('employee_management'), value = 'manage_employees'})
	end
	
	if options.employees then
        table.insert(elements, {label = _U('secondary_employee_management'), value = 'secondary_manage_employees'})
	end

	-- if options.grades then
		-- table.insert(elements, {label = _U('salary_management'), value = 'manage_grades'})
	-- end

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'boss_actions_' .. society,
		{
      title    = 'Menu administrador sociedad',
      align    = 'top-left',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'withdraw_society_money' then

				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'withdraw_society_money_amount_' .. society,
					{
						title = _U('withdraw_amount')
					},
					function(data, menu)

						local amount = tonumber(data.value)

						if amount == nil then
							ESX.ShowNotification(_U('invalid_amount'))
						else
							menu.close()
							TriggerServerEvent('esx_society:withdrawMoney', society, amount)
						end

					end,
					function(data, menu)
						menu.close()
					end
				)

			end

			if data.current.value == 'deposit_money' then

				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'deposit_money_amount_' .. society,
					{
						title = _U('deposit_amount')
					},
					function(data, menu)

						local amount = tonumber(data.value)

						if amount == nil then
							ESX.ShowNotification(_U('invalid_amount'))
						else
							menu.close()
							TriggerServerEvent('esx_society:depositMoney', society, amount)
						end

					end,
					function(data, menu)
						menu.close()
					end
				)

			end

			if data.current.value == 'wash_money' then

				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'wash_money_amount_' .. society,
					{
						title = _U('wash_money_amount')
					},
					function(data, menu)

						local amount = tonumber(data.value)

						if amount == nil then
							ESX.ShowNotification(_U('invalid_amount'))
						else
							menu.close()
							TriggerServerEvent('esx_society:washMoney', society, amount)
						end

					end,
					function(data, menu)
						menu.close()
					end
				)

			end

			if data.current.value == 'manage_employees' then
				OpenManageEmployeesMenu(society)
			end
			
			if data.current.value == 'secondary_manage_employees' then
				OpenManageEmployeesMenu2(society)
			end
			
			if data.current.value == 'triple_manage_employees' then
				OpenManageEmployeesMenu3(society)
			end

			if data.current.value == 'manage_grades' then
				OpenManageGradesMenu(society)
			end
            
            if data.current.value == 'put_stock' then
					OpenPutStocksMenu()
            end	

            if data.current.value == 'get_stock' then
					OpenGetStocksMenu()
            end	

		end,
		function(data, menu)

			if close then
				close(data, menu)
			end

		end
	)

end

function OpenManageEmployeesMenu(society)

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'manage_employees_' .. society,
		{
			title    = _U('employee_management'),
			elements = {
				{label = _U('employee_list'), value = 'employee_list'},
				{label = _U('recruit'),       value = 'recruit'},
			}
		},
		function(data, menu)

			if data.current.value == 'employee_list' then
				OpenEmployeeList(society)
			end

			if data.current.value == 'recruit' then
				OpenRecruitMenu(society)
			end

		end,
		function(data, menu)
			menu.close()
		end
	)

end

function OpenManageEmployeesMenu2(society)

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'secondary_manage_employees_' .. society,
    {
      css      = 'patron',
	  title    = _U('secondary_employee_management'),
      elements = {
        {label = _U('employee_list'), value = 'employee_list'},
        {label = _U('recruit'),       value = 'recruit'},
      }
    },
    function(data, menu)

      if data.current.value == 'employee_list' then
        OpenEmployeeList2(society)
      end

      if data.current.value == 'recruit' then
        OpenRecruitMenu2(society)
      end

    end,
    function(data, menu)
      menu.close()
    end
  )

end

function OpenManageEmployeesMenu3(society)

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'triple_manage_employees_' .. society,
    {
      css      = 'patron',
	  title    = _U('triple_employee_management'),
      elements = {
        {label = _U('employee_list'), value = 'employee_list'},
        {label = _U('recruit'),       value = 'recruit'},
      }
    },
    function(data, menu)

      if data.current.value == 'employee_list' then
        OpenEmployeeList3(society)
      end

      if data.current.value == 'recruit' then
        OpenRecruitMenu3(society)
      end

    end,
    function(data, menu)
      menu.close()
    end
  )

end

function OpenEmployeeList(society)

  ESX.TriggerServerCallback('esx_society:getEmployees', function(employees)

    local elements = {
      head = {_U('employee'), _U('grade'), _U('actions'),'Principal o secundario'},
      rows = {}
    }

    for i=1, #employees, 1 do

      local gradeLabel = (employees[i].job.grade_label == '' and employees[i].job.label or employees[i].job.grade_label)

      table.insert(elements.rows, {
        data = employees[i],
        cols = {
          employees[i].name,
          gradeLabel,
          '{{' .. _U('promote') .. '|promote}} {{' .. _U('fire') .. '|fire}}',"Empleo principal"
        }
      })
    end

    ESX.UI.Menu.Open(
      'list', GetCurrentResourceName(), 'employee_list_' .. society,
      elements,
      function(data, menu)

        local employee = data.data

        if data.value == 'promote' then
          menu.close()
          OpenPromoteMenu(society, employee)
        end

        if data.value == 'fire' then

          TriggerEvent('esx:showNotification', _U('you_have_fired', employee.name))

          ESX.TriggerServerCallback('esx_society:setJob', function()
            OpenEmployeeList(society)
          end, employee.identifier, 'unemployed', 0, 'fire')

        end

      end,
      function(data, menu)
        menu.close()
        OpenManageEmployeesMenu(society)
      end
    )

  end, society)

end

function OpenEmployeeList2(society)

  ESX.TriggerServerCallback('esx_society:getEmployees2', function(employees)

    local elements = {
      head = {_U('employee'), _U('grade'), _U('actions'),'Principal o secundario'},
      rows = {}
    }

    for i=1, #employees, 1 do

      local gradeLabel = (employees[i].job2.grade_label == '' and employees[i].job2.label or employees[i].job2.grade_label)

      table.insert(elements.rows, {
        data = employees[i],
        cols = {
          employees[i].name,
          gradeLabel,
          '{{' .. _U('promote') .. '|promote}} {{' .. _U('fire') .. '|fire}}',"Empleo principal"
        }
      })
    end

    ESX.UI.Menu.Open(
      'list', GetCurrentResourceName(), 'employee_list_' .. society,
      elements,
      function(data, menu)

        local employee = data.data

        if data.value == 'promote' then
          menu.close()
          OpenPromoteMenu2(society, employee)
        end

        if data.value == 'fire' then

          TriggerEvent('esx:showNotification', _U('you_have_fired', employee.name))

          ESX.TriggerServerCallback('esx_society:setJob2', function()
            OpenEmployeeList2(society)
          end, employee.identifier, 'unemployed2', 0, 'fire')

        end

      end,
      function(data, menu)
        menu.close()
        OpenManageEmployeesMenu2(society)
      end
    )

  end, society)

end

function OpenEmployeeList3(society)

  ESX.TriggerServerCallback('esx_society:getEmployees3', function(employees)

    local elements = {
      head = {_U('employee'), _U('grade'), _U('actions'),'Principal ou Triple'},
      rows = {}
    }

    for i=1, #employees, 1 do

      local gradeLabel = (employees[i].job3.grade_label == '' and employees[i].job3.label or employees[i].job3.grade_label)

      table.insert(elements.rows, {
        data = employees[i],
        cols = {
          employees[i].name,
          gradeLabel,
          '{{' .. _U('promote') .. '|promote}} {{' .. _U('fire') .. '|fire}}',"Emploi Triple"
        }
      })
    end

    ESX.UI.Menu.Open(
      'list', GetCurrentResourceName(), 'employee_list_' .. society,
      elements,
      function(data, menu)

        local employee = data.data

        if data.value == 'promote' then
          menu.close()
          OpenPromoteMenu2(society, employee)
        end

        if data.value == 'fire' then

          TriggerEvent('esx:showNotification', _U('you_have_fired', employee.name))

          ESX.TriggerServerCallback('esx_society:setJob3', function()
            OpenEmployeeList3(society)
          end, employee.identifier, 'unemployed3', 0, 'fire')

        end

      end,
      function(data, menu)
        menu.close()
        OpenManageEmployeesMenu3(society)
      end
    )

  end, society)

end

function OpenRecruitMenu(society)

	ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)

		local elements = {}

		for i=1, #players, 1 do
			if players[i].job.name ~= society then
				table.insert(elements, {label = players[i].name, value = players[i].source, name = players[i].name, identifier = players[i].identifier})
		  end
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'recruit_' .. society,
			{
				title    = _U('recruiting'),
				elements = elements
			},
			function(data, menu)

				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'recruit_confirm_' .. society,
					{
            title    = _U('do_you_want_to_recruit', data.current.name),
            align    = 'top-left',
						elements = {
							{label = _U('yes'), value = 'yes'},
							{label = _U('no'),  value = 'no'},
						}
					},
					function(data2, menu2)

						menu2.close()

						if data2.current.value == 'yes' then

              TriggerEvent('esx:showNotification', _U('you_have_hired', data.current.name))

							ESX.TriggerServerCallback('esx_society:setJob', function()
								OpenRecruitMenu(society)
							end, data.current.identifier, society, 0, 'hire')

						end

					end,
					function(data2, menu2)
						menu2.close()
					end
				)

			end,
			function(data, menu)
				menu.close()
			end
		)

	end)

end

function OpenRecruitMenu2(society)

  ESX.TriggerServerCallback('esx_society:getOnlinePlayers2', function(players)

    local elements = {}

    for i=1, #players, 1 do
      if players[i].job2.name ~= society then
        table.insert(elements, {label = players[i].name, value = players[i].source, name = players[i].name, identifier = players[i].identifier})
      end
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'recruit_' .. society,
      {
        title    = _U('recruiting'),
        elements = elements
      },
      function(data, menu)

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'recruit_confirm_' .. society,
          {
            title    = _U('do_you_want_to_recruit', data.current.name),
            elements = {
              {label = _U('yes'), value = 'yes'},
              {label = _U('no'),  value = 'no'},
            }
          },
          function(data2, menu2)

            menu2.close()

            if data2.current.value == 'yes' then

              TriggerEvent('esx:showNotification', _U('you_have_hired', data.current.name))

              ESX.TriggerServerCallback('esx_society:setJob2', function()
                OpenRecruitMenu2(society)
              end, data.current.identifier, society, 0, 'hire')

            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenRecruitMenu3(society)

  ESX.TriggerServerCallback('esx_society:getOnlinePlayers3', function(players)

    local elements = {}

    for i=1, #players, 1 do
      if players[i].job3.name ~= society then
        table.insert(elements, {label = players[i].name, value = players[i].source, name = players[i].name, identifier = players[i].identifier})
      end
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'recruit_' .. society,
      {
        title    = _U('recruiting'),
        elements = elements
      },
      function(data, menu)

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'recruit_confirm_' .. society,
          {
            title    = _U('do_you_want_to_recruit', data.current.name),
            elements = {
              {label = _U('yes'), value = 'yes'},
              {label = _U('no'),  value = 'no'},
            }
          },
          function(data2, menu2)

            menu2.close()

            if data2.current.value == 'yes' then

              TriggerEvent('esx:showNotification', _U('you_have_hired', data.current.name))

              ESX.TriggerServerCallback('esx_society:setJob3', function()
                OpenRecruitMenu3(society)
              end, data.current.identifier, society, 0, 'hire')

            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenPromoteMenu(society, employee)

	ESX.TriggerServerCallback('esx_society:getJob', function(job)

		local elements = {}

		for i=1, #job.grades, 1 do
			local gradeLabel = (job.grades[i].label == '' and job.label or job.grades[i].label)
			table.insert(elements, {label = gradeLabel, value = job.grades[i].grade, selected = (employee.job.grade == job.grades[i].grade)})
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'promote_employee_' .. society,
			{
				title    = _U('promote_employee', employee.name),
				elements = elements
			},
			function(data, menu)
				menu.close()

        TriggerEvent('esx:showNotification', _U('you_have_promoted', employee.name, data.current.label))

				ESX.TriggerServerCallback('esx_society:setJob', function()
					OpenEmployeeList(society)
				end, employee.identifier, society, data.current.value, 'promote')

			end,
			function(data, menu)
				menu.close()
				OpenEmployeeList(society)
			end
		)

	end, society)

end

function OpenPromoteMenu2(society, employee)

  ESX.TriggerServerCallback('esx_society:getJob2', function(job2)

    local elements = {}

    for i=1, #job2.grades, 1 do
      local gradeLabel = (job2.grades[i].label == '' and job2.label or job2.grades[i].label)
      table.insert(elements, {label = gradeLabel, value = job2.grades[i].grade, selected = (employee.job2.grade == job2.grades[i].grade)})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'promote_employee_' .. society,
      {
        title    = _U('promote_employee', employee.name),
        elements = elements
      },
      function(data, menu)
        menu.close()

        TriggerEvent('esx:showNotification', _U('you_have_promoted', employee.name, data.current.label))

        ESX.TriggerServerCallback('esx_society:setJob2', function()
          OpenEmployeeList2(society)
        end, employee.identifier, society, data.current.value, 'promote')

      end,
      function(data, menu)
        menu.close()
        OpenEmployeeList2(society)
      end
    )

  end, society)

end

function OpenPromoteMenu3(society, employee)

  ESX.TriggerServerCallback('esx_society:getJob3', function(job3)

    local elements = {}

    for i=1, #job3.grades, 1 do
      local gradeLabel = (job3.grades[i].label == '' and job3.label or job3.grades[i].label)
      table.insert(elements, {label = gradeLabel, value = job3.grades[i].grade, selected = (employee.job3.grade == job3.grades[i].grade)})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'promote_employee_' .. society,
      {
        title    = _U('promote_employee', employee.name),
        elements = elements
      },
      function(data, menu)
        menu.close()

        TriggerEvent('esx:showNotification', _U('you_have_promoted', employee.name, data.current.label))

        ESX.TriggerServerCallback('esx_society:setJob3', function()
          OpenEmployeeList3(society)
        end, employee.identifier, society, data.current.value, 'promote')

      end,
      function(data, menu)
        menu.close()
        OpenEmployeeList3(society)
      end
    )

  end, society)

end

function OpenManageGradesMenu(society)

	ESX.TriggerServerCallback('esx_society:getJob', function(job)

		local elements = {}

		for i=1, #job.grades, 1 do
			local gradeLabel = (job.grades[i].label == '' and job.label or job.grades[i].label)
			table.insert(elements, {label = gradeLabel .. ' $' .. job.grades[i].salary, value = job.grades[i].grade})
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'manage_grades_' .. society,
			{
				title    = _U('salary_management'),
				elements = elements
			},
			function(data, menu)

				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'manage_grades_amount_' .. society,
					{
						title = _U('salary_amount')
					},
					function(data2, menu2)

						local amount = tonumber(data2.value)

						if amount == nil then
							ESX.ShowNotification(_U('invalid_amount'))
						else
							menu2.close()

							ESX.TriggerServerCallback('esx_society:setJobSalary', function()
								OpenManageGradesMenu(society)
							end, society, data.current.value, amount)
						end

					end,
					function(data2, menu2)
						menu2.close()
					end
				)

			end,
			function(data, menu)
				menu.close()
			end
		)

	end, society)

end

function OpenManageGradesMenu2(society)

  ESX.TriggerServerCallback('esx_society:getJob2', function(job2)

    local elements = {}

    for i=1, #job2.grades, 1 do
      local gradeLabel = (job2.grades[i].label == '' and job2.label or job2.grades[i].label)
      table.insert(elements, {label = gradeLabel .. ' $' .. job2.grades[i].salary, value = job2.grades[i].grade})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'manage_grades_' .. society,
      {
        title    = _U('salary_management'),
        elements = elements
      },
      function(data, menu)

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'manage_grades_amount_' .. society,
          {
            title = _U('salary_amount')
          },
          function(data2, menu2)

            local amount = tonumber(data2.value)

            if amount == nil then
              ESX.ShowNotification(_U('invalid_amount'))
            elseif amount >= Config.MaxSalary then
              ESX.ShowNotification(_U('invalid_amount_max'))
            else
              menu2.close()

              ESX.TriggerServerCallback('esx_society:setJobSalary2', function()
                OpenManageGradesMenu(society)
              end, society, data.current.value, amount)
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end, society)

end

function OpenManageGradesMenu3(society)

  ESX.TriggerServerCallback('esx_society:getJob3', function(job3)

    local elements = {}

    for i=1, #job3.grades, 1 do
      local gradeLabel = (job3.grades[i].label == '' and job3.label or job3.grades[i].label)
      table.insert(elements, {label = gradeLabel .. ' $' .. job3.grades[i].salary, value = job3.grades[i].grade})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'manage_grades_' .. society,
      {
        title    = _U('salary_management'),
        elements = elements
      },
      function(data, menu)

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'manage_grades_amount_' .. society,
          {
            title = _U('salary_amount')
          },
          function(data2, menu2)

            local amount = tonumber(data2.value)

            if amount == nil then
              ESX.ShowNotification(_U('invalid_amount'))
            elseif amount >= Config.MaxSalary then
              ESX.ShowNotification(_U('invalid_amount_max'))
            else
              menu2.close()

              ESX.TriggerServerCallback('esx_society:setJobSalary3', function()
                OpenManageGradesMenu(society)
              end, society, data.current.value, amount)
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end, society)

end

function OpenGetStocksMenu(society)

	ESX.TriggerServerCallback('esx_society:getStockItems', function(items,society)

		print(json.encode(items))

		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
		end

	  ESX.UI.Menu.Open(
	    'default', GetCurrentResourceName(), 'stocks_menu',
	    {
	      title    = 'Bucheron Stock',
	      elements = elements
	    },
	    function(data, menu)

	    	local itemName = data.current.value

				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
					{
						title = 'Quantité'
					},
					function(data2, menu2)

						local count = tonumber(data2.value)

						if count == nil then
							ESX.ShowNotification('Quantité invalide')
						else
							menu2.close()
				    	menu.close()
				    	OpenGetStocksMenu()

							TriggerServerEvent('esx_society:getStockItem', itemName, count,society)
						end

					end,
					function(data2, menu2)
						menu2.close()
					end
				)

	    end,
	    function(data, menu)
	    	menu.close()
	    end
	  )

	end)

end

function OpenPutStocksMenu(society)

ESX.TriggerServerCallback('esx_society:getPlayerInventory', function(inventory)

		local elements = {}

		for i=1, #inventory.items, 1 do

			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
			end

		end

	  ESX.UI.Menu.Open(
	    'default', GetCurrentResourceName(), 'stocks_menu',
	    {
	      title    = 'Inventaire',
	      elements = elements
	    },
	    function(data, menu)

	    	local itemName = data.current.value

				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
					{
						title = 'Quantité'
					},
					function(data2, menu2)

						local count = tonumber(data2.value)

						if count == nil then
							ESX.ShowNotification('Quantité invalide')
						else
							menu2.close()
				    	menu.close()
				    	OpenPutStocksMenu()

							TriggerServerEvent('esx_society:putStockItems', itemName, count,society)
						end

					end,
					function(data2, menu2)
						menu2.close()
					end
				)

	    end,
	    function(data, menu)
	    	menu.close()
	    end
	  )

	end)

end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  
  PlayerData = xPlayer

  if PlayerData.job.grade_name == 'boss' then
    
    EnableSocietyMoneyHUDElement()
  
    ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
      UpdateSocietyMoneyHUDElement(money)
    end, PlayerData.job.name)

  end

  if PlayerData.job2.grade_name == 'boss' then
    
    EnableSociety2MoneyHUDElement()
  
    ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
      UpdateSociety2MoneyHUDElement(money)
    end, PlayerData.job2.name)
  end

  if PlayerData.job3.grade_name == 'boss' then
    
    EnableSociety3MoneyHUDElement()
  
    ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
      UpdateSociety3MoneyHUDElement(money)
    end, PlayerData.job3.name)
  end	  

end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)

  PlayerData.job = job
	EnableSocietyMoneyHUDElement()
    DisableSocietyMoneyHUDElement()

  if PlayerData.job.grade_name == 'boss' then
    
    EnableSocietyMoneyHUDElement()
  
    ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
      UpdateSocietyMoneyHUDElement(money)
    end, PlayerData.job.name)

  end

end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)

  PlayerData.job2 = job2

	EnableSociety2MoneyHUDElement()
    DisableSociety2MoneyHUDElement()


  if PlayerData.job2.grade_name == 'boss' then
    
    EnableSociety2MoneyHUDElement()
  
    ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
      UpdateSociety2MoneyHUDElement(money)
    end, PlayerData.job2.name)

  end

end)

RegisterNetEvent('esx:setJob3')
AddEventHandler('esx:setJob3', function(job3)

  PlayerData.job3 = job3

	EnableSociety3MoneyHUDElement()
    DisableSociety3MoneyHUDElement()


  if PlayerData.job3.grade_name == 'boss' then
    
    EnableSociety3MoneyHUDElement()
  
    ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
      UpdateSociety3MoneyHUDElement(money)
    end, PlayerData.job3.name)

  end

end)

RegisterNetEvent('esx_addonaccount:setMoney')
AddEventHandler('esx_addonaccount:setMoney', function(society, money)

  if PlayerData.job ~= nil and PlayerData.job.grade_name == 'boss' and 'society_' .. PlayerData.job.name == society then
    UpdateSocietyMoneyHUDElement(money)
  end
  
  if PlayerData.job2 ~= nil and PlayerData.job2.grade_name == 'boss' and 'society_' .. PlayerData.job2.name == society then
    UpdateSociety2MoneyHUDElement(money)
  end
  
  if PlayerData.job3 ~= nil and PlayerData.job3.grade_name == 'boss' and 'society_' .. PlayerData.job3.name == society then
    UpdateSociety3MoneyHUDElement(money)
  end

end)

AddEventHandler('esx_society:openBossMenu', function(society, close, options)
  OpenBossMenu(society, close, options)
end)
