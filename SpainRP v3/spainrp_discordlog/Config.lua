DiscordWebhookSystemInfos = 'https://discordapp.com/api/webhooks/611157060259938344/5d_aTPbWVosTwsUAt6_ArJFJPkUEUgGeWe32jWp_R0DbMSbCk1rhpBh4C60Cjqhwqcdj'
DiscordWebhookKillinglogs = 'https://discordapp.com/api/webhooks/610178524191523023/xevnPRUxRakwtEYiu-lWVEK21Du25YdiipO8HAxbad290-xXsbMiU3hTZld1BlgAf6sM'
DiscordWebhookChat = 'https://discordapp.com/api/webhooks/610178524191523023/xevnPRUxRakwtEYiu-lWVEK21Du25YdiipO8HAxbad290-xXsbMiU3hTZld1BlgAf6sM'

SystemAvatar = 'https://cdn.discordapp.com/attachments/589198571606245376/589234864658710540/dfggfhgfhgfhhgf.jpg'

UserAvatar = 'https://i.imgur.com/KIcqSYs.png'

SystemName = 'SpainRP LOG'


--[[ Special Commands formatting
		 *YOUR_TEXT*			--> Make Text Italics in Discord
		**YOUR_TEXT**			--> Make Text Bold in Discord
	   ***YOUR_TEXT***			--> Make Text Italics & Bold in Discord
		__YOUR_TEXT__			--> Underline Text in Discord
	   __*YOUR_TEXT*__			--> Underline Text and make it Italics in Discord
	  __**YOUR_TEXT**__			--> Underline Text and make it Bold in Discord
	 __***YOUR_TEXT***__		--> Underline Text and make it Italics & Bold in Discord
		~~YOUR_TEXT~~			--> Strikethrough Text in Discord
]]
-- Use 'USERNAME_NEEDED_HERE' without the quotes if you need a Users Name in a special command
-- Use 'USERID_NEEDED_HERE' without the quotes if you need a Users ID in a special command


-- These special commands will be printed differently in discord, depending on what you set it to
SpecialCommands = {
				   {'/ooc', '**[OOC]:**'},
				   {'/911', '**[911]: (CALLER ID: [ USERNAME_NEEDED_HERE | USERID_NEEDED_HERE ])**'},
				  }

						
-- These blacklisted commands will not be printed in discord
BlacklistedCommands = {
					   '/AnyCommand',
					   '/AnyCommand2',
					  }

-- These Commands will use their own webhook
OwnWebhookCommands = {
					  {'/anon', 'https://discordapp.com/api/webhooks/536192923247837224/EUspb-JxrK-ph2yznqE5LUO2vg_emkGoqQQJGS_xQ0CyZW5wV11q3CGXHBOVv4Vuwsyvp'},
					  {'/AnotherCommand2', 'WEBHOOK_LINK_HERE'},
					 }

-- These Commands will be sent as TTS messages
TTSCommands = {
			   '/Whatever',
			   '/Whatever2',
			  }
