local tattooSpots = {
  {x = 323.034, y = 180.827, z = 103.586}, --/teleport 323 180 103
  {x = 1322.673, y = -1652.951, z = 52.275} --/teleport 1322 -1652 52.275
}
local tatCamCoords = {
  {cx = 321.138, cy = 180.023, cz = 103.586, px = 322.804, py = 180.677, pz = 103.586, hf = 108.129, hb = 283.646, hr = 191.304, hl = 8.56},
  {cx = 1322.781, cy = -1650.459, cz = 52.274, px = 1322.595, py = -1652.894, pz = 52.275, hf = 346.805, hb = 166.471, hr = 76.461, hl = 257.113}
}

local blips = {}
local lastTatSpot = 0
local blockInput = false
local curCategory = 1
local tatShopShowing = false
local shopCam = -1
local appliedTattoos = {}

function setupTattooBlips()
  for _,v in pairs(tattooSpots) do
    local blip = AddBlipForCoord(v.x, v.y, v.z)
    SetBlipSprite(blip, 75)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.6)
    SetBlipColour(blip, 19)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Tattoo Shop")
    EndTextCommandSetBlipName(blip)
    table.insert(blips, blip)
  end
end

function setupCamera(enable)
  if (enable) then
    local ped = GetPlayerPed(-1)
    
    if (shopCam == -1) then
      shopCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", tatCamCoords[lastTatSpot].cx, tatCamCoords[lastTatSpot].cy, tatCamCoords[lastTatSpot].cz, 0, 0, 0, GetGameplayCamFov(), 0, 0)
    end

    SetCamActive(shopCam, true)
    RenderScriptCams(1, 0, 3000, 1, 0)
    
    local ped = GetPlayerPed(-1)
  
    SetEntityHeading(ped, tatCamCoords[lastTatSpot].hf)
    PointCamAtEntity(shopCam, ped, 0, 0, 0, 0)
    
    tatShopShowing = true
    SetNuiFocus(true, true)
    
    SendNUIMessage({
      showShop = true
    })
    if(GetEntityModel(GetPlayerPed(-1)) == -1667301416) then  -- GIRL SKIN
     SetPedComponentVariation(GetPlayerPed(-1), 8, 34,0, 2)
     SetPedComponentVariation(GetPlayerPed(-1), 3, 15,0, 2)
     SetPedComponentVariation(GetPlayerPed(-1), 11, 101,1, 2)
     SetPedComponentVariation(GetPlayerPed(-1), 4, 56,1, 2)
     SetPedComponentVariation(GetPlayerPed(-1), 6, 35,0, 2)
    else                             -- BOY SKIN
     SetPedComponentVariation(GetPlayerPed(-1), 8, 15,0, 2)
     SetPedComponentVariation(GetPlayerPed(-1), 3, 15,0, 2)
     SetPedComponentVariation(GetPlayerPed(-1), 11, 91,0, 2)
     SetPedComponentVariation(GetPlayerPed(-1), 4, 21,0, 2)
     SetPedComponentVariation(GetPlayerPed(-1), 6, 34,0, 2)
    end
    
  else
    if (shopCam > -1) then
      if (IsCamActive(shopCam)) then
        RenderScriptCams(0, 0, 3000, 1, 0)
        shopCam = -1
      end
    end
  end
end

function tattooExistsForPed(hash)
  local exists = false
  
  for _,v in pairs(appliedTattoos) do
    if (v.hash == hash) then
      exists = true
    end
  end
  
  return exists
end

function addTattooForPed(hash, col, cat, name)
  if (not tattooExistsForPed(hash)) then
    local tat = {hash = hash, col = col, cat = cat, name = name}
    
    table.insert(appliedTattoos, tat)
    SetPedDecoration(GetPlayerPed(-1), GetHashKey(col), GetHashKey(hash))
  end
end

function removeTattooFromPed(hash)
  local remidx = 0
  
  if (tattooExistsForPed(hash)) then
    for i,v in ipairs(appliedTattoos) do
      if (v.hash == hash) then
        remidx = i
        break
      end
    end
  end
  
  if (remidx > 0) then
    table.remove(appliedTattoos, remidx)
  end
end

function refreshTattoos()
  local ped = GetPlayerPed(-1)
  ClearPedDecorations(ped)
  
  for _,v in pairs(appliedTattoos) do
    SetPedDecoration(ped, GetHashKey(v.col), GetHashKey(v.hash))
  end
end

function loadPlayerTattoos(tattoos)
  if (tattoos) then
    local ped = GetPlayerPed(-1)
    
    appliedTattoos = tattoos
    refreshTattoos()
  end
end

RegisterNetEvent("tattoo:setTattoos")
AddEventHandler("tattoo:setTattoos", function(tats)
  loadPlayerTattoos(tats)
end)

RegisterNetEvent("tattoos:setTattoosForCat")
AddEventHandler("tattoos:setTattoosForCat", function(tats)
  if (tats) then
    local tatStr = ""
    
    for _,v in pairs(tats) do
      tatStr = tatStr .. "<div class='tatoption'>" .. v.name .. "</div>"
    end
    
    SendNUIMessage({
      setTatNames = true,
      tatNames = tatStr
    })
  end
end)

