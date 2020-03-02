local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData                = {}
local GUI                       = {}
local HasAlreadyEnteredMarker   = false
local LastStation               = nil
local LastPart                  = nil
local LastPartNum               = nil
local LastEntity                = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local IsHandcuffed              = false
local IsDragged                 = false
local CopPed                    = 0

ESX                             = nil
GUI.Time                        = 0

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

function SetVehicleMaxMods(vehicle)

  local props = {
    modEngine       = 0,
    modBrakes       = 0,
    modTransmission = 0,
    modSuspension   = 0,
    modTurbo        = false,
  }

  ESX.Game.SetVehicleProperties(vehicle, props)

end

function getJob()
  
  if PlayerData.job ~= nil then
  return PlayerData.job.name  
  
  end  
end

function OpenCloakroomMenu()

	local elements = {
	  {label = _U('citizen_wear'), value = 'citizen_wear'},
	}
  
	ESX.UI.Menu.CloseAll()
  
	if Config.EnableNonFreemodePeds then 
	    table.insert(elements, {label = 'Uniforme desnudo', value = 'desnudo'})
		table.insert(elements, {label = '', value = ''})
	    table.insert(elements, {label = '-= Seguridad Ciudadana Guardia Civil =-'})
	    table.insert(elements, {label = 'Uniformidad Base', value = 'gc_segciudadanabase'})  
	    table.insert(elements, {label = 'Camiseta 1', value = 'gc_segciudadacamiseta1'})
	    table.insert(elements, {label = 'Camiseta 2', value = 'gc_segciudadacamiseta2'})
	    table.insert(elements, {label = 'Pantalones 1', value = 'gc_segciudadapantalones1'})
	    table.insert(elements, {label = 'Pantalones 2', value = 'gc_segciudadapantalones2'})
      table.insert(elements, {label = 'Chubasquero', value = 'gc_chubasquero'})
      table.insert(elements, {label = '', value = ''})
      table.insert(elements, {label = '-= Agrupación de Tráfico Guardia Civil =-'})
      table.insert(elements, {label = 'Abrigo', value = 'abrigotrafico1'})  
    table.insert(elements, {label = '', value = ''})
	    table.insert(elements, {label = '-= Milicia Guardia Civil =-'})
      table.insert(elements, {label = 'Polo Milicia', value = 'polomilicia1'})  
      table.insert(elements, {label = '', value = ''})
		table.insert(elements, {label = '-= Unidad Especial Intervención =-'})
	    table.insert(elements, {label = 'Uniformidad Base', value = 'ueibase'})
		table.insert(elements, {label = '', value = ''})
		table.insert(elements, {label = '-= Grupo Reserva Seguridad =-'})
	    table.insert(elements, {label = 'Uniformidad Base', value = 'grsbase'})
	    table.insert(elements, {label = '', value = ''})
	    table.insert(elements, {label = '-= Añadir Accesorios =-'})
	    table.insert(elements, {label = 'Añadir chaleco antibalas', value = 'chaleco1'})
	    table.insert(elements, {label = 'Añadir chaleco reflectante', value = 'chaleco3'})
		table.insert(elements, {label = 'Añadir gorra', value = 'gorra'})
		table.insert(elements, {label = 'Añadir casco ATGC', value = 'cascoatgc'})
		table.insert(elements, {label = 'Añadir casco GRS', value = 'cascogrs'})
		table.insert(elements, {label = 'Añadir casco UEI', value = 'cascouei'})
	    table.insert(elements, {label = 'Cinturón 1', value = 'cinturon1'})
	    table.insert(elements, {label = 'Cinturón 2', value = 'cinturon2'})
	    table.insert(elements, {label = 'Cinturón 3', value = 'cinturon3'})
	    table.insert(elements, {label = 'Arma en cinturon', value = 'arma1'})
	    table.insert(elements, {label = 'Arma en rodilla', value = 'arma2'})
		table.insert(elements, {label = '', value = ''})
	    table.insert(elements, {label = '-= Quitar Accesorios =-'})
	    table.insert(elements, {label = 'Quitar chaleco', value = 'quitarchaleco'})
	    table.insert(elements, {label = 'Quitar cinturón', value = 'quitarcinturon'})
	    table.insert(elements, {label = 'Quitar arma', value = 'quitararma'})
	    table.insert(elements, {label = 'Quitar casco / gorra', value = 'quitarcasco'})
	  end
  
	  ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'cloakroom',
		{
		  title    = _U('cloakroom'),
		  align    = 'bottom-right',
		  elements = elements,
		  },
  
		  function(data, menu)
  
		--menu.close()
  
		if data.current.value == 'citizen_wear' then
		  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
			local model = nil
  
			if skin.sex == 0 then
			  model = GetHashKey("mp_m_freemode_01")
			else
			  model = GetHashKey("mp_f_freemode_01")
			end
  
			RequestModel(model)
			while not HasModelLoaded(model) do
			  RequestModel(model)
			  Citizen.Wait(1)
			end
  
			SetPlayerModel(PlayerId(), model)
			SetModelAsNoLongerNeeded(model)
  
			TriggerEvent('skinchanger:loadSkin', skin)
			TriggerEvent('esx:restoreLoadout')
		  end)
		end
  
		if data.current.value == 'skin' then
  
		  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
  
			if skin.sex == 0 then
			  TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[data.current.id].male)
			else
			  TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[data.current.id].female)
			end
  
		  end)
  
		end
		--Desnudo
	    if data.current.value == 'desnudo' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'tshirt_1', 57)
	            TriggerEvent('skinchanger:change', 'tshirt_2', 0)
	            TriggerEvent('skinchanger:change', 'torso_1', 91)
	            TriggerEvent('skinchanger:change', 'torso_2', 0)
	            TriggerEvent('skinchanger:change', 'arms', 15)
	            TriggerEvent('skinchanger:change', 'pants_1', 61)
	            TriggerEvent('skinchanger:change', 'pants_2', 3)
	            TriggerEvent('skinchanger:change', 'shoes_1', 34)
	            TriggerEvent('skinchanger:change', 'shoes_2', 0)
	            TriggerEvent('skinchanger:change', 'chain_1', 0)
	            TriggerEvent('skinchanger:change', 'chain_2', 0)
	            TriggerEvent('skinchanger:change', 'helmet_1', -1)
	            TriggerEvent('skinchanger:change', 'helmet_2', 0)
	            TriggerEvent('skinchanger:change', 'mask_1', 0)
	            TriggerEvent('skinchanger:change', 'mask_2', 0)
	            TriggerEvent('skinchanger:change', 'bags_1', 0)
	            TriggerEvent('skinchanger:change', 'bags_2', 0)
	            TriggerEvent('skinchanger:change', 'glasses_1', 0)
	            TriggerEvent('skinchanger:change', 'glasses_2', 0)
	            TriggerEvent('skinchanger:change', 'bproof_1', 0)
	            TriggerEvent('skinchanger:change', 'bproof_2', 0)
	            TriggerEvent('skinchanger:change', 'decals_1', 0)
	            TriggerEvent('skinchanger:change', 'decals_2', 0)
	          else
	            TriggerEvent('skinchanger:change', 'tshirt_1', 26)
	          end

	        end)
	      end
	      if data.current.value == 'quitarcascogrs' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'helmet_1', -1)
	          else
	            TriggerEvent('skinchanger:change', 'mask_1', 0)
	          end

	        end)
        end
        if data.current.value == 'polomilicia1' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'torso_1', 101)
	          else
	            TriggerEvent('skinchanger:change', 'arms', 11)
	          end

	        end)
        end
        if data.current.value == 'abrigotrafico1' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'torso_1', 75)
	          else
	            TriggerEvent('skinchanger:change', 'arms', 11)
	          end

	        end)
	      end
	      if data.current.value == 'chaleco1' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin, playerPed)
			SetPedArmour(GetPlayerPed(-1), 100)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'bproof_1', 18)
	        	TriggerEvent('skinchanger:change', 'bproof_2', 0)
	          else
	            TriggerEvent('skinchanger:change', 'bproof_1', 20)
	            TriggerEvent('skinchanger:change', 'bproof_2', 6)
	            TriggerEvent('skinchanger:change', 'tshirt_1', 132)
	          end

	        end)
	      end
	      if data.current.value == 'quitarchaleco' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'bproof_1', 0)
	          else
	            TriggerEvent('skinchanger:change', 'bproof_1', 0)
	          end
	          SetPedArmour(GetPlayerPed(-1), 0)
	        end)
        end
		  if data.current.value == 'gorra' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin, playerPed)
			SetPedArmour(GetPlayerPed(-1), 100)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'helmet_1', 84)
	        	TriggerEvent('skinchanger:change', 'helmet_2', 0)
	          end

	        end)
	      end
		  if data.current.value == 'cascoatgc' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin, playerPed)
			SetPedArmour(GetPlayerPed(-1), 100)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'helmet_1', 83)
	        	TriggerEvent('skinchanger:change', 'helmet_2', 0)
	          end

	        end)
	      end
		  if data.current.value == 'cascouei' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin, playerPed)
			SetPedArmour(GetPlayerPed(-1), 100)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'helmet_1', 123)
	        	TriggerEvent('skinchanger:change', 'helmet_2', 0)
	          end

	        end)
	      end
		  if data.current.value == 'cascogrs' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin, playerPed)
			SetPedArmour(GetPlayerPed(-1), 100)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'helmet_1', 125)
	        	TriggerEvent('skinchanger:change', 'helmet_2', 0)
	          end

	        end)
	      end
		  if data.current.value == 'quitarcasco' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin, playerPed)
			SetPedArmour(GetPlayerPed(-1), 100)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'helmet_1', -1)
	        	TriggerEvent('skinchanger:change', 'helmet_2', 0)
	          end

	        end)
	      end
	      if data.current.value == 'quitarcinturon' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'tshirt_1', 57)
	          else
	            TriggerEvent('skinchanger:change', 'tshirt_1', 57)
	          end

	        end)
	      end
	      if data.current.value == 'quitararma' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'chain_1', 0)
	          else
	            TriggerEvent('skinchanger:change', 'tshirt_1', 57)
	          end

	        end)
	      end
	      if data.current.value == 'cinturon1' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'tshirt_1', 133)
	            TriggerEvent('skinchanger:change', 'tshirt_2', 0)
	          else
	            TriggerEvent('skinchanger:change', 'tshirt_1', 26)
	          end

	        end)
	      end
	      if data.current.value == 'cinturon2' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'tshirt_1', 134)
	            TriggerEvent('skinchanger:change', 'tshirt_2', 0)
	          else
	            TriggerEvent('skinchanger:change', 'tshirt_1', 26)
	          end

	        end)
	      end
	      if data.current.value == 'cinturon3' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'tshirt_1', 135)
	            TriggerEvent('skinchanger:change', 'tshirt_2', 0)
	          else
	            TriggerEvent('skinchanger:change', 'tshirt_1', 26)
	          end

	        end)
	      end
	      if data.current.value == 'arma1' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'chain_1', 117)
	          else
	            TriggerEvent('skinchanger:change', 'tshirt_1', 26)
	          end

	        end)
	      end
	      if data.current.value == 'arma2' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'chain_1', 116)
	          else
	            TriggerEvent('skinchanger:change', 'tshirt_1', 26)
	          end

	        end)
	      end
		  
		 

	      if data.current.value == 'gc_segciudadanabase' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'torso_1', 38)
	            TriggerEvent('skinchanger:change', 'torso_2', 0)
	            TriggerEvent('skinchanger:change', 'tshirt_1', 135)
	            TriggerEvent('skinchanger:change', 'arms', 0)
	            TriggerEvent('skinchanger:change', 'pants_1', 84)
	            TriggerEvent('skinchanger:change', 'pants_2', 2)
	            TriggerEvent('skinchanger:change', 'shoes_1', 51)
	            TriggerEvent('skinchanger:change', 'shoes_2', 0)
	            TriggerEvent('skinchanger:change', 'chain_1', 117)
	            TriggerEvent('skinchanger:change', 'chain_2', 0)
	            TriggerEvent('skinchanger:change', 'helmet_1', 84)
	            TriggerEvent('skinchanger:change', 'helmet_2', 0)
	          else
	            TriggerEvent('skinchanger:change', 'torso_1', 89)
	            TriggerEvent('skinchanger:change', 'torso_2', 0)
	            TriggerEvent('skinchanger:change', 'tshirt_1', 152)
	            TriggerEvent('skinchanger:change', 'tshirt_2', 0)
	            TriggerEvent('skinchanger:change', 'arms', 14)
	            TriggerEvent('skinchanger:change', 'pants_1', 51)
	            TriggerEvent('skinchanger:change', 'pants_2', 0)
	            TriggerEvent('skinchanger:change', 'shoes_1', 74)
	            TriggerEvent('skinchanger:change', 'shoes_2', 24)
	            TriggerEvent('skinchanger:change', 'chain_1', 0)
	            TriggerEvent('skinchanger:change', 'chain_2', 0)
	            TriggerEvent('skinchanger:change', 'helmet_1', -1)
	            TriggerEvent('skinchanger:change', 'helmet_2', 0)
	            TriggerEvent('skinchanger:change', 'mask_1', -1)
	            TriggerEvent('skinchanger:change', 'mask_2', 0)
	            TriggerEvent('skinchanger:change', 'bags_1', 0)
	            TriggerEvent('skinchanger:change', 'bags_2', 0)
	            TriggerEvent('skinchanger:change', 'glasses_1', 5)
	            TriggerEvent('skinchanger:change', 'glasses_2', 0)
	            TriggerEvent('skinchanger:change', 'bproof_1', 0)
	            TriggerEvent('skinchanger:change', 'bproof_2', 0)
	          end
			  
			  if skin.sex == 1 then
	            TriggerEvent('skinchanger:change', 'torso_1', 48)
	            TriggerEvent('skinchanger:change', 'torso_2', 0)
	            TriggerEvent('skinchanger:change', 'tshirt_1', 15)
	            TriggerEvent('skinchanger:change', 'tshirt_2', 0)
	            TriggerEvent('skinchanger:change', 'arms', 12)
	            TriggerEvent('skinchanger:change', 'pants_1', 75)
	            TriggerEvent('skinchanger:change', 'pants_2', 0)
	            TriggerEvent('skinchanger:change', 'shoes_1', 60)
	            TriggerEvent('skinchanger:change', 'shoes_2', 10)
	            TriggerEvent('skinchanger:change', 'chain_1', 0)
	            TriggerEvent('skinchanger:change', 'chain_2', 0)
	            TriggerEvent('skinchanger:change', 'helmet_1', -1)
	            TriggerEvent('skinchanger:change', 'helmet_2', 0)
	            TriggerEvent('skinchanger:change', 'mask_1', -1)
	            TriggerEvent('skinchanger:change', 'mask_2', 0)
	            TriggerEvent('skinchanger:change', 'bags_1', 0)
	            TriggerEvent('skinchanger:change', 'bags_2', 0)
	            TriggerEvent('skinchanger:change', 'glasses_1', 5)
	            TriggerEvent('skinchanger:change', 'glasses_2', 0)
	            TriggerEvent('skinchanger:change', 'bproof_1', 0)
	            TriggerEvent('skinchanger:change', 'bproof_2', 0)
	          end

	        end)
	      end
	      if data.current.value == 'gc_chubasquero' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'torso_1', 40)
	            TriggerEvent('skinchanger:change', 'torso_2', 0)
	            TriggerEvent('skinchanger:change', 'tshirt_1', 136)
	            TriggerEvent('skinchanger:change', 'arms', 0)
	            TriggerEvent('skinchanger:change', 'chain_1', 0)
	            TriggerEvent('skinchanger:change', 'chain_2', 0)
	          else
	            TriggerEvent('skinchanger:change', 'tshirt_1', 26)
	          end

	        end)
	      end
	      if data.current.value == 'ueibase' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'torso_1', 44)
	            TriggerEvent('skinchanger:change', 'torso_2', 0)
	            TriggerEvent('skinchanger:change', 'arms', 4)
	            TriggerEvent('skinchanger:change', 'chain_1', 0)
	            TriggerEvent('skinchanger:change', 'chain_2', 0)
	            TriggerEvent('skinchanger:change', 'bproof_1', 19)
	            TriggerEvent('skinchanger:change', 'bproof_2', 0)
	            TriggerEvent('skinchanger:change', 'pants_1', 25)
	            TriggerEvent('skinchanger:change', 'pants_2', 0)
	            TriggerEvent('skinchanger:change', 'shoes_1', 25)
	            TriggerEvent('skinchanger:change', 'shoes_2', 0)
	            TriggerEvent('skinchanger:change', 'helmet_1', 85)
	            TriggerEvent('skinchanger:change', 'helmet_2', 0)
	          else
	            TriggerEvent('skinchanger:change', 'tshirt_1', 26)
	          end

	        end)
	      end
	      if data.current.value == 'grsbase' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'torso_1', 38)
	            TriggerEvent('skinchanger:change', 'torso_2', 0)
	            TriggerEvent('skinchanger:change', 'tshirt_1', 135)
	            TriggerEvent('skinchanger:change', 'arms', 0)
	            TriggerEvent('skinchanger:change', 'pants_1', 84)
	            TriggerEvent('skinchanger:change', 'pants_2', 2)
	            TriggerEvent('skinchanger:change', 'shoes_1', 51)
	            TriggerEvent('skinchanger:change', 'shoes_2', 0)
	            TriggerEvent('skinchanger:change', 'chain_1', 117)
	            TriggerEvent('skinchanger:change', 'chain_2', 0)
	            TriggerEvent('skinchanger:change', 'helmet_1', 84)
	            TriggerEvent('skinchanger:change', 'helmet_2', 0)
	            TriggerEvent('skinchanger:change', 'mask_1', 50)
	            TriggerEvent('skinchanger:change', 'mask_2', 0)
	            TriggerEvent('skinchanger:change', 'bags_1', 0)
	            TriggerEvent('skinchanger:change', 'bags_2', 0)
	            TriggerEvent('skinchanger:change', 'glasses_1', 5)
	            TriggerEvent('skinchanger:change', 'glasses_2', 0)
	            TriggerEvent('skinchanger:change', 'bproof_1', 21)
	            TriggerEvent('skinchanger:change', 'bproof_2', 0)
	            TriggerEvent('skinchanger:change', 'decals_1', 11)
                TriggerEvent('skinchanger:change', 'decals_2', 0)
	          else
	            TriggerEvent('skinchanger:change', 'tshirt_1', 26)
	          end

	        end)
	      end
	      if data.current.value == 'gc_segciudadacamiseta1' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'torso_1', 38)
	            TriggerEvent('skinchanger:change', 'torso_2', 0)
	            TriggerEvent('skinchanger:change', 'arms', 0)
	          else
	            TriggerEvent('skinchanger:change', 'tshirt_1', 26)
	          end

	        end)
	      end
	      if data.current.value == 'gc_segciudadacamiseta2' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'torso_1', 34)
	            TriggerEvent('skinchanger:change', 'torso_2', 0)
	            TriggerEvent('skinchanger:change', 'arms', 11)
	          else
	            TriggerEvent('skinchanger:change', 'tshirt_1', 26)
	          end

	        end)
	      end
	      if data.current.value == 'gc_segciudadapantalones1' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'pants_1', 84)
	            TriggerEvent('skinchanger:change', 'pants_2', 2)
	          else
	            TriggerEvent('skinchanger:change', 'tshirt_1', 26)
	          end

	        end)
	      end
	      if data.current.value == 'gc_segciudadapantalones2' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'pants_1', 84)
	            TriggerEvent('skinchanger:change', 'pants_2', 3)
	          else
	            TriggerEvent('skinchanger:change', 'tshirt_1', 26)
	          end

	        end)
	      end
	      if data.current.value == 'chaleco3' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'bproof_1', 20)
	            TriggerEvent('skinchanger:change', 'bproof_2', 8)
	            TriggerEvent('skinchanger:change', 'chain_1', 116)
	            TriggerEvent('skinchanger:change', 'chain_2', 0)
	          else
	            TriggerEvent('skinchanger:change', 'bproof_1', 20)
	            TriggerEvent('skinchanger:change', 'bproof_2', 8)
	            TriggerEvent('skinchanger:change', 'tshirt_1', 132)
	          end

	        end)
	      end
	      if data.current.value == 'armadura2' then
	        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

	          if skin.sex == 0 then
	            TriggerEvent('skinchanger:change', 'bproof_1', 18)
	            TriggerEvent('skinchanger:change', 'bproof_2', 1)
	          else
	            TriggerEvent('skinchanger:change', 'tshirt_1', 26)
	          end

	        end)
	      end
	      if data.current.value == 'anadirArmadura' then
	          SetPedArmour(GetPlayerPed(-1), 100)
	      end
	    end,
	  
  
	  function(data, menu)
  
		menu.close()
  
		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	  end
	)
  
  end


