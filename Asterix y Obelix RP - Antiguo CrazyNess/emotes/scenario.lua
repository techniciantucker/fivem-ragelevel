local looped = 8
local looped2 = 16
local prop = nil
local hotkeysEnabled = false
 
Citizen.CreateThread(function()
    local checkbox2 = false
    WarMenu.CreateMenu('list', "Animaciones")
    WarMenu.CreateSubMenu('anims', 'list', 'Animaciones')
    WarMenu.CreateSubMenu('walkanims', 'list', 'Animaciones de pie')
    WarMenu.CreateSubMenu('gesture', 'anims', 'Gestos')
    WarMenu.CreateSubMenu('misc2', 'anims', 'Misc')
    WarMenu.CreateSubMenu('scens', 'list', 'Escenarios')
    WarMenu.CreateSubMenu('job', 'scens', 'Trabajos')
    WarMenu.CreateSubMenu('hobby', 'scens', 'Hobbies')
    WarMenu.CreateSubMenu('drink', 'scens', 'Bebidas & Drogas')
    WarMenu.CreateSubMenu('ems', 'scens', 'EMS Escenarios')
    WarMenu.CreateSubMenu('sat', 'scens', 'Escenarios sentarse')
    WarMenu.CreateSubMenu('misc', 'scens', 'Misc')
	WarMenu.CreateSubMenu('walk', 'list', 'Estilos de caminar')
	WarMenu.CreateSubMenu('new2', 'anims', 'Nuevo')
	WarMenu.CreateSubMenu('new', 'scens', 'Nuevo')

    for theId,theItems in pairs(anims) do
        RequestAnimDict(theItems.dic)
    end

    while true do
        local ped = PlayerPedId()
        if checkbox then
            looped = 1
        else
            looped = 32
        end

        if checkbox2 then
            looped2 = 1
        else
            looped2 = 0
        end
        if WarMenu.IsMenuOpened('list') then
            if WarMenu.MenuButton('Animaciones', 'anims') then
            elseif WarMenu.MenuButton('Escenarios', 'scens') then
            elseif WarMenu.MenuButton('Animaciones mientras caminas', 'walkanims') then
            elseif WarMenu.MenuButton('Estilos al andar', 'walk') then
            elseif WarMenu.MenuButton('Acciones personales', 'actions') then
            elseif WarMenu.MenuButton('Expresiones faciales', 'expressions') then
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('walkanims') then
            if WarMenu.Button('~r~~h~Parar Animacion') then
                ClearPedTasks(ped)
			end

            for theId,theItems in pairs(walkanims) do
				if WarMenu.Button(theItems.label) then
					RequestAnimDict(theItems.dic)
			  
					while not HasAnimDictLoaded(theItems.dic) do
						Citizen.Wait(0)
					end

					TaskPlayAnim(ped, theItems.dic, theItems.anim, 8.0, -1, -1, 49, 1, 0, 0, 0)
				end
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('anims') then
            if WarMenu.CheckBox('Mantener en bucle', checkbox, function(checked)
                    checkbox = checked
                end) then
            elseif WarMenu.Button('~r~~h~Parar Animacion') then
                ClearPedTasksImmediately(ped)
            elseif WarMenu.MenuButton('Gestos', 'gesture') then
            elseif WarMenu.MenuButton('Misc', 'misc2') then
			elseif WarMenu.MenuButton('Nuevo', 'new2') then
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('gesture') then
            if WarMenu.CheckBox('Mantener en bucle', checkbox, function(checked)
                    checkbox = checked
                end) then
            elseif WarMenu.Button('~r~~h~Parar Animacion') then
                ClearPedTasksImmediately(ped)
            end
            for theId,theItems in pairs(anims) do
                if theItems.category == "Gesture" then
                    if WarMenu.Button(theItems.label) then
                        TaskPlayAnim(ped, theItems.dic, theItems.anim, 8.0, -1, -1, (looped + theItems.loop), 1, 0, 0, 0)
                    end
                end
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('misc2') then
            if WarMenu.CheckBox('Mantener en bucle', checkbox, function(checked)
                    checkbox = checked
                end) then
            elseif WarMenu.Button('~r~~h~Parar Animacion') then
                ClearPedTasksImmediately(ped)
            end
            for theId,theItems in pairs(anims) do
                if theItems.category == "Misc" then
                    if WarMenu.Button(theItems.label) then
                        TaskPlayAnim(ped, theItems.dic, theItems.anim, 8.0, -1, -1, (looped + theItems.loop), 1, 0, 0, 0)
                    end
                end
            end
			
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('new2') then
            if WarMenu.CheckBox('Mantener en bucle', checkbox, function(checked)
                    checkbox = checked
                end) then
            elseif WarMenu.Button('~r~~h~Parar Animacion') then
                ClearPedTasksImmediately(ped)
            end
            for theId,theItems in pairs(anims) do
                if theItems.category == "New" then
                    if WarMenu.Button(theItems.label) then
                        TaskPlayAnim(ped, theItems.dic, theItems.anim, 8.0, -1, -1, (looped + theItems.loop), 1, 0, 0, 0)
                    end
                end
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('scens') then
            if WarMenu.CheckBox2('Mantener en bucle', checkbox2, function(checked2)
                    checkbox2 = checked2
                end) then
            elseif WarMenu.Button('~r~~h~Parar Escenario') then
                ClearPedTasksImmediately(ped)
            elseif WarMenu.MenuButton('Trabajos', 'job') then
            elseif WarMenu.MenuButton('Hobbies', 'hobby') then
            elseif WarMenu.MenuButton('Bebidas + Drogas', 'drink') then
            elseif WarMenu.MenuButton('EMS Animaciones', 'ems') then
            elseif WarMenu.MenuButton('Animaciones de sentarse', 'sat') then
            elseif WarMenu.MenuButton('Misc', 'misc') then
			elseif WarMenu.MenuButton('Nuevo', 'new') then
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('job') then
            if WarMenu.CheckBox2('Mantener en bucle', checkbox2, function(checked2)
                    checkbox2 = checked2
                end) then
            elseif WarMenu.Button('~r~~h~Parar Escenario') then
                ClearPedTasksImmediately(ped)
            end
            for theId,theItems in pairs(scens) do
                if theItems.category == "Jobs" then
                    if WarMenu.Button(theItems.label) then
                    TaskStartScenarioInPlace(ped, theItems.scen, looped2, true)
                    end
                end
            end

        WarMenu.Display()
        elseif WarMenu.IsMenuOpened('hobby') then
            if WarMenu.CheckBox2('Mantener en bucle', checkbox2, function(checked2)
                    checkbox2 = checked2
                end) then
            elseif WarMenu.Button('~r~~h~Parar Escenario') then
                ClearPedTasksImmediately(ped)
            end
            for theId,theItems in pairs(scens) do
                if theItems.category == "Hobby" then
                    if WarMenu.Button(theItems.label) then
                    TaskStartScenarioInPlace(ped, theItems.scen, looped2, true)
                    end
                end
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('drink') then
            if WarMenu.CheckBox2('Mantener en bucle', checkbox2, function(checked2)
                    checkbox2 = checked2
                end) then
            elseif WarMenu.Button('~r~~h~Parar Escenario') then
                ClearPedTasksImmediately(ped)
            end
            for theId,theItems in pairs(scens) do
                if theItems.category == "Drink" then
                    if WarMenu.Button(theItems.label) then
                    TaskStartScenarioInPlace(ped, theItems.scen, looped2, true)
                    end
                end
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('ems') then
            if WarMenu.CheckBox2('Mantener en bucle', checkbox2, function(checked2)
                    checkbox2 = checked2
                end) then
            elseif WarMenu.Button('~r~~h~Parar Escenario') then
                ClearPedTasksImmediately(ped)
            end
            for theId,theItems in pairs(scens) do
                if theItems.category == "EMS" then
                    if WarMenu.Button(theItems.label) then
                    TaskStartScenarioInPlace(ped, theItems.scen, looped2, true)
                    end
                end
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('sat') then
            if WarMenu.CheckBox2('Mantener en bucle', checkbox2, function(checked2)
                    checkbox2 = checked2
                end) then
            elseif WarMenu.Button('~r~~h~Parar Escenario') then
                ClearPedTasksImmediately(ped)
            end
            for theId,theItems in pairs(scens) do
                if theItems.category == "Sat" then
                    if WarMenu.Button(theItems.label) then
						local ped = GetPlayerPed(-1)
						local pos = GetOffsetFromEntityInWorldCoords(ped, theItems.pos["mp_m_freemode_01"][1], theItems.pos["mp_m_freemode_01"][2], theItems.pos["mp_m_freemode_01"][3])
						local head = GetEntityHeading(ped)-theItems.pos["mp_m_freemode_01"][4]
						local femaleHash = GetHashKey("mp_f_freemode_01")
						if GetEntityModel(ped) == femaleHash then
							pos = GetOffsetFromEntityInWorldCoords(ped, theItems.pos["mp_f_freemode_01"][1], theItems.pos["mp_f_freemode_01"][2], theItems.pos["mp_f_freemode_01"][3])
							head = GetEntityHeading(ped)-theItems.pos["mp_f_freemode_01"][4]
						end
						TaskStartScenarioAtPosition(ped, theItems.scen, pos['x'], pos['y'], pos['z'], head, looped2, 0, false)
                    end
                end
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('misc') then
            if WarMenu.CheckBox2('Mantener en bucle', checkbox2, function(checked2)
                    checkbox2 = checked2
                end) then
            elseif WarMenu.Button('~r~~h~Parar Escenario') then
                ClearPedTasksImmediately(ped)
            end
            for theId,theItems in pairs(scens) do
                if theItems.category == "Misc" then
                    if WarMenu.Button(theItems.label) then
                    TaskStartScenarioInPlace(ped, theItems.scen, looped2, true)
                    end
                end
            end
			
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('new') then
            if WarMenu.CheckBox2('Mantener en bucle', checkbox2, function(checked2)
                    checkbox2 = checked2
                end) then
            elseif WarMenu.Button('~r~~h~Parar Escenario') then
                ClearPedTasksImmediately(ped)
            end
            for theId,theItems in pairs(scens) do
                if theItems.category == "New" then
                    if WarMenu.Button(theItems.label) then
                    TaskStartScenarioInPlace(ped, theItems.scen, looped2, true)
                    end
                end
            end
	
           WarMenu.Display()
        elseif WarMenu.IsMenuOpened('walk') then
			if WarMenu.Button('~r~Restablecer el estilo de caminar') then
                ResetPedMovementClipset(GetPlayerPed(-1), 0)
            end
            for theId,theItems in pairs(walks) do
                if theItems.category == "Walking" then
                    if WarMenu.Button(theItems.label) then
					local anim = theItems.Walk
                    startAttitude(anim)
                    end
                end
            end


            WarMenu.Display()
        elseif IsControlJustPressed(0, 168) then --f6
            --WarMenu.OpenMenu('list')
        end

       	if IsControlJustPressed(0, 178) and not IsPedInAnyVehicle(GetPlayerPed(-1)) then 
          ClearPedTasks(GetPlayerPed(-1))
        end

        Citizen.Wait(0)
    end
end)

