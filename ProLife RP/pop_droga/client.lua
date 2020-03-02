------------------------------
----------REGISTROS-----------
------------------------------
RegisterNetEvent('pop_droga:comprobadopol')
RegisterNetEvent('pop_droga:setvar')
RegisterNetEvent('pop_droga:adddrug')
RegisterNetEvent('pop_droga:starthold')
RegisterNetEvent('pop_droga:holdsuccessc')
RegisterNetEvent('pop_droga:startholdc')
RegisterNetEvent('pop_droga:holdcsu')
RegisterNetEvent('pop_droga:cerrcaja')
RegisterNetEvent('pop_droga:poln')
RegisterNetEvent('pop_droga:havemoney')
------------------------------
----------LLAMADAS------------
------------------------------
AddEventHandler('playerSpawned', function(spawn)
	TriggerServerEvent('pop_droga:comprobarpol')
	TriggerServerEvent('pop_droga:accountexist')
end)
TriggerServerEvent('pop_droga:comprobarpol')
TriggerServerEvent('pop_droga:accountexist')
------------------------------
------------BLIPS-------------
------------------------------
local blips = {
	{title="Robo de caravana", colour=17, id=162,x = 1391.36, y = 3617.0, z = 37.92},
	{title="Robo de cajas", colour=17, id=162,x = -670.56, y = 5829.8,z = 16.32}
}
Citizen.CreateThread(function()
    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.9)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)