function animaciones()
local player = PlayerPedId()
local ped = GetPlayerPed(-1)
local vehicle = GetVehiclePedIsIn(ped, false)
local puestas = false
local elements = {}
        table.insert(elements, {label = '-= Cascos =-', value = ''})
        table.insert(elements, {label = 'CASCO de MOTO', value = 'opcion7'})
        table.insert(elements, {label = 'CASCO de SAGC', value = 'opcion8'})
        table.insert(elements, {label = 'CASCO de PILOTO', value = 'opcion1'})
        table.insert(elements, {label = 'Quitar Casco', value = 'opcion2'})
        table.insert(elements, {label = '', value = ''})
        table.insert(elements, {label = '-= Chalecos =-', value = ''})
        table.insert(elements, {label = 'TRÁFICO', value = 'opcion6'})
        table.insert(elements, {label = 'UCO', value = 'opcion3'})
        table.insert(elements, {label = 'JUDICIAL', value = 'opcion5'})
        table.insert(elements, {label = 'Quitar CHALECO', value = 'opcion4'})
    ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'client',
    {
        title    = 'Taquilla',
        align    = 'bottom-right',
        elements = elements,
    },
    
    
    function(data, menu)
    --ESX.UI.Menu.CloseAll()
    if data.current.value == 'opcion1' then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
            TriggerEvent('skinchanger:change', 'helmet_1', 83)
            TriggerEvent('skinchanger:change', 'helmet_2', 0)
        end)
    elseif data.current.value == 'opcion2' then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
            TriggerEvent('skinchanger:change', 'helmet_1', -1)
            TriggerEvent('skinchanger:change', 'helmet_2', 0)
            TriggerEvent('skinchanger:change', 'mask_1', 50)
            TriggerEvent('skinchanger:change', 'mask_2', 0)
        end)
    elseif data.current.value == 'opcion3' then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
           TriggerEvent('skinchanger:change', 'bproof_1', 20)
            TriggerEvent('skinchanger:change', 'bproof_2', 6)
        end)
    elseif data.current.value == 'opcion4' then
       ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
           TriggerEvent('skinchanger:change', 'bproof_1', 0)
            TriggerEvent('skinchanger:change', 'bproof_2', 0)
        end)
    elseif data.current.value == 'opcion5' then
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
       TriggerEvent('skinchanger:change', 'bproof_1', 20)
        TriggerEvent('skinchanger:change', 'bproof_2', 7)
    end)
  elseif data.current.value == 'opcion6' then
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
       TriggerEvent('skinchanger:change', 'bproof_1', 20)
        TriggerEvent('skinchanger:change', 'bproof_2', 8)
    end)
  elseif data.current.value == 'opcion7' then
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
       TriggerEvent('skinchanger:change', 'helmet_1', 86)
        TriggerEvent('skinchanger:change', 'helmet_2', 0)
    end)
  elseif data.current.value == 'opcion8' then
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
       TriggerEvent('skinchanger:change', 'helmet_1', 85)
        TriggerEvent('skinchanger:change', 'helmet_2', 0)
    end)
  end

    end,
    function(data, menu)
        menu.close()
        end
    )