function startAttitude(anim)
 	Citizen.CreateThread(function()
	 
	    local playerPed = GetPlayerPed(-1)
	
	    RequestAnimSet(anim)
	      
	    while not HasAnimSetLoaded(anim) do
	        Citizen.Wait(0)
	    end
	    SetPedMovementClipset(playerPed, anim, true)
	end)

end

function Drunk(anim)
 	Citizen.CreateThread(function()
	 
	    local playerPed = GetPlayerPed(-1)
	
	    RequestAnimSet(anim)
	      
	    while not HasAnimSetLoaded(anim) do
	        Citizen.Wait(0)
	    end
	    SetPedMovementClipset(playerPed, anim, true)
	end)

end

RegisterNetEvent('animations:open')
AddEventHandler('animations:open', function()
 WarMenu.OpenMenu('list')
end)


-- New Emote Commands
local emotes = {
 ["cheer"] = "WORLD_HUMAN_CHEERING",
 ["sit"] = "WORLD_HUMAN_PICNIC",
 ["sitchair"] = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER",
 ["lean"] = "WORLD_HUMAN_LEANING",
 ["hangout"] = "WORLD_HUMAN_HANG_OUT_STREET",
 ["cop"] = "WORLD_HUMAN_COP_IDLES",
 ["bum"] = "WORLD_HUMAN_BUM_STANDING",
 ["kneel"] = "CODE_HUMAN_MEDIC_KNEEL",
 ["medic"] = "CODE_HUMAN_MEDIC_TEND_TO_DEAD",
 ["musician"] = "WORLD_HUMAN_MUSICIAN",
 ["film"] = "WORLD_HUMAN_MOBILE_FILM_SHOCKING",
 ["guard"] = "WORLD_HUMAN_GUARD_STAND",
 ["phone"] = "WORLD_HUMAN_STAND_MOBILE",
 ["traffic"] = "WORLD_HUMAN_CAR_PARK_ATTENDANT",
 ["bumsleep"] = "WORLD_HUMAN_BUM_SLUMPED",
 ["drink"] = "WORLD_HUMAN_DRINKING",
 ["dealer"] = "WORLD_HUMAN_DRUG_DEALER",
 ["dealerhard"] = "WORLD_HUMAN_DRUG_DEALER_HARD",
 ["patrol"] = "WORLD_HUMAN_GUARD_PATROL",
 ["hangout"] = "WORLD_HUMAN_HANG_OUT_STREET",
 ["hikingstand"] = "WORLD_HUMAN_HIKER_STANDING",
 ["statue"] = "WORLD_HUMAN_HUMAN_STATUE",
 ["jog"] = "WORLD_HUMAN_JOG_STANDING",
 ["maid"] = "WORLD_HUMAN_MAID_CLEAN",
 ["flex"] = "WORLD_HUMAN_MUSCLE_FLEX",
 ["weights"] = "WORLD_HUMAN_MUSCLE_FLEX",
 ["party"] = "WORLD_HUMAN_PARTYING",
 ["prosthigh"] = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS",
 ["prostlow"] = "WORLD_HUMAN_PROSTITUTE_LOW_CLASS",
 ["pushup"] = "WORLD_HUMAN_PUSH_UPS",
 ["sitsteps"] = "WORLD_HUMAN_SEAT_STEPS",
 ["sitwall"] = "WORLD_HUMAN_SEAT_WALL",
 ["situp"] = "WORLD_HUMAN_SIT_UPS",
 ["fire"] = "WORLD_HUMAN_STAND_FIRE",
 ["impatient"] = "WORLD_HUMAN_STAND_IMPATIENT",
 ["impatientup"] = "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT",
 ["mobileup"] = "WORLD_HUMAN_STAND_MOBILE_UPRIGHT",
 ["stripwatch"] = "WORLD_HUMAN_STRIP_WATCH_STAND",
 ["stupor"] = "WORLD_HUMAN_STUPOR",
 ["sunbathe"] = "WORLD_HUMAN_SUNBATHE",
 ["sunbatheback"] = "WORLD_HUMAN_SUNBATHE_BACK",
 ["map"] = "WORLD_HUMAN_TOURIST_MAP",
 ["tourist"] = "WORLD_HUMAN_TOURIST_MOBILE",
 ["mechanic"] = "WORLD_HUMAN_VEHICLE_MECHANIC",
 ["windowshop"] = "WORLD_HUMAN_WINDOW_SHOP_BROWSE",
 ["yoga"] = "WORLD_HUMAN_YOGA",
 ["atm"] = "PROP_HUMAN_ATM",
 ["bumbin"] = "PROP_HUMAN_BUM_BIN",
 ["cart"] = "PROP_HUMAN_BUM_SHOPPING_CART",
 ["chinup"] = "PROP_HUMAN_MUSCLE_CHIN_UPS",
 ["chinuparmy"] = "PROP_HUMAN_MUSCLE_CHIN_UPS_ARMY",
 ["chinupprison"] = "PROP_HUMAN_MUSCLE_CHIN_UPS_PRISON",
 ["parkingmeter"] = "PROP_HUMAN_PARKING_METER",
 ["armchair"] = "PROP_HUMAN_SEAT_ARMCHAIR",
 ["crossroad"] = "CODE_HUMAN_CROSS_ROAD_WAIT",
 ["crowdcontrol"] = "CODE_HUMAN_POLICE_CROWD_CONTROL",
 ["investigate"] = "CODE_HUMAN_POLICE_INVESTIGATE"

}

