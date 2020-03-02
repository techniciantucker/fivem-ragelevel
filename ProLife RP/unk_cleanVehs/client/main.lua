--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--===================--
--==   Variables   ==--
--===================--

local entityEnumerator = {
    __gc = function(enum)
      if enum.destructor and enum.handle then
        enum.destructor(enum.handle)
      end
      enum.destructor = nil
      enum.handle = nil
    end
}
  
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--===================--
--==   Funciones   ==--
--===================--

function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end
      
        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)

        local next = true
        repeat
        coroutine.yield(id)
        next, id = moveFunc(iter)
        until not next
        
        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end
  
function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function deleteSpawnedCar(vehicle)   
    if DoesEntityExist(vehicle) then 
        SetEntityAsMissionEntity(vehicle, true, true)
        deleteCar(vehicle)  
    end     
end

function deleteCar(entity)
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(entity))
end
  
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--===================--
--==    Eventos    ==--
--===================--

RegisterNetEvent("unk_deleteallcars:normalClean")
AddEventHandler("unk_deleteallcars:normalClean", function()
    for veh in EnumerateVehicles() do 
        local fuel = math.floor(GetVehicleFuelLevel(veh))
        if (GetVehicleEngineHealth(veh) <= 100.0) or (IsVehicleSeatFree(veh, -1) and fuel <= 4) then 
            deleteSpawnedCar(veh) 
        end
    end 
end)

RegisterNetEvent("unk_deleteallcars:forcedClean")
AddEventHandler("unk_deleteallcars:forcedClean", function()
    for veh in EnumerateVehicles() do 
        if (IsVehicleSeatFree(veh, -1)) then 
            deleteSpawnedCar(veh) 
        end
    end 
end)

RegisterNetEvent("unk_deleteallcars:superforcedClean")
AddEventHandler("unk_deleteallcars:superforcedClean", function()
    for veh in EnumerateVehicles() do 
        deleteSpawnedCar(veh) 
    end 
end)

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