end



function OpenArmoryMenu(station)

  if Config.EnableArmoryManagement then

    local elements = {
      {label = _U('get_weapon'), value = 'get_weapon'},
      {label = _U('put_weapon'), value = 'put_weapon'},
      {label = 'Plocka ut från förrådet',  value = 'get_stock'},
      {label = 'Lägg in i förrådet',  value = 'put_stock'}
    }

    if PlayerData.job.grade_name == 'boss' then
      table.insert(elements, {label = _U('buy_weapons'), value = 'buy_weapons'})
    end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory',
      {
        title    = _U('armory'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        if data.current.value == 'get_weapon' then
          OpenGetWeaponMenu()
        end

        if data.current.value == 'put_weapon' then
          OpenPutWeaponMenu()
        end

        if data.current.value == 'buy_weapons' then
          OpenBuyWeaponsMenu(station)
        end

        if data.current.value == 'put_stock' then
              OpenPutStocksMenu()
            end

            if data.current.value == 'get_stock' then
              OpenGetStocksMenu()
            end

      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_armory'
        CurrentActionMsg  = _U('open_armory')
        CurrentActionData = {station = station}
      end
    )

  else

    local elements = {}

    for i=1, #Config.PoliceStations[station].AuthorizedWeapons, 1 do
      local weapon = Config.PoliceStations[station].AuthorizedWeapons[i]
      table.insert(elements, {label = ESX.GetWeaponLabel(weapon.name), value = weapon.name})
    end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory',
      {
        title    = _U('armory'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)
        local weapon = data.current.value
        TriggerServerEvent('esx_policejob:giveWeapon', weapon,  1000)
      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_armory'
        CurrentActionMsg  = _U('open_armory')
        CurrentActionData = {station = station}

      end
    )

  end

end

function OpenVehicleSpawnerMenu(station, partNum)

  local vehicles = Config.PoliceStations[station].Vehicles

  ESX.UI.Menu.CloseAll()

  if Config.EnableSocietyOwnedVehicles then
    
  else

    local elements = {}

    for i=1, #Config.PoliceStations[station].AuthorizedVehicles, 1 do
      local vehicle = Config.PoliceStations[station].AuthorizedVehicles[i]
      table.insert(elements, {label = vehicle.label, value = vehicle.name})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'vehicle_spawner',
      {
        title    = _U('vehicle_menu'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)

        menu.close()

        local model = data.current.value

        local vehicle = GetClosestVehicle(vehicles[partNum].SpawnPoint.x,  vehicles[partNum].SpawnPoint.y,  vehicles[partNum].SpawnPoint.z,  3.0,  0,  71)

        if not DoesEntityExist(vehicle) then

          local playerPed = GetPlayerPed(-1)
          Citizen.Trace(model)
          local coords = {x = vehicles[partNum].SpawnPoint.x, y = vehicles[partNum].SpawnPoint.y, z = vehicles[partNum].SpawnPoint.z}
            Citizen.Trace(model)
            Citizen.Trace(coords.x)
            Citizen.Trace(coords.y)
            Citizen.Trace(coords.z)
            spawn_vehicle(model,coords.x,coords.y,coords.z)
          if Config.MaxInService == -1 then
            local coords = {x = vehicles[partNum].SpawnPoint.x, y = vehicles[partNum].SpawnPoint.y, z = vehicles[partNum].SpawnPoint.z}
            Citizen.Trace(model)
            SpawnVehicle(model,coord)

          else

            ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)

              if canTakeService then

                ESX.Game.SpawnVehicle(model, {
                  x = vehicles[partNum].SpawnPoint.x,
                  y = vehicles[partNum].SpawnPoint.y,
                  z = vehicles[partNum].SpawnPoint.z
                }, vehicles[partNum].Heading, function(vehicle)
                local plate = "CTZN"..math.random(100, 900)
            SetVehicleNumberPlateText(vehicle, plate)
                  TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
                  TriggerServerEvent('llaves:addarrayllaves',GetVehicleNumberPlateText(vehicle),vehicle)
                  TriggerEvent("advancedFuel:setEssence", 100, GetVehicleNumberPlateText(vehicle), GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) 
                end)

              else
                ESX.ShowNotification(_U('service_max') .. inServiceCount .. '/' .. maxInService)
              end

            end, 'police')

          end

        else
          ESX.ShowNotification(_U('vehicle_out'))
        end

      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_vehicle_spawner'
        CurrentActionMsg  = _U('vehicle_spawner')
        CurrentActionData = {station = station, partNum = partNum}

      end
    )

  end