RegisterCommand("ee", function(source, args, rawCommand)
	TaskStartScenarioInPlace(GetPlayerPed(-1), emotes[string.sub(rawCommand, 3)], 0, true)
end)

local dances = {
	[1] = {["dict"] = "misschinese2_crystalmazemcs1_cs", ["anim"] = "dance_loop_tao"},
	[2] = {["dict"] = "rcmnigel1bnmt_1b", ["anim"] = "dance_loop_tyler"},
	[3] = {["dict"] = "missfbi3_sniping", ["anim"] = "dance_m_default"},
	[4] = {["dict"] = "anim@amb@nightclub@djs@black_madonna@", ["anim"] = "dance_a_loop_blamadon"},
	[5] = {["dict"] = "anim@amb@nightclub@lazlow@hi_dancefloor@", ["anim"] = "crowddance_hi_06_base_v2_laz"},
	[6] = {["dict"] = "anim@amb@nightclub@lazlow@hi_dancefloor@", ["anim"] = "dancecrowd_hi_05_dlg_highaf_laz"},
	[7] = {["dict"] = "anim@amb@nightclub@lazlow@hi_podium@", ["anim"] = "danceidle_hi_11_buttwiggle_b_laz"},
	[8] = {["dict"] = "anim@amb@nightclub@lazlow@hi_podium@", ["anim"] = "danceidle_hi_11_turnaround_laz"},
	[9] = {["dict"] = "anim@amb@nightclub@lazlow@hi_podium@", ["anim"] = "danceidle_hi_13_flyingv_laz"},
	[10] = {["dict"] = "anim@amb@nightclub@lazlow@hi_podium@", ["anim"] = "danceidle_hi_17_smackthat_laz"},
	[11] = {["dict"] = "anim@amb@nightclub@lazlow@hi_podium@", ["anim"] = "danceidle_li_13_hipswivel_laz"},
	[12] = {["dict"] = "anim@amb@nightclub@lazlow@hi_podium@", ["anim"] = "danceidle_li_15_sexygrind_laz"},
	[13] = {["dict"] = "anim@amb@nightclub@lazlow@hi_podium@", ["anim"] = "danceidle_mi_09_pointdj_l_laz"},
	[14] = {["dict"] = "anim@amb@nightclub@lazlow@hi_podium@", ["anim"] = "danceidle_trans_07_mi_to_li_laz"},
	[15] = {["dict"] = "anim@mp_player_intupperuncle_disco", ["anim"] = "idle_a"},
    [16] = {["dict"] = "anim@mp_player_intuppersalsa_roll", ["anim"] = "idle_a"},
    [17] = {["dict"] = "anim@mp_player_intcelebrationmale@salsa_roll", ["anim"] = "salsa_roll"},
    [18] = {["dict"] = "anim@mp_player_intcelebrationmale@uncle_disco", ["anim"] = "uncle_disco"},
    [19] = {["dict"] = "anim@mp_player_intcelebrationmale@heart_pumping", ["anim"] = "heart_pumping"},
    [20] = {["dict"] = "anim@mp_player_intupperfind_the_fish", ["anim"] = "idle_a"},
    [21] = {["dict"] = "anim@mp_player_intuppercats_cradle", ["anim"] = "idle_a"},
    [22] = {["dict"] = "anim@mp_player_intupperbanging_tunes", ["anim"] = "idle_a"},
    [23] = {["dict"] = "anim@mp_player_intcelebrationmale@oh_snap", ["anim"] = "oh_snap"},
    [24] = {["dict"] = "anim@mp_player_intcelebrationmale@raise_the_roof", ["anim"] = "raise_the_roof"},
    [25] = {["dict"] = "anim@mp_player_intcelebrationmale@banging_tunes_rightt", ["anim"] = "banging_tunest"},
    [26] = {["dict"] = "anim@mp_player_intcelebrationmale@banging_tunest", ["anim"] = "banging_tunest"},
    [27] = {["dict"] = "anim@mp_player_intcelebrationmale@cats_cradlet", ["anim"] = "cats_cradlet"},
    [38] = {["dict"] = "anim@mp_player_intcelebrationmale@find_the_fish", ["anim"] = "find_the_fish"},
}

