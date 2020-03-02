Config = {}

Config.Animations = {
	
	{
		name  = 'festivas',
		label = 'Festivas',
		items = {
	    {label = "Tocar música", type = "scenario", data = {anim = "WORLD_HUMAN_MUSICIAN"}},
	    {label = "Dj", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@dj", anim = "dj"}},
	    {label = "Beber un café", type = "scenario", data = {anim = "WORLD_HUMAN_DRINKING"}},
	    {label = "Tomar una cerveza", type = "scenario", data = {anim = "WORLD_HUMAN_PARTYING"}},
	    {label = "Tocar la guitarra", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@air_guitar", anim = "air_guitar"}},
	    {label = "meterla hasta el fondo", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@air_shagging", anim = "air_shagging"}},
	    {label = "Rock'n'roll", type = "anim", data = {lib = "mp_player_int_upperrock", anim = "mp_player_int_rock"}},
	    -- {label = "Fumar", type = "scenario", data = {anim = "WORLD_HUMAN_SMOKING_POT"}},
	    {label = "Borracho", type = "anim", data = {lib = "amb@world_human_bum_standing@drunk@idle_a", anim = "idle_a"}},
	    {label = "Vomitar en el coche", type = "anim", data = {lib = "oddjobs@taxi@tie", anim = "vomit_outside"}},
		}
	},

	{
		name  = 'greetings',
		label = 'Saludar',
		items = {
	    {label = "Saludar", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_hello"}},
	    {label = "Dar la mano", type = "anim", data = {lib = "mp_common", anim = "givetake1_a"}},
	    {label = "Saludar chocandola", type = "anim", data = {lib = "mp_ped_interaction", anim = "handshake_guy_a"}},
	    {label = "Saludo de banda", type = "anim", data = {lib = "mp_ped_interaction", anim = "hugs_guy_a"}},
	    {label = "Saludo militar", type = "anim", data = {lib = "mp_player_int_uppersalute", anim = "mp_player_int_salute"}},
		}
	},

	{
		name  = 'work',
		label = 'Acciones',
		items = {
	    {label = "civil : Rendirse", type = "anim", data = {lib = "asdasdasd", anim = "idle_c"}},
	    {label = "Pescar", type = "scenario", data = {anim = "world_human_stand_fishing"}},
	    {label = "Policia : investigar", type = "anim", data = {lib = "amb@code_human_police_investigate@idle_b", anim = "idle_f"}},
	    {label = "Policia : hablar por la radio", type = "anim", data = {lib = "random@arrests", anim = "generic_radio_chatter"}},
	    {label = "Policia : circulen", type = "scenario", data = {anim = "WORLD_HUMAN_CAR_PARK_ATTENDANT"}},
	    {label = "Policia : prismáticos", type = "scenario", data = {anim = "WORLD_HUMAN_BINOCULARS"}},
	    {label = "Agricultura : plantar", type = "scenario", data = {anim = "world_human_gardener_plant"}},
	    {label = "vehículo : reparar vehículo", type = "scenario", data = {anim = "world_human_vehicle_mechanic"}},
	    {label = "vehículo : reparar la moto", type = "anim", data = {lib = "mini@repair", anim = "fixing_a_ped"}},
	    {label = "Medicina : observar paciente", type = "scenario", data = {anim = "CODE_HUMAN_MEDIC_KNEEL"}},
	    {label = "Taxi : hablar al cliente", type = "anim", data = {lib = "oddjobs@taxi@driver", anim = "leanover_idle"}},
	    {label = "Taxi : dar la factura", type = "anim", data = {lib = "oddjobs@taxi@cyi", anim = "std_hand_off_ps_passenger"}},
	    {label = "Tendero : colocar caja", type = "anim", data = {lib = "mp_am_hold_up", anim = "purchase_beerbox_shopkeeper"}},
	    {label = "Barman : servir un chupito", type = "anim", data = {lib = "mini@drinking", anim = "shots_barman_b"}},
	    {label = "Periodista : tomar una foto", type = "scenario", data = {anim = "WORLD_HUMAN_PAPARAZZI"}},
	    {label = "artesanía : tomar apuntes", type = "scenario", data = {anim = "WORLD_HUMAN_CLIPBOARD"}},
	    {label = "artesanía : martillazo", type = "scenario", data = {anim = "WORLD_HUMAN_HAMMERING"}},
	    {label = "vagabundo: sacar cartel de vagabundo", type = "scenario", data = {anim = "WORLD_HUMAN_BUM_FREEWAY"}},
	    {label = "vagabundo : Pose de estatua", type = "scenario", data = {anim = "WORLD_HUMAN_HUMAN_STATUE"}},
		}
	},

	{
		name  = 'humors',
		label = 'Humor',
		items = {
	    {label = "aplaudir", type = "scenario", data = {anim = "WORLD_HUMAN_CHEERING"}},
	    {label = "pulgares arriba", type = "anim", data = {lib = "mp_action", anim = "thanks_male_06"}},
	    {label = "Señalar", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_point"}},
	    {label = "Ven", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_come_here_soft"}}, 
	    {label = "¿qué pasa mongolo? ?", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_bring_it_on"}},
	    {label = "Señalarte", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_me"}},
	    {label = "lo sabía, gilipollas", type = "anim", data = {lib = "anim@am_hold_up@male", anim = "shoplift_high"}},
	    {label = "ser esposado", type = "scenario", data = {lib = "amb@world_human_jog_standing@male@idle_b", anim = "idle_d"}},
	    {label = "estoy en la mierda", type = "scenario", data = {lib = "amb@world_human_bum_standing@depressed@idle_a", anim = "idle_a"}},
	    {label = "Facepalm", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@face_palm", anim = "face_palm"}},
	    {label = "calmate", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_easy_now"}},
	    {label = "¿qué ha hecho?", type = "anim", data = {lib = "oddjobs@assassinate@multi@", anim = "react_big_variations_a"}},
	    {label = "tener miedo", type = "anim", data = {lib = "amb@code_human_cower_stand@male@react_cowering", anim = "base_right"}},
	    {label = "calentar para pelear", type = "anim", data = {lib = "anim@deathmatch_intros@unarmed", anim = "intro_male_unarmed_e"}},
	    {label = "ni de coña", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_damn"}},
	    {label = "abrazar", type = "anim", data = {lib = "mp_ped_interaction", anim = "kisses_guy_a"}},
	    {label = "doble peineta", type = "anim", data = {lib = "mp_player_int_upperfinger", anim = "mp_player_int_finger_01_enter"}},
	    {label = "paja", type = "anim", data = {lib = "mp_player_int_upperwank", anim = "mp_player_int_wank_01"}},
	    {label = "volarte la cabeza", type = "anim", data = {lib = "mp_suicide", anim = "pistol"}},
		}
	},

	{
		name  = 'sports',
		label = 'deporte',
		items = {
	    {label = "Mostrar el pechito pollo", type = "anim", data = {lib = "amb@world_human_muscle_flex@arms_at_side@base", anim = "base"}},
	    {label = "levantar pesas", type = "anim", data = {lib = "amb@world_human_muscle_free_weights@male@barbell@base", anim = "base"}},
	    {label = "hacer flexiones", type = "anim", data = {lib = "amb@world_human_push_ups@male@base", anim = "base"}},
	    {label = "hacer abdominales", type = "anim", data = {lib = "amb@world_human_sit_ups@male@base", anim = "base"}},
	    {label = "hacer yoga", type = "anim", data = {lib = "amb@world_human_yoga@male@base", anim = "base_a"}},
		}
	},

	{
		name  = 'misc',
		label = 'diversos',
		items = {
	    {label = "beber un café", type = "anim", data = {lib = "amb@world_human_aa_coffee@idle_a", anim = "idle_a"}},
	    {label = "Sentarse en una silla invisible", type = "anim", data = {lib = "anim@heists@prison_heistunfinished_biztarget_idle", anim = "target_idle"}},
	    {label = "Sentarse en el suelo", type = "scenario", data = {anim = "WORLD_HUMAN_PICNIC"}},
	    {label = "chatear", type = "scenario", data = {anim = "world_human_leaning"}},
	    {label = "tumbarse en el suelo", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE_BACK"}},
	    {label = "tumbarse en el suelo 2", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE"}},
	    {label = "limpiar", type = "scenario", data = {anim = "world_human_maid_clean"}},
	    {label = "cocinar", type = "scenario", data = {anim = "PROP_HUMAN_BBQ"}},
	    {label = "posición de T", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_bj_to_prop_female"}},
	    {label = "sacar morritos para selfie", type = "scenario", data = {anim = "world_human_tourist_mobile"}},
	    {label = "escuchar", type = "anim", data = {lib = "mini@safe_cracking", anim = "idle_base"}}, 
		}
	},

	{
		name  = 'porn',
		label = 'para mayores de 30 años.',
		items = {
	    {label = "paja en el coche", type = "anim", data = {lib = "oddjobs@towing", anim = "m_blow_job_loop"}},
	    {label = "Hacer una mamada", type = "anim", data = {lib = "oddjobs@towing", anim = "f_blow_job_loop"}},
	    {label = "Follar en el coche, hombre", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_player"}},
	    {label = "Follar en el coche, mujer", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_female"}},
	    {label = "tocarse las partes intimas", type = "anim", data = {lib = "mp_player_int_uppergrab_crotch", anim = "mp_player_int_grab_crotch"}},
	    {label = "pose sexy", type = "anim", data = {lib = "mini@strip_club@idles@stripper", anim = "stripper_idle_02"}},
	    {label = "Pose pija", type = "scenario", data = {anim = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS"}},
	    {label = "enseñar las tetas", type = "anim", data = {lib = "mini@strip_club@backroom@", anim = "stripper_b_backroom_idle_b"}},
	    {label = "Strip Tease 1", type = "anim", data = {lib = "mini@strip_club@lap_dance@ld_girl_a_song_a_p1", anim = "ld_girl_a_song_a_p1_f"}},
	    {label = "Strip Tease 2", type = "anim", data = {lib = "mini@strip_club@private_dance@part2", anim = "priv_dance_p2"}},
	    {label = "Stip Tease en el suelo", type = "anim", data = {lib = "mini@strip_club@private_dance@part3", anim = "priv_dance_p3"}},
			}
	},

}