end

function spawn_vehicle(veh,spawnx,spawny,spawnz)
	Citizen.Wait(0)
	local myPed = GetPlayerPed(-1)
	local vehicle = GetHashKey(veh)
	RequestModel(vehicle)
	while not HasModelLoaded(vehicle) do
		Wait(1)
	end
	SetVehicleModKit(vehicle, 0)
	SetVehicleLivery(vehicle, 1)
	local plate = "CTZN"..6969
	local spawned_car = CreateVehicle(vehicle, spawnx,spawny,spawnz, -480.02, 5983.786, 31.1887, true, false)
	SetVehicleNumberPlateText(spawned_car, plate)
	SetVehicleOnGroundProperly(spawned_car)
	SetModelAsNoLongerNeeded(vehicle)
	Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
	TriggerEvent("advancedFuel:setEssence", 100, GetVehicleNumberPlateText(spawned_car), GetDisplayNameFromVehicleModel(GetEntityModel(spawned_car)))
end
function OpenPoliceActionsMenu()

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'police_actions',
    {
      title    = 'Policía',
      align    = 'bottom-right',
      elements = {
        {label = _U('citizen_interaction'), value = 'citizen_interaction'},
        {label = _U('vehicle_interaction'), value = 'vehicle_interaction'},
        {label = _U('object_spawner'),      value = 'object_spawner'},
        {label = 'Reparar vehículo', value = 'reparar'},
		{label = 'Ropa extra', value = 'animaciones'}
      },
    },
    function(data, menu)

      if data.current.value == 'citizen_interaction' then

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'citizen_interaction',
          {
            title    = _U('citizen_interaction'),
            align    = 'bottom-right',
            elements = {
              {label = _U('id_card'),       value = 'identity_card'},
              {label = _U('search'),        value = 'body_search'},
              {label = _U('handcuff'),    value = 'handcuff'},
              {label = _U('drag'),      value = 'drag'},
              {label = _U('put_in_vehicle'),  value = 'put_in_vehicle'},
              {label = _U('out_the_vehicle'), value = 'out_the_vehicle'},
              {label = _U('fine'),            value = 'fine'},
              {label = "Dar licencia de armas",            value = 'weapon'},
              {label = "Revivir",            value = 'revive'},
              {label = "Revisar calconcillos",            value = 'drug_reviser'},
              {label = "Licencia de conducir",            value = 'license'},
            },
          },
          function(data2, menu2)

            local player, distance = ESX.Game.GetClosestPlayer()

            if distance ~= -1 and distance <= 3.0 then

              if data2.current.value == 'identity_card' then
                OpenIdentityCardMenu(player)
              end

              if data2.current.value == 'revive' then
                if player == -1 or distance > 3.0 then
                ESX.ShowNotification("No hay jugadores")
                else
                        local closestPlayerPed = GetPlayerPed(closestPlayer)
                        local health = GetEntityHealth(closestPlayerPed)
                        local playerPed = GetPlayerPed(-1)
                        Citizen.CreateThread(function()
                              ESX.ShowNotification('Revivir en curso')
                              TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                              Wait(10000)
                              ClearPedTasks(playerPed)
                              TriggerServerEvent('esx_ambulancejob:retonivive', GetPlayerServerId(player))
                              ESX.ShowNotification("Se ha reanimado")
                        end)
                end
              end

              if data2.current.value == 'body_search' then
                OpenBodySearchMenu(player)
              end

              if data2.current.value == 'handcuff' then
                TriggerServerEvent('esx_policejob:hatonindcuff', GetPlayerServerId(player))
              end

              if data2.current.value == 'drug_reviser' then
              	TriggerServerEvent('esx_policejob:drugReviser', GetPlayerServerId(player))
              end

              if data2.current.value == 'drag' then
                TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(player))
              end

              if data2.current.value == 'put_in_vehicle' then
                TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(player))
              end

              if data2.current.value == 'out_the_vehicle' then
                  TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(player))
              end

              if data2.current.value == 'license' then
                TriggerServerEvent('esx_policejob:license', GetPlayerServerId(player))
              end

              if data2.current.value == 'fine' then
                OpenFineMenu(player)
              end

              if data2.current.value == 'weapon' then
                  TriggerServerEvent('esx_policejob:addLicense','short_weapon', GetPlayerServerId(player))
              end

            else
              ESX.ShowNotification(_U('no_players_nearby'))
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end

      if data.current.value == 'vehicle_interaction' then

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'vehicle_interaction',
          {
            title    = _U('vehicle_interaction'),
            align    = 'bottom-right',
            elements = {
              {label = _U('vehicle_info'), value = 'vehicle_infos'},
              {label = _U('pick_lock'),    value = 'hijack_vehicle'},
              {label = _U('imp_veh'),       value = 'del_vehicle'},
            },
          },
          function(data2, menu2)
            local coords    = GetEntityCoords(GetPlayerPed(-1))
            local vehicle   = GetClosestVehicle(coords.x,  coords.y,  coords.z,  3.0,  0,  71)

            if DoesEntityExist(vehicle) then

              local vehicleData = ESX.Game.GetVehicleProperties(vehicle)

              if data2.current.value == 'vehicle_infos' then
                OpenVehicleInfosMenu(vehicleData)
              end

              if data2.current.value == 'hijack_vehicle' then

                local playerPed = GetPlayerPed(-1)
                local coords    = GetEntityCoords(playerPed)

                if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then

                  local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  3.0,  0,  71)

                  if DoesEntityExist(vehicle) then

                    Citizen.CreateThread(function()

                      TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)

                      Wait(20000)

                      ClearPedTasksImmediately(playerPed)

                      SetVehicleDoorsLocked(vehicle, 1)
                      SetVehicleDoorsLockedForAllPlayers(vehicle, false)

                      TriggerEvent('esx:showNotification', _U('vehicle_unlocked'))

                    end)

                  end

                end

              end

            else
              ESX.ShowNotification(_U('no_vehicles_nearby'))
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end

      if data.current.value == 'animaciones' then
          animaciones()
      end

      if data.current.value == 'object_spawner' then

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'citizen_interaction',
          {
            title    = _U('traffic_interaction'),
            align    = 'bottom-right',
            elements = {
              {label = _U('cone'),     value = 'prop_roadcone02a'},
              {label = _U('barrier'), value = 'prop_barrier_work06a'},
              {label = 'Cartel alto policía', value = 'prop_barrier_work05'},
              {label = _U('spikestrips'),    value = 'p_ld_stinger_s'}
            },
          },
          function(data2, menu2)


            local model     = data2.current.value
            local playerPed = GetPlayerPed(-1)
            local coords    = GetEntityCoords(playerPed)
            local forward   = GetEntityForwardVector(playerPed)
            local x, y, z   = table.unpack(coords + forward * 1.0)

            if model == 'prop_roadcone02a' then
              z = z - 1.0
              --z = z + 10
            end

            ESX.Game.SpawnObject(model, {
              x = x,
              y = y,
              z = z
            }, function(obj)

              SetEntityHeading(obj, GetEntityHeading(playerPed))
              PlaceObjectOnGroundProperly(obj)
            end)

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end
      if data.current.value == 'reparar' then
              local playerPed = GetPlayerPed(-1)
              local coords    = GetEntityCoords(playerPed)

              if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

                local vehicle = nil

                if IsPedInAnyVehicle(playerPed, false) then
                  vehicle = GetVehiclePedIsIn(playerPed, false)
                else
                  vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
                end

                if DoesEntityExist(vehicle) then
                  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
                  Citizen.CreateThread(function()
                    Citizen.Wait(20000)
                    SetVehicleFixed(vehicle)
                    SetVehicleDeformationFixed(vehicle)
                    SetVehicleUndriveable(vehicle, false)
                    SetVehicleEngineOn(vehicle,  true,  true)
                    ClearPedTasksImmediately(playerPed)
                    ESX.ShowNotification(_U('vehicle_repaired'))
                  end)
                end
              end
        end
		if data.current.value == 'reparar' then
		chalecos()
		end
    end,
    function(data, menu)

      menu.close()

    end
  )

