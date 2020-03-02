resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

dependency 'GHMattiMySQL'


ui_page('ui/index.html')

files({
	
    'ui/index.html',
    'ui/libraries/vue.min.js',
    'ui/libraries/axios.min.js',
    'ui/libraries/material.css',
    'ui/libraries/vue-snotify.min.js',
    'ui/script.js'	
})





-- notifications
client_script 'notifications/notifications.lua'