local inventory = {}  
local currentitem = 0
local droppedItems = {}
local droppedItemsProps = {}

--[[RegisterCommand('inv', function(source, args, rawCommand)
    WarMenu.OpenMenu('Inventory')
end)
]]--
RegisterCommand('id', function(source, args, rawCommand)
    TriggerServerEvent('player:showid')
end)

RegisterCommand('dl', function(source, args, rawCommand)
    TriggerServerEvent('player:dmvl')
end)
 --- new changes
RegisterCommand('gl', function(source, args, rawCommand)
    TriggerServerEvent('player:gunL') 
end)

RegisterCommand('fakeid', function(source, args, rawCommand)
    TriggerEvent('fakeids:openmenu')
end)


RegisterNetEvent("inventory:updateitems")
AddEventHandler("inventory:updateitems", function(inv)
    inventory = inv
end)

RegisterNetEvent("inventory:addQty")
AddEventHandler("inventory:addQty",function(i,q,meta)
    addQty(i,q,meta)
end)

RegisterNetEvent("inventory:removeQty")
AddEventHandler("inventory:removeQty",function(i,q)
    removeQty(i,q)
end)

RegisterNetEvent("inventory:messages")
AddEventHandler("inventory:messages",function(message)
 exports['clrp_notify']:DoHudText('inform', message)
end)

function removeQty(i,q)
    TriggerServerEvent("inventory:remove", tonumber(i),tonumber(q))
end

function addQty(i,q,meta)
    TriggerServerEvent("inventory:add", tonumber(i),tonumber(q),meta)
end

function getInventory()
 return inventory
end

function getQuantity()
 if inventory ~= '{}' and inventory ~= nil then
    local quantity = 0
    for i=1,#inventory do
        quantity = quantity + inventory[i].q
    end
    return quantity
 else
  return 0
 end
end

function isFull()
    local quantity = 0
    for i=1,#inventory do
        quantity = quantity + inventory[i].q
    end
    if quantity == 120 then
        return true
    else
        return false
    end
end

function GetItemQuantity(item)
    local quantity = 0
    for i=1,#inventory do
        if inventory[i].id == tonumber(item) then
            quantity = quantity + inventory[i].q
        end
    end
    return quantity
end

function GetItemQuantityMeta(item, meta)
    if not meta then metadata = 'This Item Contains No Meta Data' else metadata = meta end
    local quantity = 0
    for i=1,#inventory do
        if inventory[i].id == tonumber(item) and inventory[i].meta == tostring(metadata) then
            quantity = quantity + inventory[i].q
        end
    end
    return quantity
end

RegisterNetEvent("inventory:droppeditems")
AddEventHandler("inventory:droppeditems", function(items)
 droppedItems = items
 for _,v in pairs(droppedItemsProps) do 
  if v.prop then 
   DeleteObject(v.prop)
  end
 end
 droppedItemsProps = {}
 -- Create new props
 for id,v in pairs(items) do
   SpawnObject(id, v.pos, v.prop, v.item)
 end
end)

