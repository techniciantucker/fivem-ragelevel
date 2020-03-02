description 'PixelWorld GTA5 Vehicles'
name 'PixelWorld gtav'
author 'PixelWorldRP [Psycholiquid71] - https://pixelworldrp.com'

files {
	'vehiclelayouts.meta',
	'vehiclelayouts_rrocket.meta',
	'vehiclelayouts_s80.meta',
	'handling.meta',
	'vehicles.meta',
	'carcols.meta',
	'carvariations.meta',
	'vehicleweapons_paragon2.meta',
	'clip_sets.xml'
}

data_file 'VEHICLE_LAYOUTS_FILE' 'vehiclelayouts.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'vehiclelayouts_rrocket.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'vehiclelayouts_s80.meta'
data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'
data_file 'WEAPONINFO_FILE' 'vehicleweapons_paragon2.meta'
data_file 'CLIP_SETS_FILE' 'clip_sets.xml'

client_script 'vehicle_names.lua'

fx_version 'adamant'
games {'gta5'}