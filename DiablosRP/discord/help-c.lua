--[[ help script made at JEVA by Zua (https://github.com/thatziv) ]]


-- This function is used to register a command for the chat. 
--When this is exectuted, it will execute a function, doing the msg function to the client
RegisterCommand('discord', function()
    msg("Discord: https://discord.gg/dcHrMkd")
    msg("CONECTATE PARA VER LAS NORMAS DEL SERVER Y UNIRTE A NUESTRA COMUNIDAD")
end, false)

-- We declare this 'msg' function on the bottom due to better practices.
function msg(text)
    -- TriggerEvent will send a chat message to the client in the prefix as red
    TriggerEvent("chatMessage",  "[SERVER]", {255,0,0}, text)
end
