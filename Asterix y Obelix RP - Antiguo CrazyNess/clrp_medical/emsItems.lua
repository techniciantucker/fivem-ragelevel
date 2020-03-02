currentWounds = 0

AddEventHandler('emsItem:paracetamol', function()
 TriggerEvent("animation:PlayAnimation", "pill")
 Wait(2000)
 if currentWounds > 0 then
  local newBloodLoss = round(bloodLoss/currentWounds, 2)
  currentWounds = currentWounds-1
  if bloodLoss-newBloodLoss < 0 then
   bloodLoss = 0.00
  else
   bloodLoss = bloodLoss-newBloodLoss
  end
 end
end)

AddEventHandler('emsItem:ibuprofen', function()
 TriggerEvent("animation:PlayAnimation", "pill")
 Wait(2000)
 if currentWounds > 0 then
  local newBloodLoss = round(bloodLoss/currentWounds, 2)
  currentWounds = currentWounds-1
  if bloodLoss-newBloodLoss < 0 then
   bloodLoss = 0.00
  else
   bloodLoss = bloodLoss-newBloodLoss
  end
 end
end)


AddEventHandler('emsItem:bloodBag', function()
 local t, distance = GetClosestPlayer()
 if distance ~= -1 and distance < 5 then
  TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
  Wait(2000)
  ClearPedTasks(GetPlayerPed(-1))
  TriggerServerEvent('ems:setBlood', GetPlayerServerId(t), 2500)
 else
  TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
  Wait(1000)
  ClearPedTasks(GetPlayerPed(-1))
  TriggerEvent('ems:setBlood', 2500)
 end
end)
