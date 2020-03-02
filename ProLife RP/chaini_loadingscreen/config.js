/*
    This script was developed by Piter Van Rujpen/TheGamerRespow for Vulkanoa (https://discord.gg/bzMnYPS).
    Do not re-upload this script without my authorization. (I only give authorization by PM on FiveM.net (https://forum.fivem.net/u/TheGamerRespow))
*/

var VK = new Object(); // DO NOT CHANGE
VK.server = new Object(); // DO NOT CHANGE

VK.backgrounds = new Object(); // DO NOT CHANGE
VK.backgrounds.actual = 0; // DO NOT CHANGE
VK.backgrounds.way = true; // DO NOT CHANGE
VK.config = new Object(); // DO NOT CHANGE
VK.tips = new Object(); // DO NOT CHANGE
VK.music = new Object(); // DO NOT CHANGE
VK.info = new Object(); // DO NOT CHANGE
VK.social = new Object(); // DO NOT CHANGE
VK.players = new Object(); // DO NOT CHANGE 

//////////////////////////////// CONFIG

VK.config.loadingSessionText = "Cargando la sesión..."; // Loading session text
VK.config.firstColor = [255, 151, 0]; // First color in rgb : [r, g, b]
VK.config.secondColor = [255, 255, 255]; // Second color in rgb : [r, g, b]
VK.config.thirdColor = [255, 151, 0]; // Third color in rgb : [r, g, b]

VK.backgrounds.list = [ // Backgrounds list, can be on local or distant(http://....)
    "img/a.jpg",
    "img/b.jpg",
    "img/c.jpg",
    "img/d.jpg",
    "img/e.jpg",
    "img/f.jpg",
    "img/g.jpg",
    "img/i.jpg",
    "img/j.jpg",
    "img/k.jpg",
    "img/l.jpg",
    "img/m.jpg",
    "img/n.jpg",
    "img/o.jpg",
    "img/p.jpg",
];
VK.backgrounds.duration = 3000; // Background duration (in ms) before transition (the transition lasts 1/3 of this time)

VK.tips.enable = true; //Enable tips (true : enable, false : prevent)
VK.tips.list = [ // Tips list
    "Para abrir tu telefono utiliza la tecla F1, asi pordrás usar los servicios", // If you use double-quotes, make sure to put a \ before each double quotes
    "Para enviar un mensaje de texto utiliza la tecla T",
    "Para levantar las manos utiliza la tecla B",
    "¡Recuerda comer y beber!",
    "Para ver la lista de animaciones usa la tecla F3",
    "Utiliza /report para reportar un problema o a un jugador",
    "Utiliza /mp para enviar un mensaje privado a un administrador",
    "Recuerda revisar el foro y las normas",
];
VK.info.enable = true; //Enable tips (true : enable, false : prevent)
VK.info.list = [ // Tips list
    "Antoine - Programación, Diseño y Fundador",
	"HacksMil - Director de staff",
	"LuKa - Restart Console.",
];
VK.music.url = "https://www.youtube.com/watch?v=ne87isa9ocQ"; // Music url, can be on local or distant(http://....) ("NONE" to desactive music)
VK.music.volume = 0.05; // Music volume (0-1)
VK.music.title = "PGS Radio"; // Music title ("NONE" to desactive)
VK.music.submitedBy = "NONE"; // Music submited by... ("NONE" to desactive)

VK.info.logo = "icon/vulkanoa.png"; // Logo, can be on local or distant(http://....) ("NONE" to desactive)
VK.info.text = "Antoine - Fundador"; // Bottom right corner text ("NONE" to desactive) 
VK.info.website = "proliferp.com"; // Website url ("NONE" to desactive) 
VK.info.ip = "164.132.202.25:30120"; // Your server ip and port ("ip:port")

VK.social.discord = "NONE"; // Discord url ("NONE" to desactive)
VK.social.twitter = "‎@ProLifeRP"; // Twitter url ("NONE" to desactive)
VK.social.facebook = "/ProLifeRP"; // Facebook url ("NONE" to desactive)
VK.social.youtube = "/ProLifeRP"; // Youtube url ("NONE" to desactive)
VK.social.twitch = "ProLife"; // Twitch url ("NONE" to desactive)

VK.players.enable = false; // Enable the players count of the server (true : enable, false : prevent)
VK.players.multiplePlayersOnline = "@players Jugadores en línea"; // @players equals the players count
VK.players.onePlayerOnline = "1 Jugador en línea"; // Text when only one player is on the server
VK.players.noPlayerOnline = "Ningún Jugador en línea"; // Text when the server is empty

////////////////////////////////