end

function OpenIdentityCardMenu(player)

  if Config.EnableESXIdentity then

    ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)

      local jobLabel    = nil
      local sexLabel    = nil
      local sex         = nil
      local dobLabel    = nil
      local heightLabel = nil
      local idLabel     = nil

      if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
        jobLabel = 'Trabajo : ' .. data.job.label .. ' - ' .. data.job.grade_label
      else
        jobLabel = 'Trabajo : ' .. data.job.label
      end

      if data.sex ~= nil then
        if (data.sex == 'm') or (data.sex == 'M') then
          sex = 'Hombre'
        else
          sex = 'Mujer'
        end
        sexLabel = 'Sexo : ' .. sex
      else
        sexLabel = 'Sexo : Desconocido'
      end

      if data.dob ~= nil then
        dobLabel = 'Fecha de nacimiento : ' .. data.dob
      else
        dobLabel = 'Fecha de nacimiento : Desconocido'
      end

      if data.height ~= nil then
        heightLabel = 'Altura : ' .. data.height
      else
        heightLabel = 'Altura : Desconocido'
      end

      if data.name ~= nil then
        idLabel = 'ID : ' .. data.name
      else
        idLabel = 'ID : Desconocido'
      end

      local elements = {
        {label = _U('name') .. data.firstname .. " " .. data.lastname, value = nil},
        {label = sexLabel,    value = nil},
        {label = dobLabel,    value = nil},
        {label = heightLabel, value = nil},
        {label = jobLabel,    value = nil},
        {label = idLabel,     value = nil},
      }

      if data.drunk ~= nil then
        table.insert(elements, {label = _U('bac') .. data.drunk .. '%', value = nil})
      end

      if data.licenses ~= nil then

        table.insert(elements, {label = '--- Licencias ---', value = nil})

        for i=1, #data.licenses, 1 do
          table.insert(elements, {label = data.licenses[i].label, value = nil})
        end

      end

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'citizen_interaction',
        {
          title    = _U('citizen_interaction'),
          align    = 'bottom-right',
          elements = elements,
        },
        function(data, menu)

        end,
        function(data, menu)
          menu.close()
        end
      )

    end, GetPlayerServerId(player))

  else

    ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)

      local jobLabel = nil

      if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
        jobLabel = 'Job : ' .. data.job.label .. ' - ' .. data.job.grade_label
      else
        jobLabel = 'Job : ' .. data.job.label
      end

        local elements = {
          {label = _U('name') .. data.name, value = nil},
          {label = jobLabel,              value = nil},
        }

      if data.drunk ~= nil then
        table.insert(elements, {label = _U('bac') .. data.drunk .. '%', value = nil})
      end

      if data.licenses ~= nil then

        table.insert(elements, {label = '--- Licenses ---', value = nil})

        for i=1, #data.licenses, 1 do
          table.insert(elements, {label = data.licenses[i].label, value = nil})
        end

      end

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'citizen_interaction',
        {
          title    = _U('citizen_interaction'),
          align    = 'bottom-right',
          elements = elements,
        },
        function(data, menu)

        end,
        function(data, menu)
          menu.close()
        end
      )

    end, GetPlayerServerId(player))

  end

end

function OpenBodySearchMenu(player)

  ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)

    local elements = {}

    local blackMoney = 0

    for i=1, #data.accounts, 1 do
      if data.accounts[i].name == 'black_money' then
        blackMoney = data.accounts[i].money
      end
    end

    table.insert(elements, {
      label          = _U('confiscate_dirty') .. blackMoney,
      value          = 'black_money',
      itemType       = 'item_account',
      amount         = blackMoney
    })

    table.insert(elements, {label = '--- Armes ---', value = nil})

    for i=1, #data.weapons, 1 do
      table.insert(elements, {
        label          = _U('confiscate') .. ESX.GetWeaponLabel(data.weapons[i].name),
        value          = data.weapons[i].name,
        itemType       = 'item_weapon',
        amount         = data.ammo,
      })
    end

    table.insert(elements, {label = _U('inventory_label'), value = nil})

    for i=1, #data.inventory, 1 do
      if data.inventory[i].count > 0 then
        table.insert(elements, {
          label          = _U('confiscate_inv') .. data.inventory[i].count .. ' ' .. data.inventory[i].label,
          value          = data.inventory[i].name,
          itemType       = 'item_standard',
          amount         = data.inventory[i].count,
        })
      end
    end


    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'body_search',
      {
        title    = _U('search'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)

        local itemType = data.current.itemType
        local itemName = data.current.value
        local amount   = data.current.amount

        if data.current.value ~= nil then

          TriggerServerEvent('esx_policejob:confiscarPlayerItemPop', GetPlayerServerId(player), itemType, itemName, amount)

          OpenBodySearchMenu(player)

        end

      end,
      function(data, menu)
        menu.close()
      end
    )

  end, GetPlayerServerId(player))

end

function OpenFineMenu(player)

  ESX.UI.Menu.Open(
    'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
    {
      title = 'Precio de la multa'
    },
    function(data, menu)

      local count = tonumber(data.value)

      if count == nil or count <= 0 then
        ESX.ShowNotification('Precio inválido')
      else
        if Config.EnablePlayerManagement then
          TriggerServerEvent('esx_bitonilling:sendBill', GetPlayerServerId(player), 'society_police', 'Multa', count)
        else
          TriggerServerEvent('esx_bitonilling:sendBill', GetPlayerServerId(player), '', 'Multa', count)
        end
      end
    end,
    function(data2, menu2)
      menu2.close()
    end
  )


end

function OpenFineCategoryMenu(player, category)

  ESX.TriggerServerCallback('esx_policejob:getFineList', function(fines)

    local elements = {}

    for i=1, #fines, 1 do
      table.insert(elements, {
        label     = fines[i].label .. ' $' .. fines[i].amount,
        value     = fines[i].id,
        amount    = fines[i].amount,
        fineLabel = fines[i].label
      })
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'fine_category',
      {
        title    = _U('fine'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)

        local label  = data.current.fineLabel
        local amount = data.current.amount

        menu.close()

        if Config.EnablePlayerManagement then
          TriggerServerEvent('esx_bitonilling:sendBill', GetPlayerServerId(player), 'society_police', _U('fine_total') .. label, amount)
        else
          TriggerServerEvent('esx_bitonilling:sendBill', GetPlayerServerId(player), '', _U('fine_total') .. label, amount)
        end

        ESX.SetTimeout(300, function()
          OpenFineCategoryMenu(player, category)
        end)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end, category)

end

function OpenVehicleInfosMenu(vehicleData)
  Citizen.Trace("Hello")
  ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(infos)
    Citizen.Trace("Hello")

    local elements = {}

    table.insert(elements, {label = _U('plate') .. infos.plate, value = nil})

    if infos.owner == nil then
      table.insert(elements, {label = _U('owner_unknown'), value = nil})
    else
      table.insert(elements, {label = _U('owner') .. infos.owner, value = nil})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'vehicle_infos',
      {
        title    = _U('vehicle_info'),
        align    = 'bottom-right',
        elements = elements,
      },
      nil,
      function(data, menu)
        menu.close()
      end
    )

  end, vehicleData.plate)

end

function OpenGetWeaponMenu()

  ESX.TriggerServerCallback('esx_policejob:getArmoryWeapons', function(weapons)

    local elements = {}

    for i=1, #weapons, 1 do
      if weapons[i].count > 0 then
        table.insert(elements, {label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name), value = weapons[i].name})
      end
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory_get_weapon',
      {
        title    = _U('get_weapon_menu'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)

        menu.close()

        ESX.TriggerServerCallback('esx_policejob:removeArmoryWeapon', function()
          OpenGetWeaponMenu()
        end, data.current.value)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenPutWeaponMenu()

  local elements   = {}
  local playerPed  = GetPlayerPed(-1)
  local weaponList = ESX.GetWeaponList()

  for i=1, #weaponList, 1 do

    local weaponHash = GetHashKey(weaponList[i].name)

    if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
      local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
      table.insert(elements, {label = weaponList[i].label, value = weaponList[i].name})
    end

  end

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'armory_put_weapon',
    {
      title    = _U('put_weapon_menu'),
      align    = 'bottom-right',
      elements = elements,
    },
    function(data, menu)

      menu.close()

      ESX.TriggerServerCallback('esx_policejob:addArmoryWeapon', function()
        OpenPutWeaponMenu()
      end, data.current.value)

    end,
    function(data, menu)
      menu.close()
    end
  )

