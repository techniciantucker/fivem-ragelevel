name 'Mythic Framework Progress Bar'
author 'Alzar - https://github.com/Alzar'
version 'v1.0.1'

ui_page('html/index.html') 

client_scripts {
    'client/functions.lua',
    'client/events.lua',
}

files {
    'html/index.html',
    'html/css/style.css',
    'html/js/script.js',

    'html/css/bootstrap.min.css',
    'html/js/jquery.min.js',
}

exports {
    'Progress',
    'ProgressWithStartEvent',
    'ProgressWithTickEvent',
    'ProgressWithStartAndTick'
}

fx_version 'adamant'
games { 'gta5' }