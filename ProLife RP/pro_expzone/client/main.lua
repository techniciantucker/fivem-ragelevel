ESX = nil
local isInArea = false
local actualTime = 0

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
  end)

print('hola')

Citizen.CreateThread(function()
    while ESX == nil do Citizen.Wait(0) end

    while true do
        
        
        local lastInArea = isInArea
        local index = nil

        isInArea = IsInArea()

        if lastInArea == isInArea and isInArea == false then

        elseif lastInArea == isInArea and isInArea == true then
            index = GetIndexOfArea()
            actualTime = actualTime + 1
        elseif lastInArea == false and isInArea == true then
            ESX.ShowNotification('Has entrado a una zona de rol, cada cierto tiempo te dará experiencia por rolear en esta zona.')
            index = GetIndexOfArea()
            actualTime = actualTime + 1
        elseif lastInArea == true and isInArea == false then
            ESX.ShowNotification('Has salido de la zona de rol.')
            actualTime = 0
        end

        if Config.SecondsForExp <= actualTime then
            TriggerServerEvent('exp:addExperience',Config.Zones[index].exp)
            actualTime = 0
        end

        Citizen.Wait(1000)
    end
end)


--FUNCIONES

Get3DDistance = function(x1, y1, z1, x2, y2, z2)
	local a = (x1 - x2) * (x1 - x2)
	local b = (y1 - y2) * (y1 - y2)
	local c = (z1 - z2) * (z1 - z2)
    return math.sqrt(a + b + c)
end

IsInArea = function()
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)

    for i,v in ipairs(Config.Zones) do
        if Get3DDistance(coords.x, coords.y, coords.z, v.x, v.y, v.z) < v.radio then
            return true
        end
    end
    return false
end

GetIndexOfArea = function()
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)

    for i,v in ipairs(Config.Zones) do
        if Get3DDistance(coords.x, coords.y, coords.z, v.x, v.y, v.z) then
            return i
        end
    end
    return false
end