end

RegisterNetEvent('esx_policejob:setD')
AddEventHandler('esx_policejob:setD', function(a,b,c,d,e,f,g,h,i,j,obj)

    local elements = {
    	{label = "Dimetiglioxima : "..a,value = "nothing"},
    	{label = "Piridina : "..b,value = "nothing"},
    	{label = "Ácido cloroplatínico : "..c,value = "nothing"},
    	{label = "Nitrato de potasio : "..d,value = "nothing"},
    	{label = "Carbonato de sodio : "..e,value = "nothing"},
    	{label = "Dicromato de sodio : "..f,value = "nothing"},
    	{label = "Cajas : "..j,value = "nothing"},
    	{label = "Metalina : "..g,value = "nothing"},
    	{label = "Pestosina : "..h,value = "nothing"},
    	{label = "Repersina : "..i,value = "nothing"},
    	{label = "Retirar droga",value = "yes",obj = obj},
	}

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'drug_menu',
      {
        title    = "Revisar calzoncillos",
        align    = 'bottom-right',
        elements = elements
      },
      function(data, menu)

        local option = data.current.value
        local target = data.current.obj

        if option == 'yes' then
        	TriggerServerEvent('esx_policejob:setDrugNone',target)
        end
      end,
      function(data, menu)
        menu.close()
      end
    )
end)

function OpenBuyWeaponsMenu(station)

  ESX.TriggerServerCallback('esx_policejob:getArmoryWeapons', function(weapons)

    local elements = {}

    for i=1, #Config.PoliceStations[station].AuthorizedWeapons, 1 do

      local weapon = Config.PoliceStations[station].AuthorizedWeapons[i]
      local count  = 0

      for i=1, #weapons, 1 do
        if weapons[i].name == weapon.name then
          count = weapons[i].count
          break
        end
      end

      table.insert(elements, {label = 'x' .. count .. ' ' .. ESX.GetWeaponLabel(weapon.name) .. ' $' .. weapon.price, value = weapon.name, price = weapon.price})

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory_buy_weapons',
      {
        title    = _U('buy_weapon_menu'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)

        ESX.TriggerServerCallback('esx_policejob:comprarPop', function(hasEnoughMoney)

          if hasEnoughMoney then
            ESX.TriggerServerCallback('esx_policejob:addArmoryWeapon', function()
              OpenBuyWeaponsMenu(station)
            end, data.current.value)
          else
            ESX.ShowNotification(_U('not_enough_money'))
          end

        end, data.current.price)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenGetStocksMenu()

  ESX.TriggerServerCallback('esx_policejob:getStockItems', function(items)

    print(json.encode(items))

    local elements = {}

    for i=1, #items, 1 do
      table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
        title    = _U('police_stock'),
        align    = 'bottom-right',
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
          {
            title = _U('quantity')
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('quantity_invalid'))
            else
              menu2.close()
              menu.close()
              OpenGetStocksMenu()

              TriggerServerEvent('esx_policejob:getStockItem', itemName, count)
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenPutStocksMenu()

  ESX.TriggerServerCallback('esx_policejob:getPlayerInventory', function(inventory)

    local elements = {}

    for i=1, #inventory.items, 1 do

      local item = inventory.items[i]

      if item.count > 0 then
        table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
      end

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
        title    = _U('inventory'),
        align    = 'bottom-right',
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
          {
            title = _U('quantity')
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('quantity_invalid'))
            else
              menu2.close()
              menu.close()
              OpenPutStocksMenu()

              TriggerServerEvent('esx_policejob:putStockItems', itemName, count)
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('esx_policejob:licensed')
AddEventHandler('esx_policejob:licensed', function(lcs)
  local elements = {}
  if lcs == true then
    elements = {
    {label = "Este hombre <span style='color : green;'>SI</span> tiene la licencia",value = "yes"},
    {label = "Retirar licencia",value = "retire"}
    }
    
  else
    elements = {
      {label = "Este hombre <span style='color : red;'>NO</span> tiene la licencia",value = "no"}
      }
  end

  if lcs == true then
    Citizen.Trace("true")
  else
    Citizen.Trace("false")
  end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'license',
      {
        title    = "Licencia de conducir",
        align    = 'bottom-right',
        elements = elements
      },
      function(data, menu)
        local player, distance = ESX.Game.GetClosestPlayer()

        if distance ~= -1 and distance <= 3.0 then
          if data.current.value == "retire" then
            TriggerServerEvent('esx_policejob:retireLicense', GetPlayerServerId(player))
            menu.close()
          end
        end
      end,
      function(data, menu)
        menu.close()
      end
    )
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)

  local specialContact = {
    name       = 'Guardia Civil',
    number     = 'police',
    base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDFGQTJDRkI0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDFGQTJDRkM0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0MUZBMkNGOTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0MUZBMkNGQTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PoW66EYAAAjGSURBVHjapJcLcFTVGcd/u3cfSXaTLEk2j80TCI8ECI9ABCyoiBqhBVQqVG2ppVKBQqUVgUl5OU7HKqNOHUHU0oHamZZWoGkVS6cWAR2JPJuAQBPy2ISEvLN57+v2u2E33e4k6Ngz85+9d++95/zP9/h/39GpqsqiRYsIGz8QZAq28/8PRfC+4HT4fMXFxeiH+GC54NeCbYLLATLpYe/ECx4VnBTsF0wWhM6lXY8VbBE0Ch4IzLcpfDFD2P1TgrdC7nMCZLRxQ9AkiAkQCn77DcH3BC2COoFRkCSIG2JzLwqiQi0RSmCD4JXbmNKh0+kc/X19tLtc9Ll9sk9ZS1yoU71YIk3xsbEx8QaDEc2ttxmaJSKC1ggSKBK8MKwTFQVXRzs3WzpJGjmZgvxcMpMtWIwqsjztvSrlzjYul56jp+46qSmJmMwR+P3+4aZ8TtCprRkk0DvUW7JjmV6lsqoKW/pU1q9YQOE4Nxkx4ladE7zd8ivuVmJQfXZKW5dx5EwPRw4fxNx2g5SUVLw+33AkzoRaQDP9SkFu6OKqz0uF8yaz7vsOL6ycQVLkcSg/BlWNsjuFoKE1knqDSl5aNnmPLmThrE0UvXqQqvJPyMrMGorEHwQfEha57/3P7mXS684GFjy8kreLppPUuBXfyd/ibeoS2kb0mWPANhJdYjb61AxUvx5PdT3+4y+Tb3mTd19ZSebE+VTXVGNQlHAC7w4VhH8TbA36vKq6ilnzlvPSunHw6Trc7XpZ14AyfgYeyz18crGN1Alz6e3qwNNQSv4dZox1h/BW9+O7eIaEsVv41Y4XeHJDG83Nl4mLTwzGhJYtx0PzNTjOB9KMTlc7Nkcem39YAGU7cbeBKVLMPGMVf296nMd2VbBq1wmizHoqqm/wrS1/Zf0+N19YN2PIu1fcIda4Vk66Zx/rVi+jo9eIX9wZGGcFXUMR6BHUa76/2ezioYcXMtpyAl91DSaTfDxlJbtLprHm2ecpObqPuTPzSNV9yKz4a4zJSuLo71/j8Q17ON69EmXiPIlNMe6FoyzOqWPW/MU03Lw5EFcyKghTrNDh7+/vw545mcJcWbTiGKpRdGPMXbx90sGmDaux6sXk+kimjU+BjnMkx3kYP34cXrFuZ+3nrHi6iDMt92JITcPjk3R3naRwZhpuNSqoD93DKaFVU7j2dhcF8+YzNlpErbIBTVh8toVccbaysPB+4pMcuPw25kwSsau7BIlmHpy3guaOPtISYyi/UkaJM5Lpc5agq5Xkcl6gIHkmqaMn0dtylcjIyPThCNyhaXyfR2W0I1our0v6qBii07ih5rDtGSOxNVdk1y4R2SR8jR/g7hQD9l1jUeY/WLJB5m39AlZN4GZyIQ1fFJNsEgt0duBIc5GRkcZF53mNwIzhXPDgQPoZIkiMkbTxtstDMVnmFA4cOsbz2/aKjSQjev4Mp9ZAg+hIpFhB3EH5Yal16+X+Kq3dGfxkzRY+KauBjBzREvGN0kNCTARu94AejBLMHorAQ7cEQMGs2cXvkWshYLDi6e9l728O8P1XW6hKeB2yv42q18tjj+iFTGoSi+X9jJM9RTxS9E+OHT0krhNiZqlbqraoT7RAU5bBGrEknEBhgJks7KXbLS8qERI0ErVqF/Y4K6NHZfLZB+/wzJvncacvFd91oXO3o/O40MfZKJOKu/rne+mRQByXM4lYreb1tUnkizVVA/0SpfpbWaCNBeEE5gb/UH19NLqEgDF+oNDQWcn41Cj0EXFEWqzkOIyYekslFkThsvMxpIyE2hIc6lXGZ6cPyK7Nnk5OipixRdxgUESAYmhq68VsGgy5CYKCUAJTg0+izApXne3CJFmUTwg4L3FProFxU+6krqmXu3MskkhSD2av41jLdzlnfFrSdCZxyqfMnppN6ZUa7pwt0h3fiK9DCt4IO9e7YqisvI7VYgmNv7mhBKKD/9psNi5dOMv5ZjukjsLdr0ffWsyTi6eSlfcA+dmiVyOXs+/sHNZu3M6PdxzgVO9GmDSHsSNqmTz/R6y6Xxqma4fwaS5Mn85n1ZE0Vl3CHBER3lUNEhiURpPJRFdTOcVnpUJnPIhR7cZXfoH5UYc5+E4RzRH3sfSnl9m2dSMjE+Tz9msse+o5dr7UwcQ5T3HwlWUkNuzG3dKFSTbsNs7m/Y8vExOlC29UWkMJlAxKoRQMR3IC7x85zOn6fHS50+U/2Untx2R1voinu5no+DQmz7yPXmMKZnsu0wrm0Oe3YhOVHdm8A09dBQYhTv4T7C+xUPrZh8Qn2MMr4qcDSRfoirWgKAvtgOpv1JI8Zi77X15G7L+fxeOUOiUFxZiULD5fSlNzNM62W+k1yq5gjajGX/ZHvOIyxd+Fkj+P092rWP/si0Qr7VisMaEWuCiYonXFwbAUTWWPYLV245NITnGkUXnpI9butLJn2y6iba+hlp7C09qBcvoN7FYL9mhxo1/y/LoEXK8Pv6qIC8WbBY/xr9YlPLf9dZT+OqKTUwfmDBm/GOw7ws4FWpuUP2gJEZvKqmocuXPZuWYJMzKuSsH+SNwh3bo0p6hao6HeEqwYEZ2M6aKWd3PwTCy7du/D0F1DsmzE6/WGLr5LsDF4LggnYBacCOboQLHQ3FFfR58SR+HCR1iQH8ukhA5s5o5AYZMwUqOp74nl8xvRHDlRTsnxYpJsUjtsceHt2C8Fm0MPJrphTkZvBc4It9RKLOFx91Pf0Igu0k7W2MmkOewS2QYJUJVWVz9VNbXUVVwkyuAmKTFJayrDo/4Jwe/CT0aGYTrWVYEeUfsgXssMRcpyenraQJa0VX9O3ZU+Ma1fax4xGxUsUVFkOUbcama1hf+7+LmA9juHWshwmwOE1iMmCFYEzg1jtIm1BaxW6wCGGoFdewPfvyE4ertTiv4rHC73B855dwp2a23bbd4tC1hvhOCbX7b4VyUQKhxrtSOaYKngasizvwi0RmOS4O1QZf2yYfiaR+73AvhTQEVf+rpn9/8IMAChKDrDzfsdIQAAAABJRU5ErkJggg=='
  }

  TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)

end)

AddEventHandler('esx_policejob:hasEnteredMarker', function(station, part, partNum)

  if part == 'Cloakroom' then
    CurrentAction     = 'menu_cloakroom'
    CurrentActionMsg  = _U('open_cloackroom')
    CurrentActionData = {}
  end

  if part == 'Armory' then
    CurrentAction     = 'menu_armory'
    CurrentActionMsg  = _U('open_armory')
    CurrentActionData = {station = station}
  end

  if part == 'VehicleSpawner' then
    CurrentAction     = 'menu_vehicle_spawner'
    CurrentActionMsg  = _U('vehicle_spawner')
    CurrentActionData = {station = station, partNum = partNum}
  end

  if part == 'HelicopterSpawner' then
--[[
    local helicopters = Config.PoliceStations[station].Helicopters

    if not IsAnyVehicleNearPoint(helicopters[partNum].SpawnPoint.x, helicopters[partNum].SpawnPoint.y, helicopters[partNum].SpawnPoint.z,  3.0) then

      ESX.Game.SpawnVehicle('polmav', {
        x = helicopters[partNum].SpawnPoint.x,
        y = helicopters[partNum].SpawnPoint.y,
        z = helicopters[partNum].SpawnPoint.z
      }, helicopters[partNum].Heading, function(vehicle)
      local plate = "CTZN"..math.random(100, 900)
            SetVehicleNumberPlateText(vehicle, plate)
        SetVehicleModKit(vehicle, 0)
        TriggerServerEvent('llaves:addarrayllaves',GetVehicleNumberPlateText(vehicle),vehicle)
        TriggerEvent("advancedFuel:setEssence", 100, GetVehicleNumberPlateText(vehicle), GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) 
        SetVehicleLivery(vehicle, 0)
      end)
]]
   -- end no más spawn helis random

  end

  if part == 'VehicleDeleter' then

    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)

    if IsPedInAnyVehicle(playerPed,  false) then

      local vehicle = GetVehiclePedIsIn(playerPed, false)

      if DoesEntityExist(vehicle) then
        CurrentAction     = 'delete_vehicle'
        CurrentActionMsg  = _U('store_vehicle')
        CurrentActionData = {vehicle = vehicle}
      end

    end

  end

  if part == 'BossActions' then
    CurrentAction     = 'menu_boss_actions'
    CurrentActionMsg  = _U('open_bossmenu')
    CurrentActionData = {}
  end

end)

