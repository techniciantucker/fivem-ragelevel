local blips = {
  {title="Jaula / Peleas callejeras", colour=1, id=311, x = -514.63, y = -1717.12, z = 19.32},
  {title="Club de la comedia", colour=8, id=102, x = -430.142, y = 261.665, z = 83.005},
}
Citizen.CreateThread(function()

for _, info in pairs(blips) do
   info.blip = AddBlipForCoord(info.x, info.y, info.z)
   SetBlipSprite(info.blip, info.id)
   SetBlipDisplay(info.blip, 4)
   SetBlipScale(info.blip, 1.0)
   SetBlipColour(info.blip, info.colour)
   SetBlipAsShortRange(info.blip, true)
   BeginTextCommandSetBlipName("STRING")
   AddTextComponentString(info.title)
   EndTextCommandSetBlipName(info.blip)
 end
end)