RegisterCommand("dance", function(source, args, rawCommand)
	if args[1] ~= nil and type(tonumber(args[1])) == "number" then
		if dances[tonumber(args[1])] ~= nil then
			local ped = GetPlayerPed(-1)

			RequestAnimDict(dances[tonumber(args[1])]["dict"])
			  
			while not HasAnimDictLoaded(dances[tonumber(args[1])]["dict"]) do
				Citizen.Wait(0)
			end

			TaskPlayAnim(ped, dances[tonumber(args[1])]["dict"], dances[tonumber(args[1])]["anim"], -1, -1, -1, 47, 1, 0, 0, 0)
		end
	end
end)


RegisterCommand("ep", function(source, args, rawCommand)
	local ped = GetPlayerPed(-1)
	local pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, -0.6, -0.5)
	local head = GetEntityHeading(ped)
	TaskStartScenarioAtPosition(ped, emotes[string.sub(rawCommand, 4)], pos['x'], pos['y'], pos['z'], head, 0, 0, false)
end)

RegisterCommand("emote", function(source, args, rawCommand)
	TaskStartScenarioInPlace(GetPlayerPed(-1), emotes[string.sub(rawCommand, 7)], 0, true)
end)

RegisterCommand("emotes", function(source, args, rawCommand)
 local strResult = 'Emote List: <div>'
 for ind, v in pairs(emotes) do
  strResult = strResult..ind.."<div>"
 end
 TriggerEvent("pNotify:SendNotification", {text = strResult, timeout= 25000})
end)

