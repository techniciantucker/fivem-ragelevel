local Keys = {
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

local PlayerData              = {}
local GUI                     = {}
local hasAlreadyEnteredMarker = false
local lastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}

ESX                           = nil
GUI.Time                      = 0

Citizen.CreateThread(function ()
  while ESX == nil do
    TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function (xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:fijarJobPop')
AddEventHandler('esx:fijarJobPop', function (job)
  PlayerData.job = job
end)

function OpenBankActionsMenu ()
  local elements = {
    { label = _U('customers'), value = 'customers' },
    { label = _U('billing'),   value = 'billing' },
  }

  if PlayerData.job.grade_name == 'boss' then
    table.insert(elements, { label = _U('boss_actions'), value = 'boss_actions' })
  end

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'bank_actions',
    {
      title    = _U('bank'),
      elements = elements,
    },
    function (data, menu)
      if data.current.value == 'customers' then
        OpenCustomersMenu()
      end

      if data.current.value == 'billing' then
        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'billing',
          {
            title = _U('bill_amount'),
          },
          function (data, menu)
            local amount = tonumber(data.value)

            if amount == nil then
              ESX.ShowNotification(_U('invalid_amount'))
            else
              menu.close()

              local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

              if closestPlayer == -1 or closestDistance > 5.0 then
                ESX.ShowNotification(_U('no_player_nearby'))
              else
                TriggerServerEvent('esx_billing:enviarBillPop', GetPlayerServerId(closestPlayer), 'society_banker', 'Banque', amount)
              end
            end
          end,
          function (data, menu)
            menu.close()
          end
        )

      end

      if data.current.value == 'boss_actions' then
        TriggerEvent('esx_society:openBostonisMenu', 'banker', function (data, menu)
          menu.close()
        end, {wash = false})
      end

    end,
    function (data, menu)
      menu.close()

      CurrentAction     = 'bank_actions_menu'
      CurrentActionMsg  = _U('press_input_context_to_open_menu')
      CurrentActionData = {}
    end
  )

end

function OpenCustomersMenu ()
  ESX.TriggerServerCallback('esx_bankerjob:getCustomers', function (customers)
    local elements = {
      head = { _U('customer'), _U('balance'), _U('actions') },
      rows = {}
    }

    for i=1, #customers, 1 do
      table.insert(elements.rows, {
        data = customers[i],
        cols = {
          customers[i].name,
          customers[i].bankSavings,
          '{{' .. _U('deposit') .. '|deposit}} {{' .. _U('withdraw') .. '|withdraw}}',
        }
      })
    end

    ESX.UI.Menu.Open(
      'list', GetCurrentResourceName(), 'customers',
      elements,
      function (data, menu)
        local customer = data.data

        if data.value == 'deposit' then
          menu.close()

          ESX.UI.Menu.Open(
            'dialog', GetCurrentResourceName(), 'customer_deposit_amount',
            {
              title = _U('amount'),
            },
            function (data2, menu)
              local amount = tonumber(data2.value)

              if amount == nil then
                ESX.ShowNotification(_U('invalid_amount'))
              else
                menu.close()

                TriggerServerEvent('esx_bankerjob:customerDeposit', customer.source, amount)

                OpenCustomersMenu()
              end
            end,
            function (data2, menu)
              menu.close()
              OpenCustomersMenu()
            end
          )
        end

        if data.value == 'withdraw' then
          menu.close()

          ESX.UI.Menu.Open(
            'dialog', GetCurrentResourceName(), 'customer_withdraw_amount',
            {
              title = _U('amount'),
            },
            function (data2, menu)
              local amount = tonumber(data2.value)

              if amount == nil then
                ESX.ShowNotification(_U('invalid_amount'))
              else
                menu.close()

                TriggerServerEvent('esx_bankerjob:customerWithdraw', customer.source, amount)

                OpenCustomersMenu()

              end
            end,
            function (data2, menu)
              menu.close()
              OpenCustomersMenu()
            end
          )

        end

      end,
      function (data, menu)
        menu.close()
      end
    )

  end)

end

AddEventHandler('esx_bankerjob:hasEnteredMarker', function (zone)
  if zone == 'BankActions' and PlayerData.job ~= nil and PlayerData.job.name == 'banker' then
    CurrentAction     = 'bank_actions_menu'
    CurrentActionMsg  = _U('press_input_context_to_open_menu')
    CurrentActionData = {}
  end
end)

AddEventHandler('esx_bankerjob:hasExitedMarker', function (zone)
  CurrentAction = nil
  ESX.UI.Menu.CloseAll()
end)


-- Create Blips
Citizen.CreateThread(function ()
  local blip = AddBlipForCoord(Config.Zones.BankActions.Pos.x, Config.Zones.BankActions.Pos.y, Config.Zones.BankActions.Pos.z)

  SetBlipSprite (blip, 108)
  SetBlipDisplay(blip, 4)
  SetBlipScale  (blip, 1.0)
  SetBlipColour (blip, 30)
  SetBlipAsShortRange(blip, true)

  BeginTextCommandSetBlipName('STRING')
  AddTextComponentString(_U('bank'))
  EndTextCommandSetBlipName(blip)
end)

-- Display markers
Citizen.CreateThread(function ()
  while true do
    Wait(0)

    local coords = GetEntityCoords(GetPlayerPed(-1))

    for k,v in pairs(Config.Zones) do
      if(PlayerData.job ~= nil and PlayerData.job.name == 'banker' and v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
        DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
      end
    end

  end
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function ()
  while true do
    Wait(0)

    if(PlayerData.job ~= nil and PlayerData.job.name == 'banker') then
      local coords      = GetEntityCoords(GetPlayerPed(-1))
      local isInMarker  = false
      local currentZone = nil

      for k,v in pairs(Config.Zones) do
        if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
          isInMarker  = true
          currentZone = k
        end
      end

      if isInMarker and not hasAlreadyEnteredMarker then
        hasAlreadyEnteredMarker = true
        lastZone                = currentZone
        TriggerEvent('esx_bankerjob:hasEnteredMarker', currentZone)
      end

      if not isInMarker and hasAlreadyEnteredMarker then
        hasAlreadyEnteredMarker = false
        TriggerEvent('esx_bankerjob:hasExitedMarker', lastZone)
      end
    end

  end
end)

-- Key Controls
Citizen.CreateThread(function ()
  while true do
    Citizen.Wait(0)

    if CurrentAction ~= nil then
      SetTextComponentFormat('STRING')
      AddTextComponentString(CurrentActionMsg)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)

      if IsControlPressed(0,  Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'banker' and (GetGameTimer() - GUI.Time) > 150 then
        if CurrentAction == 'bank_actions_menu' then
          OpenBankActionsMenu()
        end

        CurrentAction = nil
        GUI.Time      = GetGameTimer()
      end
    end

  end
end)