------------------------------
----------VARIABLES-----------
------------------------------
local polis = 0
local ems = 0
local mecanos = 0
local carplate = ""
--COMPROBACIÓN--
local guiVisible = 0
local isPolice = nil
--LABORATORIO--
local cantidad = 50
local fila = 1
local lab = {x = 2429.52, y = 4962.4, z = 45.8}
local isout = true
--INGREDIENTES--
local dimetilglioxima = 0
local piridina = 0
local acloroplatinico = 0
local npotasio = 0
local csodio = 0
local dsodio = 0
--DROGAS--
local metalina = 0
local pestosina = 0
local repersina = 0
--ROBO DE CARAVANA--
local isRobbering = false
local seconds = 5
--ROBO DE CAJAS--
local cajas = 0
local isRobberingc = false
local robu = {x = -670.56, y = 5829.8,z = 16.32}
--VENTAS--
local prison = {x = 1828.24, y = 2539.4,z = 44.88}
local pass = 0
local isinchat = false
local isincarcel = false
local inttoprision = math.random(100,200)
local metnpc = {x = 1673.92,y = 2520.72,z = 44.56}
local pesnpc = {x = 1704.92,y = 2551.28,z = 44.56}
local repnpc = {x = 1758.24,y = 2513.96,z = 44.56}
local carseg = 100
--SetEntityCoords(GetPlayerPed(-1),   1673.92,2520.72, 44.56)
--LOCALIZACIONES--
local locations = {
	pastshop = {x = 614.64, y = 2784.24, z = 42.48},
	furgholdup = {x = 1391.36, y = 3617.0, z = 37.92},
	cerrajero = {x = -127.28, y = 2793.84, z = 52.12},
	lab = {x = 2434.6, y = 4968.4,z = 41.36}
}
--SetEntityCoords(GetPlayerPed(-1),robu.x,robu.y,robu.z)
------------------------------
------HILOS ALTERNATIVOS------
------------------------------
Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
		DrawMarker(1,locations.pastshop.x,locations.pastshop.y,locations.pastshop.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,100,96,99, 200, 0, 0, 0, 0)
		DrawMarker(1,locations.cerrajero.x,locations.cerrajero.y,locations.cerrajero.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,100,96,99, 200, 0, 0, 0, 0)
		if isPolice == 0 then
			----------------------------------
			--ROBO DE CARAVANA DE HEISENBERG--
			----------------------------------
			if isRobbering == false then
				DrawMarker(1,locations.furgholdup.x,locations.furgholdup.y,locations.furgholdup.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,100,96,99, 200, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(locations.furgholdup.x,locations.furgholdup.y,locations.furgholdup.z, GetEntityCoords(GetPlayerPed(-1),true)) < 1.5 then
					drawTxt("PULSA <E> PARA ROBAR EL FURGON DE DROGA",2, 1, 0.45, 0.03, 0.80,100,96,99,255)
					if IsControlJustPressed(1,38) then
							TriggerServerEvent('pop_droga:holdcomprovate')
					end
				end
			end
			if isRobbering then
				drawTxt("QUEDAN "..seconds.." SEGUNDOS",2, 1, 0.45, 0.93, 0.80,100,96,99,255)
			end
			if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), false), "Journey") then
				drawTxt("DETRAS DEL VEHICULO HAY CAJAS CERRADAS",2, 1, 0.5, 0.9, 0.60,255,255,255,255)
				drawTxt("TENDRAS QUE BUSCAR A AQUEL VIEJO CERRAJERO QUE CONOCISTES EN ALAMO SEA",2, 1, 0.5, 0.93, 0.60,255,255,255,255)
			end
			if GetDistanceBetweenCoords(locations.cerrajero.x,locations.cerrajero.y,locations.cerrajero.z, GetEntityCoords(GetPlayerPed(-1),true)) < 1.5 then
				drawTxt("PULSA <E> PARA HABLAR UN CERRAJERO",2, 1, 0.45, 0.03, 0.80,100,96,99,255)
				if IsControlJustPressed(1,38) then
					if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), false), "Journey") and cajas >= 0 then
						local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
						SetEntityAsMissionEntity( vehicle, true, true )
						local platecaissei = GetVehicleNumberPlateText(vehicle)
						if GetVehiclePedIsIn(GetPlayerPed(-1), false) then
							local plate = "CTZN"..5576
							SetVehicleNumberPlateText(vehicle, plate)
			               	deleteCar( vehicle )
			               	TriggerEvent('chatMessage', "El rastas ", {0, 0, 255}, "A ver killo, yoh puedo hacerte un apaño con esas cajitas, pero no le digas nada a los pikoletos.")
			               	TriggerServerEvent('pop_droga:holdsuccess',acloroplatinico,npotasio,csodio,dsodio)
		           		else
			               	TriggerEvent('chatMessage', "El rastas ", {0, 0, 255}, "Lo siento killo pero no hay cajas.")
		           		end
		            elseif IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), false), "Journey") and cajas <= 0 then
		            	local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
						SetEntityAsMissionEntity( vehicle, true, true )
		               	deleteCar( vehicle )
		               	TriggerEvent('chatMessage', "El rastas ", {0, 0, 255}, "A ver killo, yoh puedo hacerte un apaño con esas cajitas, pero no le digas nada a los pikoletos.")
		               	TriggerServerEvent('pop_droga:holdsuccess',acloroplatinico,npotasio,csodio,dsodio)
		            elseif cajas >= 1 then
		            	TriggerServerEvent('pop_droga:sellbox',cajas)
					else
						TriggerEvent('chatMessage', "El rastas ", {0, 0, 255}, "No tienes nada para mí.")
					end
				end
			end
			---------------------
			--COMPRAR PASTILLAS--
			---------------------
			if GetDistanceBetweenCoords(locations.pastshop.x,locations.pastshop.y,locations.pastshop.z, GetEntityCoords(GetPlayerPed(-1),true)) < 1.5 then
				drawTxt("PULSA <E> PARA INTENRTAR COMPRAR PASTILLAS",2, 1, 0.45, 0.03, 0.80,100,96,99,255)
				if IsControlJustPressed(1,38) then
					local drug = "dimetilglioxima"
					local cant = dimetilglioxima + 1
					TriggerServerEvent('pop_droga:adddimetilglioxima',cant,drug)
				end
			end
			-----------------
			--ROBO DE CAJAS--
			-----------------
			DrawMarker(1,robu.x,robu.y,robu.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,100,96,99, 200, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(robu.x,robu.y,robu.z, GetEntityCoords(GetPlayerPed(-1),true)) < 1.5 and isRobberingc == false then
				drawTxt("PULSA <E> PARA ROBAR ESTA CASA",2, 1, 0.45, 0.03, 0.80,100,96,99,255)
				if IsControlJustPressed(1,38) then
							TriggerServerEvent('pop_droga:holdc')
				end
			end
			if isRobberingc then
				drawTxt("QUEDAN "..seconds.." SEGUNDOS",2, 1, 0.45, 0.93, 0.80,100,96,99,255)
			end
			-------
			--LAB--
			-------
			DrawMarker(1,locations.lab.x,locations.lab.y,locations.lab.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,100,96,99, 200, 0, 0, 0, 0)
			if get3DDistance(locations.lab.x,locations.lab.y,locations.lab.z, x, y, z ) < 1.5 then
				DisplayHelpText("Puedes cambiar la cantidad de droga y el tipo de droga con las flechas")
				if fila == 1 then
					drawTxt("PULSA ~g~E~w~ PARA FABRICAR ~b~".. cantidad .."G~w~ DE ~r~METALINA~w~",2, 1, 0.5, 0.85, 0.80,255,255,255,255)
					if cantidad == 50 then
						local pas = 5
						local pes = 150
						local pis = 15
						drawTxt("NECESITAS",2, 1, 0.895, 0.3, 0.85,255,255,255,255)
						drawTxt("PASTILLAS DE DIMETILGLIOXIMA",2, 1, 0.862, 0.35, 0.5,255,255,255,255)
						drawTxt("ACIDO CLOROPLATINICO",2, 1, 0.885, 0.38, 0.5,255,255,255,255)
						drawTxt("DICROMATO DE SODIO",2, 1, 0.890, 0.41, 0.5,255,255,255,255)
						drawTxt(""..pas,2, 1, 0.965, 0.35, 0.5,0,255,119,255)
						drawTxt(pes.."ML",2, 1, 0.965, 0.38, 0.5,0,255,119,255)
						drawTxt(pis.."G",2, 1,0.965, 0.41, 0.5,0,255,119,255)	
					elseif cantidad == 200 then
						local pas = 20
						local pes = 600
						local pis = 60
						drawTxt("NECESITAS",2, 1, 0.895, 0.3, 0.85,255,255,255,255)
						drawTxt("PASTILLAS DE DIMETILGLIOXIMA",2, 1, 0.862, 0.35, 0.5,255,255,255,255)
						drawTxt("ACIDO CLOROPLATINICO",2, 1, 0.885, 0.38, 0.5,255,255,255,255)
						drawTxt("DICROMATO DE SODIO",2, 1, 0.890, 0.41, 0.5,255,255,255,255)
						drawTxt(""..pas,2, 1, 0.965, 0.35, 0.5,0,255,119,255)
						drawTxt(pes.."ML",2, 1, 0.965, 0.38, 0.5,0,255,119,255)
						drawTxt(pis.."G",2, 1,0.965, 0.41, 0.5,0,255,119,255)
					elseif cantidad == 500 then
						local pas = 50
						local pes = 1500
						local pis = 150
						drawTxt("NECESITAS",2, 1, 0.895, 0.3, 0.85,255,255,255,255)
						drawTxt("PASTILLAS DE DIMETILGLIOXIMA",2, 1, 0.862, 0.35, 0.5,255,255,255,255)
						drawTxt("ACIDO CLOROPLATINICO",2, 1, 0.885, 0.38, 0.5,255,255,255,255)
						drawTxt("DICROMATO DE SODIO",2, 1, 0.890, 0.41, 0.5,255,255,255,255)
						drawTxt(""..pas,2, 1, 0.965, 0.35, 0.5,0,255,119,255)
						drawTxt(pes.."ML",2, 1, 0.965, 0.38, 0.5,0,255,119,255)
						drawTxt(pis.."G",2, 1,0.965, 0.41, 0.5,0,255,119,255)
					end
					if IsControlJustPressed(1,38) then
						if cantidad == 50 then
							pas = 5
							pes = 150
							pis = 15
						elseif cantidad == 200 then
							pas = 20
							pes = 600
							pis = 60
						elseif cantidad == 500 then
							pas = 50
							pes = 1500
							pis = 150
						end
						if dimetilglioxima >= pas and acloroplatinico >= pes and dsodio >= pis then
							dimetilglioxima = dimetilglioxima - pas
							acloroplatinico = acloroplatinico - pes
							dsodio = dsodio - pis
							metalina = metalina + cantidad
							TriggerEvent('chatMessage', "INFO ", {0, 0, 255}, "Fabricando..., pero antes un cigarrillo")
							fabricar_droga()
							Citizen.Wait(15000)
							TriggerServerEvent('pop_droga:adddrug',dimetilglioxima,acloroplatinico,dsodio,"metalina",metalina)
							
						else
							TriggerEvent('chatMessage', "Miguel Reyes ", {0, 0, 255}, "Te faltan componentes.")
						end
					end
				elseif fila == 2 then
					drawTxt("PULSA ~g~E~w~ PARA FABRICAR ~b~".. cantidad .."G~w~ DE ~r~PESTOSINA~w~",2, 1, 0.5, 0.85, 0.80,255,255,255,255)
					if cantidad == 50 then
						local pas = 150
						local pes = 100
						local pis = 5
						drawTxt("NECESITAS",2, 1, 0.895, 0.3, 0.85,255,255,255,255)
						drawTxt("PIRIDINA",2, 1, 0.917, 0.35, 0.5,255,255,255,255)
						drawTxt("NITRATO DE POTASIO",2, 1, 0.890, 0.38, 0.5,255,255,255,255)
						drawTxt("DICROMATO DE SODIO",2, 1, 0.890, 0.41, 0.5,255,255,255,255)
						drawTxt(pas.."ML",2, 1, 0.965, 0.35, 0.5,0,255,119,255)
						drawTxt(pes.."G",2, 1, 0.965, 0.38, 0.5,0,255,119,255)
						drawTxt(pis.."G",2, 1,0.965, 0.41, 0.5,0,255,119,255)
					elseif cantidad == 200 then
						local pas = 600
						local pes = 400
						local pis = 20
						drawTxt("NECESITAS",2, 1, 0.895, 0.3, 0.85,255,255,255,255)
						drawTxt("PIRIDINA",2, 1, 0.917, 0.35, 0.5,255,255,255,255)
						drawTxt("NITRATO DE POTASIO",2, 1, 0.890, 0.38, 0.5,255,255,255,255)
						drawTxt("DICROMATO DE SODIO",2, 1, 0.890, 0.41, 0.5,255,255,255,255)
						drawTxt(pas.."ML",2, 1, 0.965, 0.35, 0.5,0,255,119,255)
						drawTxt(pes.."G",2, 1, 0.965, 0.38, 0.5,0,255,119,255)
						drawTxt(pis.."G",2, 1,0.965, 0.41, 0.5,0,255,119,255)
					elseif cantidad == 500 then
						local pas = 1500
						local pes = 1000
						local pis = 50
						drawTxt("NECESITAS",2, 1, 0.895, 0.3, 0.85,255,255,255,255)
						drawTxt("PIRIDINA",2, 1, 0.917, 0.35, 0.5,255,255,255,255)
						drawTxt("NITRATO DE POTASIO",2, 1, 0.890, 0.38, 0.5,255,255,255,255)
						drawTxt("DICROMATO DE SODIO",2, 1, 0.890, 0.41, 0.5,255,255,255,255)
						drawTxt(pas.."ML",2, 1, 0.965, 0.35, 0.5,0,255,119,255)
						drawTxt(pes.."G",2, 1, 0.965, 0.38, 0.5,0,255,119,255)
						drawTxt(pis.."G",2, 1,0.965, 0.41, 0.5,0,255,119,255)
					end
					if IsControlJustPressed(1,38) then
						if cantidad == 50 then
							pas = 150
							pes = 100
							pis = 5
						elseif cantidad == 200 then
							pas = 600
							pes = 400
							pis = 20
						elseif cantidad == 500 then
							pas = 1500
							pes = 1000
							pis = 50
						end
						if piridina >= pas and npotasio >= pes and dsodio >= pis then
							piridina = piridina - pas
							npotasio = npotasio - pes
							dsodio = dsodio - pis
							pestosina = pestosina + cantidad
							TriggerEvent('chatMessage', "INFO ", {0, 0, 255}, "Fabricando..., pero antes un cigarrillo")
							fabricar_droga()
							Citizen.Wait(15000)
							TriggerServerEvent('pop_droga:adddrug',piridina,npotasio,dsodio,"pestosina",pestosina)
						else
							TriggerEvent('chatMessage', "Miguel Reyes ", {0, 0, 255}, "Te faltan componentes.")
						end
					end
				elseif fila == 3 then
					drawTxt("PULSA ~g~E~w~ PARA FABRICAR ~b~".. cantidad .."G~w~ DE ~r~REPERSINA~w~",2, 1, 0.5, 0.85, 0.80,255,255,255,255)
					if cantidad == 50 then
						local pas = 70
						local pes = 70
						local pis = 80
						drawTxt("NECESITAS",2, 1, 0.895, 0.3, 0.85,255,255,255,255)
						drawTxt("ACIDO CLOROPLATINICO",2, 1, 0.885, 0.35, 0.5,255,255,255,255)
						drawTxt("PIRIDINA",2, 1, 0.917, 0.38, 0.5,255,255,255,255)
						drawTxt("CARBONATO DE SODIO",2, 1, 0.890, 0.41, 0.5,255,255,255,255)
						drawTxt(pas.."ML",2, 1, 0.965, 0.35, 0.5,0,255,119,255)
						drawTxt(pes.."ML",2, 1, 0.965, 0.38, 0.5,0,255,119,255)
						drawTxt(pis.."G",2, 1,0.965, 0.41, 0.5,0,255,119,255)
					elseif cantidad == 200 then
						local pas = 280
						local pes = 280
						local pis = 320
						drawTxt("NECESITAS",2, 1, 0.895, 0.3, 0.85,255,255,255,255)
						drawTxt("ACIDO CLOROPLATINICO",2, 1, 0.885, 0.35, 0.5,255,255,255,255)
						drawTxt("PIRIDINA",2, 1, 0.917, 0.38, 0.5,255,255,255,255)
						drawTxt("CARBONATO DE SODIO",2, 1, 0.890, 0.41, 0.5,255,255,255,255)
						drawTxt(pas.."ML",2, 1, 0.965, 0.35, 0.5,0,255,119,255)
						drawTxt(pes.."ML",2, 1, 0.965, 0.38, 0.5,0,255,119,255)
						drawTxt(pis.."G",2, 1,0.965, 0.41, 0.5,0,255,119,255)
					elseif cantidad == 500 then
						local pas = 700
						local pes = 700
						local pis = 800
						drawTxt("NECESITAS",2, 1, 0.895, 0.3, 0.85,255,255,255,255)
						drawTxt("ACIDO CLOROPLATINICO",2, 1, 0.885, 0.35, 0.5,255,255,255,255)
						drawTxt("PIRIDINA",2, 1, 0.917, 0.38, 0.5,255,255,255,255)
						drawTxt("CARBONATO DE SODIO",2, 1, 0.890, 0.41, 0.5,255,255,255,255)
						drawTxt(pas.."ML",2, 1, 0.965, 0.35, 0.5,0,255,119,255)
						drawTxt(pes.."ML",2, 1, 0.965, 0.38, 0.5,0,255,119,255)
						drawTxt(pis.."G",2, 1,0.965, 0.41, 0.5,0,255,119,255)
					end
					if IsControlJustPressed(1,38) then
						if cantidad == 50 then
							pas = 70
							pes = 70
							pis = 80
						elseif cantidad == 200 then
							pas = 280
							pes = 280
							pis = 320
						elseif cantidad == 500 then
							pas = 700
							pes = 700
							pis = 800
						end
						if acloroplatinico >= pas and piridina >= pes and csodio >= pis then
							acloroplatinico = acloroplatinico - pas
							piridina = piridina - pes
							csodio = csodio - pis
							repersina = repersina + cantidad
							TriggerEvent('chatMessage', "INFO ", {0, 0, 255}, "Fabricando..., pero antes un cigarrillo")
							fabricar_droga()
							Citizen.Wait(15000)
							TriggerServerEvent('pop_droga:adddrug',acloroplatinico,piridina,csodio,"repersina",repersina)
						else
							TriggerEvent('chatMessage', "Miguel Reyes ", {0, 0, 255}, "Te faltan componentes.")
						end
					end
				end
			end
			if GetDistanceBetweenCoords(lab.x,lab.y,lab.z, x,y,z) < 1.5 then
				if isout then
					TriggerEvent('chatMessage', "Miguel Reyes | ", {0, 0, 255}, "Bienvenido a mi compañia, por favor no rompa los instrumentos.")
					isout = false
				end
			end
			if IsControlJustPressed(1,27) then
				if cantidad == 50 then
					cantidad = 200
				elseif cantidad == 200 then
					cantidad = 500
				elseif cantidad == 500 then
					cantidad = 50
				end
			end
			if IsControlJustPressed(1,173) then
				if cantidad == 500 then
					cantidad = 200
				elseif cantidad == 200 then
					cantidad = 50
				elseif cantidad == 50 then
					cantidad = 500
				end
			end
			if IsControlJustPressed(1,174) then
				if fila == 3 then
					fila = 2
				elseif fila == 2 then
					fila = 1
				elseif fila == 1 then
					fila = 3
				end
			end
			if IsControlJustPressed(1,175) then
				if fila == 1 then
					fila = 2
				elseif fila == 2 then
					fila = 3
				elseif fila == 3 then
					fila = 1
				end
			end
			-------
			--GUI--
			-------
			if IsControlJustPressed(1,244) then
				if guiVisible == 0 then
					guiVisible = 1
				elseif guiVisible == 1 then
					guiVisible = 2
				elseif guiVisible == 2 then
					guiVisible = 0
				end
			end
			if guiVisible == 1 then
				drawTxt("INGREDIENTES",2, 1, 0.095, 0.3, 0.85,255,255,255,255)
				drawTxt("PASTILLAS DE DIMETILGLIOXIMA",2, 1, 0.118, 0.35, 0.5,255,255,255,255)
				drawTxt("PIRIDINA",2, 1, 0.068, 0.38, 0.5,255,255,255,255)
				drawTxt("ACIDO CLOROPLATINICO",2, 1, 0.1, 0.41, 0.5,255,255,255,255)
				drawTxt("NITRATO DE POTASIO",2, 1, 0.094, 0.44, 0.5,255,255,255,255)
				drawTxt("CARBONATO DE SODIO",2, 1, 0.094, 0.47, 0.5,255,255,255,255)
				drawTxt("DICROMATO DE SODIO",2, 1, 0.094, 0.50, 0.5,255,255,255,255)
				drawTxt("CAJAS",2, 1, 0.060, 0.53, 0.5,255,255,255,255)

				drawTxt(""..dimetilglioxima,2, 1, 0.024, 0.35, 0.5,0,255,119,255)
				drawTxt(piridina.."ML",2, 1, 0.024, 0.38, 0.5,0,255,119,255)
				drawTxt(acloroplatinico.."ML",2, 1,0.024, 0.41, 0.5,0,255,119,255)
				drawTxt(npotasio.."G",2, 1,0.024, 0.44, 0.5,0,255,119,255)
				drawTxt(csodio.."G",2, 1, 0.024, 0.47, 0.5,0,255,119,255)
				drawTxt(dsodio.."G",2, 1, 0.024, 0.50, 0.5,0,255,119,255)
				drawTxt(""..cajas,2, 1, 0.024, 0.53, 0.5,255,20,20,255)
			elseif guiVisible == 2 then
				drawTxt("DROGAS",2, 1, 0.07, 0.3, 0.85,255,255,255,255)
				drawTxt("METALINA",2, 1, 0.066, 0.35, 0.5,255,255,255,255)
				drawTxt("PESTOSINA",2, 1, 0.068, 0.38, 0.5,255,255,255,255)
				drawTxt("REPERSINA",2, 1, 0.068, 0.41, 0.5,255,255,255,255)

				drawTxt(metalina.."G",2, 1, 0.024, 0.35, 0.5,0,255,119,255)
				drawTxt(pestosina.."G",2, 1, 0.024, 0.38, 0.5,0,255,119,255)
				drawTxt(repersina.."G",2, 1,0.024, 0.41, 0.5,0,255,119,255)
			else

			end
		end
	end
end)

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
		DrawMarker(1,prison.x,prison.y,prison.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,100,96,99, 200, 0, 0, 0, 0)
		if get3DDistance(prison.x,prison.y,prison.z, x, y, z ) < 1.5 then
			if isinchat == false then
				DisplayHelpText("Pulsa E para hablar con el guardia de seguridad.")
				if IsControlJustPressed(1,38) then
					actprison()
					isinchat = true
					pass = 0
					Citizen.Wait(4000)
					pass = 1
					Citizen.Wait(4000)
					pass = 2
					Citizen.Wait(8000)
					pass = 3
					Citizen.Wait(8000)
					pass = 4
				end
			end
		end
		if isincarcel == true then
			DrawMarker(1,metnpc.x,metnpc.y,metnpc.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,100,96,99, 200, 0, 0, 0, 0)
			DrawMarker(1,pesnpc.x,pesnpc.y,pesnpc.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,100,96,99, 200, 0, 0, 0, 0)
			DrawMarker(1,repnpc.x,repnpc.y,repnpc.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,100,96,99, 200, 0, 0, 0, 0)
			if get3DDistance(metnpc.x,metnpc.y,metnpc.z, x, y, z ) < 1.5 then
				DisplayHelpText("Pulsa E para vender 50 g de metalina.")
				if IsControlJustPressed(1,38) then
					if metalina >= 50 then
						metalina = metalina - 50
						TriggerServerEvent('pop_droga:selldrug',"metalina",metalina)
						Citizen.Wait(100)
					else
						TriggerEvent('chatMessage', "Info | ", {0, 0, 255}, "No tienes suficiente droga.")
					end
				end
			elseif get3DDistance(pesnpc.x,pesnpc.y,pesnpc.z, x, y, z ) < 1.5 then
				DisplayHelpText("Pulsa E para vender 50 g de pestosina.")
				if IsControlJustPressed(1,38) then
					if pestosina >= 50 then
						pestosina = pestosina - 50
						TriggerServerEvent('pop_droga:selldrug',"pestosina",pestosina)
						Citizen.Wait(100)
					else
						TriggerEvent('chatMessage', "Info | ", {0, 0, 255}, "No tienes suficiente droga.")
					end
				end
			elseif get3DDistance(repnpc.x,repnpc.y,repnpc.z, x, y, z ) < 1.5 then
				DisplayHelpText("Pulsa E para vender 50 g de repersina.")
				if IsControlJustPressed(1,38) then
					if repersina >= 50 then
						repersina = repersina - 50
						TriggerServerEvent('pop_droga:selldrug',"repersina",repersina)
						Citizen.Wait(100)
					else
						TriggerEvent('chatMessage', "Info | ", {0, 0, 255}, "No tienes suficiente droga.")
					end
				end
			end
		end
	end