--[[function SpawnObject(id, pos)
    local prophash = GetHashKey('prop_paper_bag_small')
    RequestModel(prophash)
    while not HasModelLoaded(prophash) do
     Citizen.Wait(0)
    end
   
    local _, worldZ = GetGroundZFor_3dCoord(pos.x, pos.y, pos.z)
    local propsobj = CreateObject(prophash, pos.x, pos.y, worldZ, true, true, true)
   
    SetEntityHeading(propsobj, 0)
    SetEntityAsMissionEntity(propsobj, true, true)
    FreezeEntityPosition(propsobj, true)
    SetModelAsNoLongerNeeded(prophash)
    droppedItemsProps[id] = {prop = propsobj, pos = {x = pos.x, y = pos.y, z = worldZ}}
end
]]--
function SpawnObject(id, pos, prop, item)
 local prophash = nil

 -- ITEMS
 if item == 14 then
  prophash = GetHashKey('prop_cs_burger_01')
 elseif item == 13 or item == 81 then
  prophash = GetHashKey('prop_ld_flow_bottle')
 elseif item == 120 then
  prophash = GetHashKey('prop_weed_block_01')
 elseif item == 106 then
  prophash = GetHashKey('prop_sandwich_01')
 elseif item == 107 then
  prophash = GetHashKey('prop_coke_block_01')
 elseif item == 109 then
  prophash = GetHashKey('prop_coke_block_half_a')
 elseif item == 20 then
  prophash = GetHashKey('prop_wine_bot_01')
 elseif item == 256 then
  prophash = GetHashKey('ng_proc_sodacan_02b')
 elseif item == 253 then
  prophash = GetHashKey('p_ld_id_card_002')
 elseif item == 22 then
  prophash = GetHashKey('prop_amb_beer_bottle')
 elseif item == 24 or item == 23 then
  prophash = GetHashKey('prop_whiskey_bottle')
 elseif item == 26 then
  prophash = GetHashKey('prop_energy_drink')
 elseif item == 104 then
  prophash = GetHashKey('prop_phone_ing')
 elseif item == 69 or item == 70 then
  prophash = GetHashKey('prop_phone_ing_03')
 elseif item == 8 then
  prophash = GetHashKey('prop_phone_ing_03')
 elseif item == 110 then
  prophash = GetHashKey('prop_meth_bag_01')
 elseif item == 34 then
  prophash = GetHashKey('bkr_prop_meth_smallbag_01a')
 elseif item == 112 then
  prophash = GetHashKey('bkr_prop_coke_scale_01')
 elseif item == 113 then
  prophash = GetHashKey('bkr_prop_coke_scale_03')
 elseif item == 6 then
  prophash = GetHashKey('prop_toolchest_01')
 elseif item == 11 then
  prophash = GetHashKey('v_ind_cs_spray')
 elseif item == 121 then
  prophash = GetHashKey('p_weed_bottle_s')
 elseif item == 82 then
  prophash = GetHashKey('ng_proc_sodacan_02a')
 elseif item == 90 then
  prophash = GetHashKey('p_cs_script_bottle_s')
 elseif item == 15 then
  prophash = GetHashKey('ng_proc_cigarette01a')
 elseif item == 124 or item == 123 then
  prophash = GetHashKey('p_cs_joint_02')
 elseif item == 43 or item == 61 or item == 44 or item == 58 or item == 78 then
  prophash = GetHashKey('prop_cs_pills')
 elseif item == 178 then
  prophash = GetHashKey('prop_cash_note_01')
 elseif item == 171 then
  prophash = GetHashKey('prop_cash_pile_01')
 elseif item == 177 then
  prophash = GetHashKey('prop_cash_pile_02')
 elseif item == 154 then
  prophash = GetHashKey('prop_cash_envelope_01')
 elseif item == 156 or item == 155 then
  prophash = GetHashKey('prop_cs_cashenvelope')
 elseif item == 152 then
  prophash = GetHashKey('prop_cash_case_01')
 elseif item == 153 then
  prophash = GetHashKey('prop_cash_case_02')
 --[[elseif item ==  then
  prophash = GetHashKey('hei_prop_pill_bag_01')]]
  elseif item == 87 then
  TriggerEvent('weed:plantStart')
 -- WEAPONS
 elseif item == 185 then
  prophash = GetHashKey('w_ex_pipebomb')
 elseif item == 186 then
  prophash = GetHashKey('w_pi_pistol')
 elseif item == 187 then
  prophash = GetHashKey('w_pi_combatpistol')
