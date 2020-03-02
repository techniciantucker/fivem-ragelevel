print("hola")

RegisterCommand("twitter", function()
   TriggerEvent("ChatMessage", "[Twitter]", {255,255,255}, "^1Nuestro Twitter: ^3https://twitter.com/ProLifeRP")
end)

RegisterCommand("web", function()
    TriggerEvent("ChatMessage", "[Web]", {255,255,255}, "^1Nuestra web: ^3https://proliferp.com")
 end)

 RegisterCommand("discord", function()
    TriggerEvent("ChatMessage", "[Discord]", {255,255,255}, "^1Nuestro Discord: ^3https://discord.gg/f2ax7xp")
 end)

 RegisterCommand("ts3", function()
    TriggerEvent("ChatMessage", "[TS3]", {255,255,255}, "^1Nuestro TS3: ^3ts3.proliferp.com")
 end)