end)
------------------------------
----------FUNCIONES-----------
------------------------------
function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x , y)
end

function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

function starthold()
	Citizen.CreateThread(function()
		while true do
			if GetDistanceBetweenCoords(locations.furgholdup.x,locations.furgholdup.y,locations.furgholdup.z, GetEntityCoords(GetPlayerPed(-1),true)) < 10 then
				if seconds >= 1 and isRobbering then
					Citizen.Wait(1000)
					seconds = seconds - 1
				else
					isRobbering = false
					spawn_vehicle("Journey",1400.4,3629.08,34.88)	
					TriggerServerEvent('pop_droga:stopRobbing')
					break
				end
			else
				isRobbering = false
				TriggerEvent('chatMessage', "El jhony ", {0, 0, 255}, "Eh hijo de puto vas a robar a tu puta madre, a tomar por culo activo las medidas de seguridad.")
				TriggerServerEvent('pop_droga:stopRobbing')
				TriggerServerEvent('pop_droga:cancelled')
				break
			end
		end
	end)
end

function startholdc()
	Citizen.CreateThread(function()
		while true do
			if GetDistanceBetweenCoords(robu.x,robu.y,robu.z, GetEntityCoords(GetPlayerPed(-1),true)) < 10 then
				if seconds >= 1 and isRobberingc then
					Citizen.Wait(1000)
					seconds = seconds - 1
				else
					isRobberingc = false
					TriggerServerEvent('pop_droga:holdcs',cajas)
					TriggerServerEvent('pop_droga:stopRobbing')
					break
				end
			else
				isRobberingc = false
				TriggerEvent('chatMessage', "Información ", {255, 0, 0}, "Has dejado el ganzuador automatico activa y te has alejado mucho y te lo han gitaneado.")
				TriggerServerEvent('pop_droga:stopRobbing')
				TriggerServerEvent('pop_droga:cancelled')
				break
			end
		end
	end)
