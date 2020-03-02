local blips_client = {}
local blips_server = {}

function enableBlips(service)

  for k, existing in pairs(blips_client) do
    RemoveBlip(existing)
  end
  blips_client = {}
  
  local localIdCops = {}
  local localidService = {}
  local localidName = {}
  for id = 0, 256 do
    if(NetworkIsPlayerActive(id)) then
      for i,c in pairs(blips_server) do
        if(i == GetPlayerServerId(id)) then
          localIdCops[id] = c.id
          localidService[id] = c.service
          localidName[id] = c.name
          break
        end
      end
    end
  end
  
  for id, c in pairs(localIdCops) do
    local ped = GetPlayerPed(id)
    local blip = GetBlipFromEntity(ped)
    
    if not DoesBlipExist( blip ) then

      blip = AddBlipForEntity( ped )
      SetBlipSprite( blip, 1 )
      Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true )
      HideNumberOnBlip(blip)
      
      SetBlipScale(blip,  0.8)
      SetBlipAlpha(blip, 255)
      if localidService[id] == "ems" then
        SetBlipColour(blip, 49)
      elseif localidService[id] == "police" then
        SetBlipColour(blip, 67)
      end
      BeginTextCommandSetBlipName("STRING")
      if localidService[id] == "ems" then
        AddTextComponentString('EMS Unit: '..localidName[id])
      elseif localidService[id] == "police" then
        AddTextComponentString('Police Unit: '..localidName[id])
      end
      EndTextCommandSetBlipName(blip)
      
      table.insert(blips_client, blip)
    else
      
      blipSprite = GetBlipSprite(blip)
      
      HideNumberOnBlip( blip )
      if blipSprite ~= 1 then
        SetBlipSprite( blip, 1 )
        Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true )
      end

      SetBlipScale(blip,  0.8)
      SetBlipAlpha(blip, 255)
      SetBlipColour(blip, 49)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString('Unit ID: '..GetPlayerServerId(id))
      EndTextCommandSetBlipName(blip)
      
      table.insert(blips_client, blip)
    end
  end
end

RegisterNetEvent("blips:remove")
AddEventHandler("blips:remove", function()
  blips_server = {}
  for _, existing in pairs(blips_client) do
    RemoveBlip(existing)
  end
end)

RegisterNetEvent("blips:sync")
AddEventHandler("blips:sync", function(tbl)
 blips_server = tbl
 if DecorGetBool(GetPlayerPed(-1), "isParamedic") or DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  enableBlips()
 end
end)