RegisterCommand("ce", function(source, args, rawCommand)
 ClearPedTasks(GetPlayerPed(-1))
end)
 
RegisterCommand("cancel", function(source, args, rawCommand)
 ClearPedTasksImmediately(GetPlayerPed(-1))
end)

-- Personal Actions!!!
local personalaction = {name = 'None', dic = 'None', anim = 'None'}

Citizen.CreateThread(function()
 WarMenu.CreateMenu('actions', 'Acciones')
 while true do
  Citizen.Wait(1)
  if WarMenu.IsMenuOpened('actions') then
   if WarMenu.Button('Current Action: '..personalaction.name) then
   elseif WarMenu.Button('The Bird') then
    personalaction = {name = 'The Bird', dic = 'mp_player_int_upperfinger', anim = 'mp_player_int_finger_02'}
   elseif WarMenu.Button('Jerk Off') then
    personalaction = {name = 'Jerk Off', dic = 'mp_player_int_upperwank', anim = 'mp_player_int_wank_01'}
   elseif WarMenu.Button('Salute') then
    personalaction = {name = 'Salute', dic = 'mp_player_int_uppersalute', anim = 'mp_player_int_salute'}
   elseif WarMenu.Button('Blow Kiss') then
    personalaction = {name = 'Blow Kiss', dic = 'anim@mp_player_intupperblow_kiss', anim = 'idle_a'}
   elseif WarMenu.Button('Air Thrusting') then
    personalaction = {name = 'Air Thrusting', dic = 'anim@mp_player_intcelebrationfemale@air_shagging', anim = 'air_shagging'}
   elseif WarMenu.Button('Knuckle Crunch') then
    personalaction = {name = 'Knuckle Crunch', dic = 'anim@mp_player_intupperknuckle_crunch', anim = 'idle_a'}
   elseif WarMenu.Button('Slow Clap') then
    personalaction = {name = 'Slow Clap', dic = 'anim@mp_player_intupperslow_clap', anim = 'idle_a'}
   elseif WarMenu.Button('Thumbs Up') then
    personalaction = {name = 'Thumbs Up', dic = 'anim@mp_player_intupperthumbs_up', anim = 'idle_a'}
   elseif WarMenu.Button('Jazz Hands') then
    personalaction = {name = 'Jazz Hands', dic = 'anim@mp_player_intupperjazz_hands', anim = 'idle_a'}
   elseif WarMenu.Button('Nose Pick') then
    personalaction = {name = 'Nose Pick', dic = 'anim@mp_player_intuppernose_pick', anim = 'idle_a'}
   elseif WarMenu.Button('Air Guitar') then
    personalaction = {name = 'Air Guitar', dic = 'anim@mp_player_intupperair_guitar', anim = 'idle_a'}
   elseif WarMenu.Button('Wave') then
    personalaction = {name = 'Wave', dic = 'anim@mp_player_intupperwave', anim = 'idle_a'}
   elseif WarMenu.Button('Peace') then
    personalaction = {name = 'Peace', dic = 'anim@mp_player_intupperpeace', anim = 'idle_a'}
   elseif WarMenu.Button('Freakout') then
    personalaction = {name = 'Freakout', dic = 'anim@mp_player_intupperfreakout', anim = 'idle_a'}
   elseif WarMenu.Button('Chin Brush') then
    personalaction = {name = 'Chin Brush', dic = 'anim@mp_player_intupperchin_brush', anim = 'idle_a'}
   elseif WarMenu.Button('Chicken Taunt') then
    personalaction = {name = 'Chicken Taunt', dic = 'anim@mp_player_intupperchicken_taunt', anim = 'idle_a'}
   elseif WarMenu.Button('No Way') then
    personalaction = {name = 'No Way', dic = 'anim@mp_player_intupperno_way', anim = 'idle_a'}
   elseif WarMenu.Button('Air Synth') then
    personalaction = {name = 'Air Synth', dic = 'anim@mp_player_intupperair_synth', anim = 'idle_a'}
   elseif WarMenu.Button('DJ') then
    personalaction = {name = 'DJ', dic = 'anim@mp_player_intupperdj', anim = 'idle_a'}
   elseif WarMenu.Button('Shush') then
    personalaction = {name = 'Shush', dic = 'anim@mp_player_intuppershush', anim = 'idle_a'}
   end
   WarMenu.Display()
  end 
  if IsControlJustPressed(0, 171) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) and not IsPedCuffed(GetPlayerPed(-1)) and personalaction.dic ~= 'None' then
   if IsEntityPlayingAnim(GetPlayerPed(-1), personalaction.dic, personalaction.anim, 3) then
    ClearPedTasks(GetPlayerPed(-1))
   else
    RequestAnimDict(personalaction.dic) 
    while not HasAnimDictLoaded(personalaction.dic) do 
        Citizen.Wait(1) 
    end
    TaskPlayAnim(GetPlayerPed(-1), personalaction.dic, personalaction.anim, 3.0, -1, -1, 63, 1, false, false, false)
   end
  end
 end
end)

local expressions = {
    {name = 'Normal', mood = 'mood_normal_1'},
    {name = 'Puntería', mood = 'mood_aiming_1'},
    {name = 'Hambriento', mood = 'mood_angry_1'},
    {name = 'Borracho', mood = 'mood_drunk_1'},
    {name = 'Feliz', mood = 'mood_happy_1'},
    {name = 'Lesionado', mood = 'mood_injured_1'},
    {name = 'Estresado', mood = 'mood_stressed_1'},
    {name = 'Quejarse', mood = 'mood_sulk_1'},
    {name = 'Dormido', mood = 'mood_sleeping_1'},
}

Citizen.CreateThread(function()
 WarMenu.CreateMenu('expressions', 'Expresiones')
 while true do
  Citizen.Wait(1)
  if WarMenu.IsMenuOpened('expressions') then
   for _,v in pairs(expressions) do
    if WarMenu.Button(v.name) then
     SetFacialIdleAnimOverride(GetPlayerPed(-1), v.mood)
    end
   end
   WarMenu.Display()
  end 
 end
end)