end
--SetEntityCoords(GetPlayerPed(-1),  1828.24,  2539.4, 44.88)
function startsell()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if carseg >= 1  then
				Citizen.Wait(1000)
				carseg = carseg - 1
			elseif carseg < 1 then
				finishSell()
				break
			end
			Citizen.Trace(1000)
		end
	end)
end

function finishSell()
	carseg = 100
	isinchat = false
	isincarcel = false
	pass = 999
	SetEntityCoords(GetPlayerPed(-1),  1828.24,  2539.4, 44.88)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function get3DDistance(x1, y1, z1, x2, y2, z2)
	local a = (x1 - x2) * (x1 - x2)
	local b = (y1 - y2) * (y1 - y2)
	local c = (z1 - z2) * (z1 - z2)
    return math.sqrt(a + b + c)
end

function spawn_vehicle(veh,spawnx,spawny,spawnz)
	Citizen.Wait(0)
	local myPed = GetPlayerPed(-1)
	local vehicle = GetHashKey(veh)
	RequestModel(vehicle)
	while not HasModelLoaded(vehicle) do
		Wait(1)
	end
	local plate = "CTZN"..5575
	local spawned_car = CreateVehicle(vehicle, spawnx,spawny,spawnz, 431.436, - 996.786, 25.1887, true, false)
	SetVehicleNumberPlateText(spawned_car, plate)
	SetVehicleOnGroundProperly(spawned_car)
	SetModelAsNoLongerNeeded(vehicle)
	Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