AddEventHandler('esx_policejob:hasExitedMarker', function(station, part, partNum)
  ESX.UI.Menu.CloseAll()
  CurrentAction = nil
end)

AddEventHandler('esx_policejob:hasEnteredEntityZone', function(entity)

  local playerPed = GetPlayerPed(-1)

  if PlayerData.job ~= nil and PlayerData.job.name == 'police' and not IsPedInAnyVehicle(playerPed, false) then
    CurrentAction     = 'remove_entity'
    CurrentActionMsg  = _U('remove_object')
    CurrentActionData = {entity = entity}
  end

  if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then

    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)

    if IsPedInAnyVehicle(playerPed,  false) then

      local vehicle = GetVehiclePedIsIn(playerPed)

      for i=0, 7, 1 do
        SetVehicleTyreBurst(vehicle,  i,  true,  1000)
      end

    end

  end

end)

AddEventHandler('esx_policejob:hasExitedEntityZone', function(entity)

  if CurrentAction == 'remove_entity' then
    CurrentAction = nil
  end

end)

RegisterNetEvent('esx_policejob:hatonindcuff')
AddEventHandler('esx_policejob:hatonindcuff', function()

  IsHandcuffed    = not IsHandcuffed;
  local playerPed = GetPlayerPed(-1)

  Citizen.CreateThread(function()

    if IsHandcuffed then

      RequestAnimDict('mp_arresting')

      while not HasAnimDictLoaded('mp_arresting') do
        Wait(100)
      end

      TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
      SetEnableHandcuffs(playerPed, true)
      SetPedCanPlayGestureAnims(playerPed, false)
      FreezeEntityPosition(playerPed,  true)

    else

      ClearPedSecondaryTask(playerPed)
      SetEnableHandcuffs(playerPed, false)
      SetPedCanPlayGestureAnims(playerPed,  true)
      FreezeEntityPosition(playerPed, false)

    end

  end)
end)

RegisterNetEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(cop)
  TriggerServerEvent('esx:clientLog', 'starting dragging')
  IsDragged = not IsDragged
  CopPed = tonumber(cop)
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      if IsDragged then
        local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
        local myped = GetPlayerPed(-1)
        AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
      else
        DetachEntity(GetPlayerPed(-1), true, false)
      end
    end
  end
end)

RegisterNetEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function()

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

    local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  5.0,  0,  71)

    if DoesEntityExist(vehicle) then

      local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
      local freeSeat = nil

      for i=maxSeats - 1, 0, -1 do
        if IsVehicleSeatFree(vehicle,  i) then
          freeSeat = i
          break
        end
      end

      if freeSeat ~= nil then
        TaskWarpPedIntoVehicle(playerPed,  vehicle,  freeSeat)
      end

    end

  end

end)

RegisterNetEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function(t)
  local ped = GetPlayerPed(t)
  ClearPedTasksImmediately(ped)
  plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
  local xnew = plyPos.x+2
  local ynew = plyPos.y+2

  SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)

-- Handcuff
Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      DisableControlAction(0, 142, true) -- MeleeAttackAlternate
      DisableControlAction(0, 30,  true) -- MoveLeftRight
      DisableControlAction(0, 31,  true) -- MoveUpDown
    end
  end
end)

-- Create blips
Citizen.CreateThread(function()

  for k,v in pairs(Config.PoliceStations) do

    local blip = AddBlipForCoord(v.Blip.Pos.x, v.Blip.Pos.y, v.Blip.Pos.z)

    SetBlipSprite (blip, v.Blip.Sprite)
    SetBlipDisplay(blip, v.Blip.Display)
    SetBlipScale  (blip, v.Blip.Scale)
    SetBlipColour (blip, v.Blip.Color)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(_U('map_blip'))
    EndTextCommandSetBlipName(blip)

  end

end)

