local lastAnimals = {}
local animals = {
  {model = "a_c_deer", hash = -664053099,item = "Deer Meat", id = 35},
  {model = "a_c_pig", hash = -1323586730, item = "Pig Meat", id = 36},
  {model = "a_c_mtlion", hash = 307287994, item = "Mountain Lion Meat", id = 37},
  {model = "a_c_cow", hash = -50684386, item = "Cow Meat", id = 38},
  {model = "a_c_coyote", hash = 1682622302, item = "Coyote Skin", id = 39},
  {model = "a_c_rabbit_01", hash = -541762431, item = "Rabbit Meat", id = 40},
}
local sellSpots = {
  {x = -390.522, y = 6050.458, z = 31.500},
  {x = -1121.589, y = 2697.305, z = 18.554}
}

function setupHuntingBlips()
  for _,v in pairs(sellSpots) do
    local blip = AddBlipForCoord(v.x, v.y, v.z)
    SetBlipSprite(blip, 141)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 70)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Meat Sales")
    EndTextCommandSetBlipName(blip)
  end
end

function getAnimalMatch(hash)
  for _,v in pairs(animals) do
    if (v.hash == hash) then
      return v
    end
  end
end

function removeEntity(entity)
  local delidx = 0
  
  for i = 1, #lastAnimals do
    if (lastAnimals[i].entity == entity) then
      delidx = i
    end
  end
  
  if (delidx > 0) then
    table.remove(lastAnimals, delidx)
  end
end

function lastAnimalExists(entity)
  for _,v in pairs(lastAnimals) do
    if (v.entity == entity) then
      return true
    end
  end
end

function handleDecorator(animal)
  if (DecorExistOn(animal, "lastshot")) then
    DecorSetInt(animal, "lastshot", GetPlayerServerId(PlayerId()))
  else
    DecorRegister("lastshot", 3)
    DecorSetInt(animal, "lastshot", GetPlayerServerId(PlayerId()))
  end
end

function isKillMine(animal)
  if (DecorExistOn(animal, "lastshot")) then
    local aid = DecorGetInt(animal, "lastshot")
    local id = GetPlayerServerId(PlayerId())

    return aid == id
  end
end

Citizen.CreateThread(function()
 setupHuntingBlips()
 while true do
  local ped = GetPlayerPed(-1)
  Wait(1)
  if (IsAimCamActive()) and not IsPedInAnyVehicle(ped, false) then  
   local _, ent = GetEntityPlayerIsFreeAimingAt(PlayerId(), Citizen.ReturnResultAnyway())      
   if (ent and not IsEntityDead(ent)) then
    if (IsEntityAPed(ent)) then
     local model = GetEntityModel(ent)
     local animal = getAnimalMatch(model) 
     if (model and animal) then
      handleDecorator(ent)
      if (not lastAnimalExists(ent)) then
       if (#lastAnimals > 10) then
        table.remove(lastAnimals, 1)
       end    
       local newAnim = {}
       newAnim.entity = ent
       newAnim.data = animal
       table.insert(lastAnimals, newAnim)
      end
     end
    end
   end
  end
  if (#lastAnimals > 0) then
   for _,v in pairs(lastAnimals) do
    local pos = GetEntityCoords(ped)
    local rpos = GetEntityCoords(v.entity)
    if (GetDistanceBetweenCoords(pos, rpos.x, rpos.y, rpos.z, true) < 40 and isKillMine(v.entity)) then
     if (DoesEntityExist(v.entity)) then
      if (IsEntityDead(v.entity)) then
       DrawMarker(2, rpos.x, rpos.y, rpos.z+0.8, 0, 0, 0, 0, 0, 0, 0.4, 0.4, 0.4, 255, 255, 0, 150, 0, 0, 2, 0, 0, 0, 0)     
       if (GetDistanceBetweenCoords(pos, rpos.x, rpos.y, rpos.z, true) < 1.1) then
       	drawTxt("~b~Press ~g~E~b~ To Harvest Meat")
        if IsControlJustPressed(0, 38) and GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_KNIFE") then
         TriggerEvent("inventory:addQty", v.data.id, 1)
         removeEntity(v.entity)
         DeleteEntity(v.entity)
        end
       end
      end
     else
      removeEntity(v.entity)
      DeleteEntity(v.entity)
     end
    end
   end
  end
  for _,v in pairs(sellSpots) do
   local pos = GetEntityCoords(ped)
   if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 40) then 
    DrawMarker(27, v.x, v.y, v.z-0.95, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.8, 255, 255, 0, 150, 0, 0, 2, 0, 0, 0, 0)
    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2) then 
     drawTxt("~b~Press ~g~E~b~ To Sell Meat")
     if IsControlJustPressed(0, 38) then
      TriggerServerEvent('hunting:sell')
     end
    end
   end
  end
 end
end)

function drawTxt(text)
  SetTextFont(0)
  SetTextProportional(0)
  SetTextScale(0.32, 0.32)
  SetTextColour(0, 255, 255, 255)
  SetTextDropShadow(0, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(1)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(0.5, 0.93)
end