end

function fabricar_droga()
	Citizen.CreateThread(function ()
		local ped = GetPlayerPed(-1)
		FreezeEntityPosition(ped,true)
		TaskStartScenarioInPlace(ped, "WORLD_HUMAN_SMOKING", 0, true)
		Citizen.Wait(15000)
		ClearPedTasks(ped)
		FreezeEntityPosition(ped,false)
	end)
end

function actprison()
	Citizen.CreateThread(function ()
		while true do
			Citizen.Wait(0)
			if pass == 0 then
				drawTxt("~r~GUARDA~w~ ESPERO QUE SEPAS LO QUE HACES",2, 1, 0.5, 0.9, 0.60,255,255,255,255)
			elseif pass == 1 then
				drawTxt("~r~GUARDA~w~ HAY GENTE DE TODO TIPO DENTRO",2, 1, 0.5, 0.9, 0.60,255,255,255,255)
			elseif pass == 2 then
				drawTxt("~r~GUARDA~w~ PUEDES ENCONTRARTE DESDE CHIVATOS HASTA DROGADICTOS QUE TE COMPREN TODA LA DROGA",2, 1, 0.5, 0.9, 0.60,255,255,255,255)
			elseif pass == 3 then
				drawTxt("~r~GUARDA~w~ RECUERDA QUE NO TE DELATARE Y SI ME ENTERO DE QUE ME DELATAS YA SABES LO QUE TE ESPERA",2, 1, 0.5, 0.9, 0.60,255,255,255,255)
			elseif pass == 4 then
				drawTxt("~r~GUARDA~w~ ESTA VEZ TE COSTARA BARATO "..inttoprision.." EUROS",2, 1, 0.5, 0.9, 0.60,255,255,255,255)
				DisplayHelpText("Pulsa E para aceptar el trato, pulsa U para denegarlo.")
				if IsControlJustPressed(1,38) then
					TriggerServerEvent('pop_droga:removemoney', inttoprision)
				elseif IsControlJustPressed(1,303) then
					TriggerEvent('chatMessage', "Guardia ", {0, 0, 255}, "Otro día sera.")
					isinchat = false
					break
				end
			elseif pass == 5 then
				drawTxt("~r~VENDE LA DROGA~w~ QUEDAN "..carseg.."S",2, 1, 0.5, 0.9, 0.60,255,255,255,255)
			else
				break
			end
		end
	end)
