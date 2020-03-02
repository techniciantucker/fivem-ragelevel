--========================================================================================--
--====================================== Banking =========================================--
--========================================================================================--
-- Resource Manifest
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

-- Dependency
dependency 'GHMattiMySQL'

-- Client Script
client_script 'client.lua'

-- Server Script
server_script 'server.lua'

-- Files
ui_page 'html/UI.html'

files {
    'html/UI.html',
    'html/style.css',
    'html/media/font/Bariol_Regular.otf',
    'html/media/font/Vision-Black.otf',
    'html/media/font/Vision-Bold.otf',
    'html/media/font/Vision-Heavy.otf',
    'html/media/img/bg.png',
    'html/media/img/circle.png',
    'html/media/img/curve.png',
    'html/media/img/fingerprint.png',
    'html/media/img/fingerprint.jpg',
    'html/media/img/graph.png',
    'html/media/img/logo-big.png',
    'html/media/img/logo-top.png'
}