elseif item == 250 then
    prophash = GetHashKey('w_pi_combatpistol')
 elseif item == 188 or item == 189 then
  prophash = GetHashKey('w_pi_pistolmk2')
 elseif item == 190 then
  prophash = GetHashKey('w_sb_microsmg')
 elseif item == 191 then
  prophash = GetHashKey('w_am_baseball')
 elseif item == 192 then
  prophash = GetHashKey('w_me_wrench')
 elseif item == 193 or item == 194 then
  prophash = GetHashKey('w_ar_carbineriflemk2')
 elseif item == 197 then
  prophash = GetHashKey('w_me_flashlight')
 elseif item == 198 then
  prophash = GetHashKey('w_pi_stungun')
 elseif item == 199 then
  prophash = GetHashKey('w_sg_pumpshotgun')
 elseif item == 200 then
  prophash = GetHashKey('w_sg_pumpshotgunmk2')
 elseif item == 201 then
  prophash = GetHashKey('w_me_switchblade')
 elseif item == 202 then
  prophash = GetHashKey('w_me_knuckle')
 elseif item == 203 then
  prophash = GetHashKey('w_me_hatchet')
 elseif item == 204 then
  prophash = GetHashKey('w_ex_molotov')
 elseif item == 205 then
  prophash = GetHashKey('prop_cs_petrol_can')
 elseif item == 206 then
  prophash = GetHashKey('w_ar_assaultrifle')
 elseif item == 207 then
  prophash = GetHashKey('w_sg_sawnoff')
 elseif item == 208 then
  prophash = GetHashKey('w_sg_doublebarrel')
 elseif item == 209 then
  prophash = GetHashKey('w_sb_gusenberg')
 elseif item == 210 then
  prophash = GetHashKey('w_me_machette')
 elseif item == 211 then
  prophash = GetHashKey('w_me_poolcue')
 elseif item == 212 then
  prophash = GetHashKey('w_me_knife')
 elseif item == 213 then
  prophash = GetHashKey('w_me_nightstick')
 elseif item == 214 then
  prophash = GetHashKey('w_me_hammer')
 elseif item == 215 then
  prophash = GetHashKey('w_me_bat')
 elseif item == 216 then
  prophash = GetHashKey('w_me_golfclub')
 elseif item == 217 then
  prophash = GetHashKey('w_me_crowbar')
 elseif item == 218 then
  prophash = GetHashKey('w_pi_appistol')
 elseif item == 219 then
  prophash = GetHashKey('w_pi_pistol50')
 elseif item == 220 then
  prophash = GetHashKey('w_sb_smg')
 elseif item == 221 then
  prophash = GetHashKey('w_sb_assaultsmg')
 elseif item == 222 then
  prophash = GetHashKey('w_ar_carbinerifle')
 elseif item == 223 then
  prophash = GetHashKey('w_ar_advancedrifle')
 elseif item == 224 then
  prophash = GetHashKey('w_mg_mg')
 elseif item == 225 then
  prophash = GetHashKey('w_mg_combatmg')
 elseif item == 226 then
  prophash = GetHashKey('w_sg_assaultshotgun')
 elseif item == 227 then
  prophash = GetHashKey('w_sg_bullpupshotgun')
 elseif item == 228 then
  prophash = GetHashKey('w_sr_sniperrifle')
 elseif item == 229 then
  prophash = GetHashKey('w_sr_heavysniper')
 elseif item == 230 then
  prophash = GetHashKey('prop_fire_exting_1b')
 elseif item == 231 then
  prophash = GetHashKey('w_am_flare')
 elseif item == 232 then
  prophash = GetHashKey('w_pi_snspistol')
 elseif item == 233 then
  prophash = GetHashKey('w_ar_specialcarbine')
 elseif item == 234 then
  prophash = GetHashKey('w_pi_heavypistol')
 elseif item == 235 then
  prophash = GetHashKey('w_ar_bullpuprifle')
 elseif item == 236 then
  prophash = GetHashKey('w_pi_vintagepistol')
 elseif item == 237 then
  prophash = GetHashKey('w_me_dagger')
 elseif item == 238 then
  prophash = GetHashKey('w_ar_musket')
 elseif item == 239 then
  prophash = GetHashKey('w_sr_marksmanrifle')
 elseif item == 240 then
  prophash = GetHashKey('w_sg_heavyshotgun')
 elseif item == 241 then
  prophash = GetHashKey('w_pi_marksmanpistol')
 elseif item == 242 then
  prophash = GetHashKey('w_pi_machinepistol')
 elseif item == 243 then
  prophash = GetHashKey('w_pi_revolver')
 elseif item == 244 then
  prophash = GetHashKey('w_sb_compactsmg')
 elseif item == 245 then
  prophash = GetHashKey('w_pi_flaregun')
 elseif item == 246 then
  prophash = GetHashKey('w_me_battleaxe')
 elseif item == 247 then
  prophash = GetHashKey('w_sb_minismg')
 elseif item == 248 then
  prophash = GetHashKey('w_sg_autoshotgun')
 elseif item == 249 then
  prophash = GetHashKey('w_pi_doubleaction')
 else
  prophash = GetHashKey('hei_prop_hei_paper_bag')
 end
 RequestModel(prophash)
 while not HasModelLoaded(prophash) do
  Citizen.Wait(0)
 end

 local _, worldZ = GetGroundZFor_3dCoord(pos.x, pos.y, pos.z)
 local propsobj = CreateObject(prophash, pos.x, pos.y, worldZ, true, true, true)

 SetEntityHeading(propsobj, 0)
 SetEntityAsMissionEntity(propsobj, true, true)
 FreezeEntityPosition(propsobj, false)
 SetModelAsNoLongerNeeded(prophash)
 droppedItemsProps[id] = {prop = propsobj, pos = {x = pos.x, y = pos.y, z = worldZ}}
end

function DrawText3Ds(x,y,z, text)
 local onScreen,_x,_y=World3dToScreen2d(x,y,z)
 local px,py,pz=table.unpack(GetGameplayCamCoords())  
 SetTextScale(0.35, 0.35)
 SetTextFont(4)
 SetTextProportional(1)
 SetTextColour(255, 255, 255, 215)
 SetTextEntry("STRING")
 SetTextCentre(1)
 AddTextComponentString(text)
 DrawText(_x,_y)
end
   


Citizen.CreateThread(function()
 while true do
  Wait(5)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  for k,v in pairs(droppedItems) do
   if(GetDistanceBetweenCoords(coords, v.pos.x, v.pos.y, v.pos.z-0.95, true) < 1.0) then
    DrawText3Ds(v.pos.x, v.pos.y, v.pos.z-0.55,'~y~[E]~w~ Pick Up '..v.qty.."x "..v.name)
    if IsControlJustPressed(0, 38) then
     if v.qty + getQuantity() <= 120 then
      TriggerServerEvent('inventory:pickup', k, v.item, v.qty, v.meta)
      API_ProgressBar('Picking Up', 20)
      TaskPlayAnim(GetPlayerPed(-1), "anim@mp_snowball", "pickup_snowball", 8.0, -1, -1, false, 1, 0, 0, 0)
      FreezeEntityPosition(coords, true)
      ExecuteCommand("me Picking up items")
      Wait(2000)
      FreezeEntityPosition(coords, false)
     else
      exports['clrp_notify']:DoHudText('inform', 'Inventory Full') 
     end 
    end
   end
  end
 end
end)