RegisterNetEvent("tattoos:setTattooData")
AddEventHandler("tattoos:setTattooData", function(tat)
  if (tat) then
    local ped = GetPlayerPed(-1)
    addTattooForPed(tat.hash, tat.col, tat.category, tat.name)
        
    local facing = tat.facing
    
    if (facing == 1) then
      SetEntityHeading(ped, tatCamCoords[lastTatSpot].hf)
    elseif (facing == 2) then
      SetEntityHeading(ped, tatCamCoords[lastTatSpot].hb)
    elseif (facing == 3) then
      SetEntityHeading(ped, tatCamCoords[lastTatSpot].hl)
    elseif (facing == 4) then
      SetEntityHeading(ped, tatCamCoords[lastTatSpot].hr)
    end
  end
end)

RegisterNUICallback("setTatCategory", function(data, cb)
  local cat = tonumber(data.cat)
  
  if (cat) then
    curCategory = cat
  end
  
  local mhash = GetEntityModel(GetPlayerPed(-1))
  
  local gender = 1
  
  if (mhash ~= 1885233650) then
    gender = 2
  end
  TriggerServerEvent("tattoos:getTattoosForCategory", curCategory, gender)
  cb("ok")
end)

RegisterNUICallback("setTattooPrev", function(data, cb)
  local name = data.name
  local ped = GetPlayerPed(-1)
  
  if (name) then
    local mhash = GetEntityModel(GetPlayerPed(-1))
    local gender = 1
    
    if (mhash ~= 1885233650) then
      gender = 2
    end
    
    TriggerServerEvent("tattoos:requestTattooData", name, gender)
  end
  
  cb("ok")
end)

RegisterNUICallback("escape", function(data, cb)
  tatShopShowing = false
  SetNuiFocus(false, false)
  FreezeEntityPosition(GetPlayerPed(-1), false)
  blockInput = false
  setupCamera(false)
  cb("ok")
  ExecuteCommand('clothes')
end)

RegisterNUICallback("resetTatForPart", function(data, cb)
  local cat = tonumber(data.cat)
  local catname = data.catname
  local ped = GetPlayerPed(-1)
  --local cid = 1
  local remidxs = {}  
  if (#appliedTattoos > 0) then
    if (cat) then
      for i = 1, #appliedTattoos do
        if (appliedTattoos[i].cat == cat) then
          table.insert(remidxs, i)
        end
      end
      
      for i = #remidxs, 1, -1 do
        local v = remidxs[i]
        table.remove(appliedTattoos, v)
      end
      
      refreshTattoos()
      exports.pNotify:SendNotification({text = "Tattoos removed for " .. catname, layout = "bottomRight"})
    end
  end
  cb("ok")
end)

RegisterNUICallback("resetAllTattoos", function(data, cb)
  local ped = GetPlayerPed(-1)
  ClearPedDecorations(ped)
  appliedTattoos = {}
  --exports.pNotify:SendNotification({text = "Todos los tatuajes han sido eliminados.."})
    exports['clrp_notify']:DoLongHudText('inform', 'Todos los tatuajes han sido eliminados.')
end)

RegisterNUICallback("saveTattoos", function(data, cb)
  TriggerServerEvent("tattoos:saveCharTattoos", appliedTattoos)
end)

Citizen.CreateThread(function()
  setupTattooBlips()
  while true do
    Wait(0)
    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)
    for i = 1, #tattooSpots do
      if (not tatShopShowing) then
        DrawMarker(27, tattooSpots[i].x, tattooSpots[i].y, tattooSpots[i].z - 0.98, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 155, 155, 255, 155, 0, 0, 2, 0, 0, 0, 0)
      end
      
      local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, tattooSpots[i].x, tattooSpots[i].y, tattooSpots[i].z)
      
      if (dist < 1.0) then
        lastTatSpot = i
        if (IsControlJustReleased(1, 38)) then -- E
          if (not blockInput) then
            blockInput = true
            Wait(500)
            FreezeEntityPosition(ped, true)
            setupCamera(true)
            TriggerServerEvent("tattoo:activateTattooShop")
          end
        end
      end
      
      if (lastTatSpot > 0) then
        local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, tattooSpots[lastTatSpot].x, tattooSpots[lastTatSpot].y, tattooSpots[lastTatSpot].z)
        
        if (dist > 1.1) then
          lastTatSpot = 0
        end
      end
      
      if (tatShopShowing) then
        DisableControlAction(0, 24, true) -- Attack
        DisablePlayerFiring(ped, true) -- Disable weapon firing
        DisableControlAction(0, 142, true) -- MeleeAttackAlternate
        DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
        HideHudAndRadarThisFrame()
        DisableFirstPersonCamThisFrame()
        DisableVehicleFirstPersonCamThisFrame()
      end
    end
  end
end)