local listOn = false

Citizen.CreateThread(function()
    listOn = false
    while true do
        Wait(0)

        if IsControlPressed(0, 164)--[[ INPUT_PHONE ]] then
            if not listOn then
                local players = {}
                ptable = GetPlayers()
                for _, i in ipairs(ptable) do
                    local wantedLevel = GetPlayerWantedLevel(i)
                    local playerjob = GetPlayerWantedLevel(i)
                    r, g, b = GetPlayerRgbColour(i)
                    table.insert(players, 
                    '<tr style=\"color: rgb(' .. 255 .. ', ' .. 255 .. ', ' .. 255 .. ')\"><td>' .. GetPlayerServerId(i) .. '</td><td>' .. GetPlayerName(i) .. '</td> '
                    )
                end
                
                SendNUIMessage({ text = table.concat(players) })
 
                listOn = true
                while listOn do
                    Wait(0)
                    if(IsControlPressed(0, 164) == false) then
                        listOn = false
                        SendNUIMessage({
                            meta = 'close'
                        })
                        break
                    end
                end
            end
        end
    end
end)

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end