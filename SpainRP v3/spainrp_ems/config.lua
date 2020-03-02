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

Config = {}

Config.Locale = 'es'

Config.OpenMenuSpawn= {x = 266.62, y = -1354.23, z = 24.53}

Config.Hash = {
	{hash = "ambulance", detection = 4.0, depth = -2.5, height = 0.5},
}

Config.Press = {
	open_menu = Keys["E"],
	take_bed = Keys["E"],
	do_action = Keys["E"],
	out_vehicle_bed = Keys["E"],
	release_bed = Keys["E"],
	in_vehicle_bed = Keys["E"],
	go_out_bed = Keys["E"],
}

Config.Language = {
	name_hospital = 'EMS',
	open_menu = 'Pulsa ~b~E',
	do_action = 'Pulsa ~INPUT_CONTEXT~ para realizar una acción',
	take_bed = "Pulsa ~INPUT_CONTEXT~ para coger la camilla",
	release_bed = "Pulsa ~INPUT_CONTEXT~ para dejar la camilla",
	in_vehicle_bed = "Pulsa ~INPUT_CONTEXT~ para meter la camilla",
	out_vehicle_bed = "Pulsa ~INPUT_CONTEXT~ para sacar la camilla",
	go_out_bed = "Salir de la camilla",
	delete_bed = "Eliminar camilla",
	comprobar_cuerpo = "Comprobar cuerpo",
	silladeruedas = 'Silla de ruedas',
	borrarsilladeruedas = 'Borrar silla de ruedas',
	bendas = 'Pack de vendas',
	medikit = 'Pack de Medkit',
	lit_1 = "Camilla normal",
	lit_2 = "Camilla verde",
	lit_3 = "Camilla azul",
	
	anim = {
		spawn_command = "camilla",
		lie_back = "Acostarse boca arriba",
		sit_right = "Sentarse a la derecha de la mesa",
		sit_left = "Sentarse a la izquierda de la mesa",
		convulse = "Convulsionar",
		pls = "Tumbarte de lado",
	}
}

