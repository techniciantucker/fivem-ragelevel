--client_script "@np-errorlog/client/cl_errorlog.lua"
--server_script "@mysql-async/lib/MySQL.lua"
ui_page 'index.html'

files {
  "index.html",
  "scripts.js",
  "css/style.css"
}
client_script {
  "client.lua",
}

export "taskBar"