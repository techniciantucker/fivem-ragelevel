local attachedWeapons = {}
local allWeapons = {
 ["w_me_bat"] = {x = 0.08, y = -0.16, z = 0.0, xR = -90.0, yR = 178.0, zR = 90.0, hash = -1786099057},
  -- ["prop_ld_jerrycan_01"] = {x = 0.11 + 0.3, y = -0.14, z = 0.0, xR = -75.0, yR = 165.0, zR = 92.0, hash = 883325847},
 ["w_ar_carbinerifle"] = {x = 0.163, y = -0.15, z = -0.13, xR = -180.0, yR = 180.0, zR = 0.0, hash = -2084633992},
 ["w_ar_carbinerifle_mk2"] = {x = 0.163, y = -0.15, z = -0.13, xR = -180.0, yR = 180.0, zR = 0.0, hash = -4208062921},
 ["w_ar_assaultrifle"] = {x = 0.163, y = -0.15, z = -0.13, xR = -180.0, yR = 180.0, zR = 0.0, hash = -1074790547},
 ["w_ar_specialcarbine"] = {x = 0.163, y = -0.15, z = -0.13, xR = -180.0, yR = 180.0, zR = 0.0, hash = -1063057011},
 ["w_ar_bullpuprifle"] = {x = 0.163, y = -0.15, z = -0.13, xR = -180.0, yR = 180.0, zR = 0.0, hash = 2132975508},
 ["w_ar_advancedrifle"] = {x = 0.163, y = -0.15, z = -0.13, xR = -180.0, yR = 180.0, zR = 0.0, hash = -1357824103},
 ["w_sb_microsmg"] = {x = 0.163, y = -0.15, z = -0.13, xR = -180.0, yR = 180.0, zR = 0.0, hash = 324215364},
 ["w_sb_assaultsmg"] = {x = 0.089, y = -0.15, z = -0.03, xR = 0.0, yR = 165.0, zR = 0.0, hash = -270015777},
 ["w_sb_smg"] = {x = 0.163, y = -0.15, z = -0.13, xR = -180.0, yR = 180.0, zR = 0.0, hash = 736523883},
 ["w_sb_smg_mk2"] = {x = 0.163, y = -0.15, z = -0.13, xR = -180.0, yR = 180.0, zR = 0.0, hash = 2024373456},
 ["w_sb_gusenberg"] = {x = 0.163, y = -0.15, z = -0.13, xR = -180.0, yR = 180.0, zR = 0.0, hash = 1627465347},
 ["w_sg_assaultshotgun"] = {x = 0.23, y = -0.15, z = 0.08, xR = 180.0, yR = -0.5, zR = -180.0, hash = -494615257},
 ["w_sg_bullpupshotgun"] = {x = 0.23, y = -0.15, z = 0.08, xR = 180.0, yR = -0.5, zR = -180.0, hash = -1654528753},
 ["w_sg_pumpshotgun"] = {x = 0.23, y = -0.15, z = 0.08, xR = 180.0, yR = -0.5, zR = -180.0, hash = 487013001},
 ["w_ar_musket"] = {x = -0.05, y = -0.15, z = 0.08, xR = 0.0, yR = -0.5, zR = 0.0, hash = -1466123874},
}

Citizen.CreateThread(function()
 while true do
  for name, v in pairs(allWeapons) do
   if HasPedGotWeapon(GetPlayerPed(-1), v.hash, false) then
    if not attachedWeapons[name] then
     AttachWeapon(name, v.hash, v.x, v.y, v.z, v.xR, v.yR, v.zR)
    end
   end
  end


  for name, attached in pairs(attachedWeapons) do
   if GetSelectedPedWeapon(GetPlayerPed(-1)) == attached.hash or not HasPedGotWeapon(GetPlayerPed(-1), attached.hash, false) then
    DeleteObject(attached.handle)
    attachedWeapons[name] = nil
   end
  end
  Wait(5)
 end
end)

function AttachWeapon(attachModel, modelHash, x, y, z, xR, yR, zR)
 local bone = GetPedBoneIndex(GetPlayerPed(-1), 24816)

 RequestModel(attachModel)
 while not HasModelLoaded(attachModel) do
  Wait(100)
 end

 attachedWeapons[attachModel] = {hash = modelHash, handle = CreateObject(GetHashKey(attachModel), 1.0, 1.0, 1.0, true, true, false)}

 AttachEntityToEntity(attachedWeapons[attachModel].handle, GetPlayerPed(-1), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
end
