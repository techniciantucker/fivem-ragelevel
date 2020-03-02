local vat = {}

RegisterNetEvent('vat:update')
AddEventHandler('vat:update', function(v)
 vat = v
end)

function getVat(id)
 return vat[id]
end


function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end