end
------------------------------
----------EVENTOS R-----------
------------------------------

--COMPROBAR SI ERES POLI--
AddEventHandler('pop_droga:comprobadopol',function(rol)
	if rol == "police" then
		isPolice = 1
	else
		isPolice = 0
	end
end)

--SETEAR LAS DROGAS DE LA BD--
AddEventHandler('pop_droga:setvar',function(
	redimetilglioxima,
	repiridina,
	reacloroplatinico,
	renpotasio,
	recsodio,
	redsodio,
	remetalina,
	repestosina,
	rerepersina,
	recajas)
	dimetilglioxima = redimetilglioxima
	piridina = repiridina
	acloroplatinico = reacloroplatinico
	npotasio = renpotasio
	csodio = recsodio
	dsodio = redsodio
	metalina = remetalina
	pestosina = repestosina
	repersina = rerepersina
	cajas = recajas
end)

--AÑADE A LA GUI LAS PASTILLAS COMPRADAS--
AddEventHandler('pop_droga:adddrug',function(cant, drug)
	if drug == "dimetilglioxima" then
		dimetilglioxima = cant
	end
end)

--INICIA EL ROBO DE CARAVANA Y EL CONTADOR--
AddEventHandler('pop_droga:starthold',function(reaming)
	isRobbering = true
	seconds = reaming
	starthold()
end)

--AÑADE
AddEventHandler('pop_droga:holdsuccessc',function(ab,cd,ef,gh)
	acloroplatinico = ab
	npotasio = cd
	csodio = ef
	dsodio = gh
end)

AddEventHandler('pop_droga:startholdc',function(reaming)
	isRobberingc = true
	seconds = reaming
	startholdc()
end)

AddEventHandler('pop_droga:holdcsu',function(recajasu)
	cajas = 3
end)

AddEventHandler('pop_droga:holdcsu',function(cant, drug)
		cajas = cant
end)

AddEventHandler('pop_droga:cerrcaja',function(cant,repiridina)
		cajas = cant
		piridina = repiridina
end)

AddEventHandler('pop_droga:havemoney',function(havemoney)
	if havemoney then
		SetEntityCoords(GetPlayerPed(-1),  1570.56 , 2524.48,  45.6)
		pass = 5
		isincarcel = true
		startsell()
	else
		isinchat = false
		pass = 999
	end
end)

AddEventHandler('pop_droga:poln',function(cant,cant2,cant3)
		polis = cant
		ems = cant2
		mecanos = cant3
end)