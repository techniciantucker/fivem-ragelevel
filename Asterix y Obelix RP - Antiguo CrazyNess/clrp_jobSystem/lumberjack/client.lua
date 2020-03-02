local isNearTree = false
local currentTree = {}
local closestTree = nil
local treeModels = {
 [1] = {prop = 'test_tree_cedar_trunk_001', logs = 3},
 [2] = {prop = 'prop_tree_cedar_s_01', logs = 1},
 [3] = {prop = 'prop_tree_cedar_02', logs = 2},
 [4] = {prop = 'prop_bush_lrg_03', logs = 2},
 [5] = {prop = 'prop_tree_cedar_04', logs = 2},
 [6] = {prop = 'prop_w_r_cedar_01', logs = 2},
 [7] = {prop = 'prop_tree_cedar_s_02', logs = 1}
}


Citizen.CreateThread(function()
 while true do
  Citizen.Wait(1000)
  if DecorGetInt(PlayerPedId(), 'Job') == 12 then
   isNearTree = false
   local myCoords = GetEntityCoords(PlayerPedId())
   for i = 1, #treeModels do
    closestTree = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 50.0, GetHashKey(treeModels[i].prop), false, false, false)
    if closestTree ~= nil and closestTree ~= 0 then
     local coords = GetEntityCoords(closestTree)
     isNearTree = true
     print('heyy')
     currentTree = {['x'] = coords.x, ['y'] = coords.y, ['z'] = coords.z + 1.2, ['logs'] = treeModels[i].logs}
     break
    end
   end
  else 
   Wait(5000)
  end
 end
end)


