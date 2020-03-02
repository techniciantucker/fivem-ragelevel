reputation = 0
local chopshopBlip = nil
local choplistBlip = nil
local moonshineBlip = nil
DecorRegister('Reputation', 3)

RegisterNetEvent("repuation:set")
AddEventHandler("repuation:set", function(v)
 reputation = v
 DecorSetInt(GetPlayerPed(-1), 'Reputation', v)
 updateBlips(v)
end)

function updateBlips(rep)

  if rep > 25 then 

    if not pawnshopBlip then

      pawnshopBlip = AddBlipForCoord(412.096, 315.206, 103.133)

      SetBlipSprite (pawnshopBlip, 456)

      SetBlipDisplay(pawnshopBlip, 4)

      SetBlipScale  (pawnshopBlip, 0.8)

      SetBlipColour (pawnshopBlip, 15)

      SetBlipAsShortRange(pawnshopBlip, true)

      BeginTextCommandSetBlipName("STRING")

      AddTextComponentString('Pawnshop')

      EndTextCommandSetBlipName(pawnshopBlip)

    end

   end

 if rep > 75 then 

  if not chopshopBlip then

    chopshopBlip = AddBlipForCoord(827.542, -2378.243, 29.126)

    SetBlipSprite (chopshopBlip, 456)

    SetBlipDisplay(chopshopBlip, 4)

    SetBlipScale  (chopshopBlip, 0.8)

    SetBlipColour (chopshopBlip, 15)

    SetBlipAsShortRange(chopshopBlip, true)

    BeginTextCommandSetBlipName("STRING")

    AddTextComponentString('Chopshop')

    EndTextCommandSetBlipName(chopshopBlip)

  end

 end

 if rep > 50 then 

  if not moonshineBlip then

    moonshineBlip = AddBlipForCoord(1388.293, 3605.423, 38.942)

    SetBlipSprite (moonshineBlip, 456)

    SetBlipDisplay(moonshineBlip, 4)

    SetBlipScale  (moonshineBlip, 0.8)

    SetBlipColour (moonshineBlip, 15)

    SetBlipAsShortRange(moonshineBlip, true)

    BeginTextCommandSetBlipName("STRING")

    AddTextComponentString('Moonshine')

    EndTextCommandSetBlipName(moonshineBlip)

  end

 end

 if rep > 300 then 

  if not shottaBlip then

    shottaBlip = AddBlipForCoord(-10.048, -1827.721, 25.384)

    SetBlipSprite (shottaBlip, 456)

    SetBlipDisplay(shottaBlip, 4)

    SetBlipScale  (shottaBlip, 0.8)

    SetBlipColour (shottaBlip, 15)

    SetBlipAsShortRange(shottaBlip, true)

    BeginTextCommandSetBlipName("STRING")

    AddTextComponentString('Shotta')

    EndTextCommandSetBlipName(shottaBlip)

  end

 end

 if rep > 250 then 

  if not LaundretteBlip then

    LaundretteBlip = AddBlipForCoord(-372.397, 194.087, 84.061)

    SetBlipSprite (LaundretteBlip, 456)

    SetBlipDisplay(LaundretteBlip, 4)

    SetBlipScale  (LaundretteBlip, 0.8)

    SetBlipColour (LaundretteBlip, 15)

    SetBlipAsShortRange(LaundretteBlip, true)

    BeginTextCommandSetBlipName("STRING")

    AddTextComponentString('Laundrette')

    EndTextCommandSetBlipName(LaundretteBlip)

  end

 end

 if rep > 420 then 

  if not weedBlip then

    weedBlip = AddBlipForCoord(858.050, -1017.935, 29.624) 

    SetBlipSprite (weedBlip, 456)

    SetBlipDisplay(weedBlip, 4)

    SetBlipScale  (weedBlip, 0.8)

    SetBlipColour (weedBlip, 15)

    SetBlipAsShortRange(weedBlip, true)

    BeginTextCommandSetBlipName("STRING")

    AddTextComponentString('Weed Seed')

    EndTextCommandSetBlipName(weedBlip)

  end

 end

 if rep > 1000 then 

  if not BulkBuyBlip then

    BulkBuyBlip = AddBlipForCoord(-101.072, 6506.490, 31.491)

    SetBlipSprite (BulkBuyBlip, 456)

    SetBlipDisplay(BulkBuyBlip, 4)

    SetBlipScale  (BulkBuyBlip, 0.8)

    SetBlipColour (BulkBuyBlip, 15)

    SetBlipAsShortRange(BulkBuyBlip, true)

    BeginTextCommandSetBlipName("STRING")

    AddTextComponentString('Bulk Buyer')

    EndTextCommandSetBlipName(BulkBuyBlip)

  end

 end

 if rep > 100 then 

  if not HospitalBlip then

    HospitalBlip = AddBlipForCoord(1017.468, -2529.328, 28.3021)

    SetBlipSprite (HospitalBlip, 456)

    SetBlipDisplay(HospitalBlip, 4)

    SetBlipScale  (HospitalBlip, 0.8)

    SetBlipColour (HospitalBlip, 15)

    SetBlipAsShortRange(HospitalBlip, true)

    BeginTextCommandSetBlipName("STRING")

    AddTextComponentString('Hospital')

    EndTextCommandSetBlipName(HospitalBlip)

  end

 end  