-- Display markers
Citizen.CreateThread(function()
  while true do

    Wait(0)

    if PlayerData.job ~= nil and PlayerData.job.name == 'police' then

      local playerPed = GetPlayerPed(-1)
      local coords    = GetEntityCoords(playerPed)

      for k,v in pairs(Config.PoliceStations) do

        for i=1, #v.Cloakrooms, 1 do
          if GetDistanceBetweenCoords(coords,  v.Cloakrooms[i].x,  v.Cloakrooms[i].y,  v.Cloakrooms[i].z,  true) < Config.DrawDistance then
            DrawMarker(Config.MarkerType, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        for i=1, #v.Armories, 1 do
          if GetDistanceBetweenCoords(coords,  v.Armories[i].x,  v.Armories[i].y,  v.Armories[i].z,  true) < Config.DrawDistance then
            DrawMarker(Config.MarkerType, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        for i=1, #v.Vehicles, 1 do
          if GetDistanceBetweenCoords(coords,  v.Vehicles[i].Spawner.x,  v.Vehicles[i].Spawner.y,  v.Vehicles[i].Spawner.z,  true) < Config.DrawDistance then
            DrawMarker(Config.MarkerType, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        for i=1, #v.VehicleDeleters, 1 do
          if GetDistanceBetweenCoords(coords,  v.VehicleDeleters[i].x,  v.VehicleDeleters[i].y,  v.VehicleDeleters[i].z,  true) < Config.DrawDistance then
            DrawMarker(Config.MarkerType, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.name == 'police' and PlayerData.job.grade_name == 'boss' then

          for i=1, #v.BossActions, 1 do
            if not v.BossActions[i].disabled and GetDistanceBetweenCoords(coords,  v.BossActions[i].x,  v.BossActions[i].y,  v.BossActions[i].z,  true) < Config.DrawDistance then
              DrawMarker(Config.MarkerType, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
            end
          end

        end

      end

    end

  end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()

  while true do

    Wait(0)

    if PlayerData.job ~= nil and PlayerData.job.name == 'police' then

      local playerPed      = GetPlayerPed(-1)
      local coords         = GetEntityCoords(playerPed)
      local isInMarker     = false
      local currentStation = nil
      local currentPart    = nil
      local currentPartNum = nil

      for k,v in pairs(Config.PoliceStations) do

        for i=1, #v.Cloakrooms, 1 do
          if GetDistanceBetweenCoords(coords,  v.Cloakrooms[i].x,  v.Cloakrooms[i].y,  v.Cloakrooms[i].z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'Cloakroom'
            currentPartNum = i
          end
        end

        for i=1, #v.Armories, 1 do
          if GetDistanceBetweenCoords(coords,  v.Armories[i].x,  v.Armories[i].y,  v.Armories[i].z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'Armory'
            currentPartNum = i
          end
        end

        for i=1, #v.Vehicles, 1 do

          if GetDistanceBetweenCoords(coords,  v.Vehicles[i].Spawner.x,  v.Vehicles[i].Spawner.y,  v.Vehicles[i].Spawner.z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleSpawner'
            currentPartNum = i
          end

          if GetDistanceBetweenCoords(coords,  v.Vehicles[i].SpawnPoint.x,  v.Vehicles[i].SpawnPoint.y,  v.Vehicles[i].SpawnPoint.z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleSpawnPoint'
            currentPartNum = i
          end

        end

        for i=1, #v.Helicopters, 1 do

          if GetDistanceBetweenCoords(coords,  v.Helicopters[i].Spawner.x,  v.Helicopters[i].Spawner.y,  v.Helicopters[i].Spawner.z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'HelicopterSpawner'
            currentPartNum = i
          end

          if GetDistanceBetweenCoords(coords,  v.Helicopters[i].SpawnPoint.x,  v.Helicopters[i].SpawnPoint.y,  v.Helicopters[i].SpawnPoint.z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'HelicopterSpawnPoint'
            currentPartNum = i
          end

        end

        for i=1, #v.VehicleDeleters, 1 do
          if GetDistanceBetweenCoords(coords,  v.VehicleDeleters[i].x,  v.VehicleDeleters[i].y,  v.VehicleDeleters[i].z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleDeleter'
            currentPartNum = i
          end
        end

        if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.name == 'police' and PlayerData.job.grade_name == 'boss' then

          for i=1, #v.BossActions, 1 do
            if GetDistanceBetweenCoords(coords,  v.BossActions[i].x,  v.BossActions[i].y,  v.BossActions[i].z,  true) < Config.MarkerSize.x then
              isInMarker     = true
              currentStation = k
              currentPart    = 'BossActions'
              currentPartNum = i
            end
          end

        end

      end

      local hasExited = false

      if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum) ) then

        if
          (LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
          (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
        then
          TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
          hasExited = true
        end

        HasAlreadyEnteredMarker = true
        LastStation             = currentStation
        LastPart                = currentPart
        LastPartNum             = currentPartNum

        TriggerEvent('esx_policejob:hasEnteredMarker', currentStation, currentPart, currentPartNum)
      end

      if not hasExited and not isInMarker and HasAlreadyEnteredMarker then

        HasAlreadyEnteredMarker = false

        TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
      end

    end

  end
end)

-- Enter / Exit entity zone events
Citizen.CreateThread(function()

  local trackedEntities = {
    'prop_roadcone02a',
    'prop_barrier_work06a',
    'prop_barrier_work05',
    'p_ld_stinger_s'
  }

  while true do

    Citizen.Wait(0)

    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)

    local closestDistance = -1
    local closestEntity   = nil

    for i=1, #trackedEntities, 1 do

      local object = GetClosestObjectOfType(coords.x,  coords.y,  coords.z,  3.0,  GetHashKey(trackedEntities[i]), false, false, false)

      if DoesEntityExist(object) then

        local objCoords = GetEntityCoords(object)
        local distance  = GetDistanceBetweenCoords(coords.x,  coords.y,  coords.z,  objCoords.x,  objCoords.y,  objCoords.z,  true)

        if closestDistance == -1 or closestDistance > distance then
          closestDistance = distance
          closestEntity   = object
        end

      end

    end

    if closestDistance ~= -1 and closestDistance <= 3.0 then

      if LastEntity ~= closestEntity then
        TriggerEvent('esx_policejob:hasEnteredEntityZone', closestEntity)
        LastEntity = closestEntity
      end

    else

      if LastEntity ~= nil then
        TriggerEvent('esx_policejob:hasExitedEntityZone', LastEntity)
        LastEntity = nil
      end

    end

  end
end)

-- Key Controls
Citizen.CreateThread(function()
  while true do

    Citizen.Wait(0)

    if CurrentAction ~= nil then

      SetTextComponentFormat('STRING')
      AddTextComponentString(CurrentActionMsg)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)

      if IsControlPressed(0,  Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'police' and (GetGameTimer() - GUI.Time) > 150 then

        if CurrentAction == 'menu_cloakroom' then
          OpenCloakroomMenu()
        end

        if CurrentAction == 'menu_armory' then
          OpenArmoryMenu(CurrentActionData.station)
        end

        if CurrentAction == 'menu_vehicle_spawner' then
          OpenVehicleSpawnerMenu(CurrentActionData.station, CurrentActionData.partNum)
        end

        if CurrentAction == 'delete_vehicle' then

          if Config.EnableSocietyOwnedVehicles then

            local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
            TriggerServerEvent('esx_society:putVehicletoniInGarage', 'police', vehicleProps)

          else

            if
              GetEntityModel(vehicle) == GetHashKey('police')  or
              GetEntityModel(vehicle) == GetHashKey('police2') or
              GetEntityModel(vehicle) == GetHashKey('police3') or
              GetEntityModel(vehicle) == GetHashKey('police4') or
              GetEntityModel(vehicle) == GetHashKey('policeb') or
              GetEntityModel(vehicle) == GetHashKey('policet')
            then
              TriggerServerEvent('esx_service:disableService', 'police')
              TriggerServerEvent('llaves:removearrayllaves',GetVehicleNumberPlateText(CurrentActionData.vehicle))
            end

          end

          ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
        end

        if CurrentAction == 'menu_boss_actions' then

          ESX.UI.Menu.CloseAll()

          TriggerEvent('esx_society:openBostonisMenu', 'police', function(data, menu)

            menu.close()

            CurrentAction     = 'menu_boss_actions'
            CurrentActionMsg  = _U('open_bossmenu')
            CurrentActionData = {}

          end)

        end

        if CurrentAction == 'remove_entity' then
          DeleteEntity(CurrentActionData.entity)
        end

        CurrentAction = nil
        GUI.Time      = GetGameTimer()

      end

    end

    if IsControlPressed(0,  Keys['F6']) and PlayerData.job ~= nil and PlayerData.job.name == 'police' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') and (GetGameTimer() - GUI.Time) > 150 then
      OpenPoliceActionsMenu()
      GUI.Time = GetGameTimer()
    end

  end
end)