end
-- function updateBlips(rep)
 -- if rep > 75 then 
  -- if not choplistBlip then
    -- choplistBlip = AddBlipForCoord(109.301, -2016.146, 18.406)
    -- SetBlipSprite (choplistBlip, 456)
    -- SetBlipDisplay(choplistBlip, 4)
    -- SetBlipScale  (choplistBlip, 0.8)
    -- SetBlipColour (choplistBlip, 15)
    -- SetBlipAsShortRange(choplistBlip, true)
    -- BeginTextCommandSetBlipName("STRING")
    -- AddTextComponentString('Chop List')
    -- EndTextCommandSetBlipName(choplistBlip)
  -- end
 -- end
 -- if rep > 100 then 
  -- if not chopshopBlip then
    -- chopshopBlip = AddBlipForCoord(144.939, -3081.098, 5.896)
    -- SetBlipSprite (chopshopBlip, 456)
    -- SetBlipDisplay(chopshopBlip, 4)
    -- SetBlipScale  (chopshopBlip, 0.8)
    -- SetBlipColour (chopshopBlip, 15)
    -- SetBlipAsShortRange(chopshopBlip, true)
    -- BeginTextCommandSetBlipName("STRING")
    -- AddTextComponentString('Chop Cars')
    -- EndTextCommandSetBlipName(chopshopBlip)
  -- end
 -- end
 -- if rep > 125 then 
  -- if not moonshineBlip then
    -- moonshineBlip = AddBlipForCoord(575.736, 6605.288, 18.232)
    -- SetBlipSprite (moonshineBlip, 456)
    -- SetBlipDisplay(moonshineBlip, 4)
    -- SetBlipScale  (moonshineBlip, 0.8)
    -- SetBlipColour (moonshineBlip, 15)
    -- SetBlipAsShortRange(moonshineBlip, true)
    -- BeginTextCommandSetBlipName("STRING")
    -- AddTextComponentString('Moonshine Area')
    -- EndTextCommandSetBlipName(moonshineBlip)
  -- end
 -- end
  -- if rep > 300 then 
  -- if not ClorhidratoBlip then
    -- ClorhidratoBlip = AddBlipForCoord(3560.196, 3674.379, 28.122)
    -- SetBlipSprite (ClorhidratoBlip, 456)
    -- SetBlipDisplay(ClorhidratoBlip, 4)
    -- SetBlipScale  (ClorhidratoBlip, 0.8)
    -- SetBlipColour (ClorhidratoBlip, 15)
    -- SetBlipAsShortRange(ClorhidratoBlip, true)
    -- BeginTextCommandSetBlipName("STRING")
    -- AddTextComponentString('Clorhidrato Area')
    -- EndTextCommandSetBlipName(ClorhidratoBlip)
  -- end
 -- end
   -- if rep > 300 then 
  -- if not BicarbonatoBlip then
    -- BicarbonatoBlip = AddBlipForCoord(145.738, -2199.462, 4.688)
    -- SetBlipSprite (BicarbonatoBlip, 456)
    -- SetBlipDisplay(BicarbonatoBlip, 4)
    -- SetBlipScale  (BicarbonatoBlip, 0.8)
    -- SetBlipColour (BicarbonatoBlip, 15)
    -- SetBlipAsShortRange(BicarbonatoBlip, true)
    -- BeginTextCommandSetBlipName("STRING")
    -- AddTextComponentString('Bicarbonato Area')
    -- EndTextCommandSetBlipName(BicarbonatoBlip)
  -- end
 -- end
    -- if rep > 300 then 
  -- if not CokeAreaBlip then
    -- CokeAreaBlip = AddBlipForCoord(3204.146, -369.611, -0.420)
    -- SetBlipSprite (CokeAreaBlip, 456)
    -- SetBlipDisplay(CokeAreaBlip, 4)
    -- SetBlipScale  (CokeAreaBlip, 0.8)
    -- SetBlipColour (CokeAreaBlip, 15)
    -- SetBlipAsShortRange(CokeAreaBlip, true)
    -- BeginTextCommandSetBlipName("STRING")
    -- AddTextComponentString('Coke Area')
    -- EndTextCommandSetBlipName(CokeAreaBlip)
  -- end
 -- end
 
-- end