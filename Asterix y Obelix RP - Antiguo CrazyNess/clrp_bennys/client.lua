local preview = false 
local currentcar = nil
local currentcarPrice = nil
local vehicle = nil
local currentShowroom = nil
local vehicle_list = {
--Benny's
 [1] = {vehicle='VOODOO', spawn=GetHashKey('voodoo'), price=125000, showroom=1},
 [2] = {vehicle='VOODOO 2', spawn=GetHashKey('voodoo2'), price=75000, showroom=1},
 [3] = {vehicle='BUCCANEER', spawn=GetHashKey('buccaneer'), price=150000, showroom=1},
 [4] = {vehicle='BUCCANEER 2', spawn=GetHashKey('buccaneer2'), price=175000, showroom=1},
 [5] = {vehicle='MOONBEAM', spawn=GetHashKey('moonbeam'), price=75000, showroom=1},
 [6] = {vehicle='MOONBEAM 2', spawn=GetHashKey('moonbeam2'), price=175000, showroom=1},
 [7] = {vehicle='PRIMO', spawn=GetHashKey('primo'), price=50000, showroom=1},
 [8] = {vehicle='PRIMO CUSTOM', spawn=GetHashKey('primo2'), price=175000, showroom=1},
 [9] = {vehicle='CHINO', spawn=GetHashKey('chino'), price=150000, showroom=1},
 [10] = {vehicle='CHINO CUSTOM', spawn=GetHashKey('chino2'), price=175000, showroom=1},
 [11] = {vehicle='SABRE TURBO', spawn=GetHashKey('SABREGT'), price=150000, showroom=1},
 [12] = {vehicle='SABRE TURBO 2', spawn=GetHashKey('SABREGT2'), price=175000, showroom=1},
 [13] = {vehicle='TORNADO', spawn=GetHashKey('TORNADO'), price=100000, showroom=1},
 [14] = {vehicle='TORNADO 2', spawn=GetHashKey('TORNADO5'), price=125000, showroom=1},
 [15] = {vehicle='VIRGO', spawn=GetHashKey('virgo'), price=100000, showroom=1},
 [16] = {vehicle='VIRGO CUSTOM', spawn=GetHashKey('virgo2'), price=225000, showroom=1},
 [17] = {vehicle='MINIVAN', spawn=GetHashKey('minivan2'), price=175000, showroom=1},
 [18] = {vehicle='SLAMVAN', spawn=GetHashKey('slamvan'), price=125000, showroom=1},
 [19] = {vehicle='SLAMVAN 2', spawn=GetHashKey('slamvan3'), price=175000, showroom=1},
 [20] = {vehicle='FACTION', spawn=GetHashKey('faction'), price=125000, showroom=1},
 [21] = {vehicle='FACTION 2', spawn=GetHashKey('faction2'), price=225000, showroom=1},
 [22] = {vehicle='RUINER', spawn=GetHashKey('RUINER'), price=100000, showroom=1},
 [23] = {vehicle='MICHELLI', spawn=GetHashKey('MICHELLI'), price=125000, showroom=1},
 [24] = {vehicle='CHEBUREK', spawn=GetHashKey('CHEBUREK'), price=75000, showroom=1},
 [25] = {vehicle='ISSI CLASSIC', spawn=GetHashKey('issi3'), price=75000, showroom=1},
 [26] = {vehicle='YOSEMITE', spawn=GetHashKey('YOSEMITE'), price=75000, showroom=1},
 [27] = {vehicle='ELLIE', spawn=GetHashKey('ELLIE'), price=450000, showroom=1},
 [28] = {vehicle='PICADOR', spawn=GetHashKey('PICADOR'), price=125000, showroom=1},
 [29] = {vehicle='GB200', spawn=GetHashKey('GB200'), price=250000, showroom=1},
 [30] = {vehicle='FUTO', spawn=GetHashKey('futo'), price=75000, showroom=1},
 [31] = {vehicle='Camaro ZL1', spawn=GetHashKey('zl12017'), price=1250000, showroom=1},
 [32] = {vehicle='FACTION 3', spawn=GetHashKey('faction3'), price=350000, showroom=1},
 [33] = {vehicle='DOMINATOR GTX', spawn=GetHashKey('dominator3'), price=1000000, showroom=1},
 [34] = {vehicle='JESTER 3', spawn=GetHashKey('jester3'), price=200000, showroom=1},
 [35] = {vehicle='Impaler', spawn=GetHashKey('impaler'), price=125000, shawroom=1},
 [36] = {vehicle = 'Buffalo', price = 175000, spawn = GetHashKey('Buffalo'), showroom=1}, 
 [37] = {vehicle = 'Buffalo Sports', price = 225000, spawn = GetHashKey('Buffalo2'), showroom=1}, 
 [38] = {vehicle = 'Buffalo Custom', price = 200000, spawn = GetHashKey('Buffalo3'), showroom=1},
 [39] = {vehicle = 'Omnis Custom', price = 300000, spawn = GetHashKey('Omnis'), showroom=1},
 [40] = {vehicle = 'BType Custom', price = 375000, spawn = GetHashKey('BType2'), showroom=1},
 [41] = {vehicle = 'Tornado Cabrio', price = 125000, spawn = GetHashKey('Tornado2'), showroom=1},
 [42] = {vehicle = 'Tornado Classic', price = 225000, spawn = GetHashKey('Tornado5'), showroom=1},
 [43] = {vehicle = 'Dodge Challenger SRT', price = 1125000, spawn = GetHashKey('demon'), showroom=1},
 [44] = {vehicle = 'Mustang GT 2013', price = 1375000, spawn = GetHashKey('mst'), showroom=1},
 [45] = {vehicle = 'Hotknife', price = 250000, spawn = GetHashKey('Hotknife'), showroom=1},
 [46] = {vehicle = 'Nightshade', price = 300000, spawn = GetHashKey('Nightshade'), showroom=1},
 [47] = {vehicle = 'Albany Hermers', price = 325000, spawn = GetHashKey('Hermes'), showroom=1},
 [48] = {vehicle = 'Rapid GT Classic', price = 375000, spawn = GetHashKey('RapidGT3'), showroom=1},
 [49] = {vehicle = 'Dukes', price = 175000, spawn = GetHashKey('Dukes'), showroom=1},
 --Swanns
 [100] = {vehicle = 'Alpha', price = 180000, spawn = GetHashKey('Alpha'), showroom=2}, 
 [101] = {vehicle = 'Banshee', price = 172500, spawn = GetHashKey('Banshee'), showroom=2}, 
 [102] = {vehicle = 'Banshee Custom', price = 183750, spawn = GetHashKey('Banshee2'), showroom=2}, 
 [103] = {vehicle = 'Bestia GTS', price = 300000, spawn = GetHashKey('BestiaGTS'), showroom=2}, 
 [104] = {vehicle = 'Carbonizzare', price = 187500, spawn = GetHashKey('Carbonizzare'), showroom=2}, 
 [105] = {vehicle = 'Comet', price = 146250, spawn = GetHashKey('Comet2'), showroom=2}, 
 [106] = {vehicle = 'Coquette', price = 202500, spawn = GetHashKey('Coquette'), showroom=2}, 
 [107] = {vehicle = 'Elegy Retro Custom', price = 262500, spawn = GetHashKey('Elegy'), showroom=2}, 
 [108] = {vehicle = 'Elegy', price = 210000, spawn = GetHashKey('Elegy2'), showroom=2}, 
 [109] = {vehicle = 'Feltzer', price = 165000, spawn = GetHashKey('Feltzer2'), showroom=2}, 
 [110] = {vehicle = 'Feltzer Classic', price = 435000, spawn = GetHashKey('Feltzer3'), showroom=2}, 
 [111] = {vehicle = 'Furore GT', price = 195000, spawn = GetHashKey('Furoregt'), showroom=2}, 
 [112] = {vehicle = 'Fusilade', price = 127500, spawn = GetHashKey('Fusilade'), showroom=2}, 
 [113] = {vehicle = 'Infernus Classic', price = 562500, spawn = GetHashKey('Infernus2'), showroom=2}, 
 [114] = {vehicle = 'Jester', price = 232500, spawn = GetHashKey('Jester'), showroom=2},
 [115] = {vehicle = 'Jester Custom', price = 243750, spawn = GetHashKey('Jester2'), showroom=2},
 [116] = {vehicle = 'Khamelion', price = 255000, spawn = GetHashKey('Khamelion'), showroom=2},
 [117] = {vehicle = 'Kuruma', price = 243750, spawn = GetHashKey('Kuruma'), showroom=2},
 [118] = {vehicle = 'Lynx', price = 270000, spawn = GetHashKey('Lynx'), showroom=2},
 [119] = {vehicle = 'Massacro', price = 217500, spawn = GetHashKey('Massacro'), showroom=2},
 [120] = {vehicle = 'Massacro Custom', price = 225000, spawn = GetHashKey('Massacro2'), showroom=2},
 [121] = {vehicle = 'NineF', price = 143500, spawn = GetHashKey('Ninef'), showroom=2},
 [122] = {vehicle = 'NineF Cabrio', price = 147000, spawn = GetHashKey('Ninef2'), showroom=2},
 [123] = {vehicle = 'Penumbra', price = 120000, spawn = GetHashKey('Penumbra'), showroom=2},
 [124] = {vehicle = 'RapidGT', price = 135000, spawn = GetHashKey('RapidGT'), showroom=2},
 [125] = {vehicle = 'RapidGT Cabrio', price = 138750, spawn = GetHashKey('RapidGT2'), showroom=2},
 [126] = {vehicle = 'Raptor', price = 300000, spawn = GetHashKey('Raptor'), showroom=2},
 [127] = {vehicle = 'Ruston', price = 318750, spawn = GetHashKey('Ruston'), showroom=2},
 [128] = {vehicle = 'Schafter V12', price = 318750, spawn = GetHashKey('Schafter4'), showroom=2},
 [129] = {vehicle = 'Schwarzer', price = 131250, spawn = GetHashKey('Schwarzer'), showroom=2},
 [130] = {vehicle = 'Specter', price = 300000, spawn = GetHashKey('Specter'), showroom=2},
 [131] = {vehicle = 'Specter Custom', price = 337500, spawn = GetHashKey('Specter2'), showroom=2},
 [132] = {vehicle = 'Surano', price = 133000, spawn = GetHashKey('Surano'), showroom=2},
 [133] = {vehicle = 'Tropos Custom', price = 150000, spawn = GetHashKey('Tropos'), showroom=2},
 [134] = {vehicle = 'Verlierer', price = 243750, spawn = GetHashKey('Verlierer2'), showroom=2},
 [135] = {vehicle = 'BType', price = 450000, spawn = GetHashKey('BType'), showroom=2},
 [136] = {vehicle = 'BType Classic', price = 485500, spawn = GetHashKey('BType3'), showroom=2},
 [137] = {vehicle = 'Cheetah Classic', price = 825000, spawn = GetHashKey('Cheetah2'), showroom=2},
 [138] = {vehicle = 'Coquette Classic', price = 450000, spawn = GetHashKey('Coquette2'), showroom=2},
 [139] = {vehicle = 'Coquette Classic Custom', price = 487500, spawn = GetHashKey('Coquette3'), showroom=2},
 [140] = {vehicle = 'Mamba', price = 393750, spawn = GetHashKey('Mamba'), showroom=2},
 [141] = {vehicle = 'Monroe', price = 300000, spawn = GetHashKey('Monroe'), showroom=2},
 [142] = {vehicle = 'Stinger', price = 375000, spawn = GetHashKey('Stinger'), showroom=2},
 [143] = {vehicle = 'StingerGT', price = 420000, spawn = GetHashKey('StingerGT'), showroom=2},
 [144] = {vehicle = 'Torero', price = 300000, spawn = GetHashKey('Torero'), showroom=2},
 [145] = {vehicle = 'Adder', price = 806250, spawn = GetHashKey('Adder'), showroom=2},
 [146] = {vehicle = 'Bullet', price = 468750, spawn = GetHashKey('Bullet'), showroom=2},
 [147] = {vehicle = 'EntityXF', price = 592500, spawn = GetHashKey('EntityXF'), showroom=2},
 [148] = {vehicle = 'FMJ', price = 900000, spawn = GetHashKey('FMJ'), showroom=2},
 [149] = {vehicle = 'GP1', price = 502500, spawn = GetHashKey('GP1'), showroom=2},
 [150] = {vehicle = 'Infernus', price = 487500, spawn = GetHashKey('Infernus'), showroom=2},
 [151] = {vehicle = 'Nero', price = 1050000, spawn = GetHashKey('Nero'), showroom=2},
 [152] = {vehicle = 'Nero Custom', price = 1170000, spawn = GetHashKey('Nero2'), showroom=2},
 [153] = {vehicle = 'Osiris', price = 712500, spawn = GetHashKey('Osiris'), showroom=2},
 [154] = {vehicle = 'Penetrator', price = 472500, spawn = GetHashKey('Penetrator'), showroom=2},
 [155] = {vehicle = 'X80 Proto', price = 922500, spawn = GetHashKey('Prototipo'), showroom=2},
 [156] = {vehicle = 'Reaper', price = 660000, spawn = GetHashKey('Reaper'), showroom=2},
 [157] = {vehicle = 'SultanRS', price = 150000, spawn = GetHashKey('SultanRS'), showroom=2},
 [158] = {vehicle = 'T20', price = 720000, spawn = GetHashKey('T20'), showroom=2},
 [159] = {vehicle = 'Tempesta', price = 600000, spawn = GetHashKey('Tempesta'), showroom=2},
 [160] = {vehicle = 'Turismo Classic', price = 375000, spawn = GetHashKey('Turismo2'), showroom=2},
 [161] = {vehicle = 'Turismo R', price = 618750, spawn = GetHashKey('Turismor'), showroom=2},
 [162] = {vehicle = 'Tyrus', price = 525000, spawn = GetHashKey('Tyrus'), showroom=2},
 [163] = {vehicle = 'Vacca', price = 570000, spawn = GetHashKey('Vacca'), showroom=2},
 [164] = {vehicle = 'Vagner', price = 1012500, spawn = GetHashKey('Vagner'), showroom=2},
 [165] = {vehicle = 'Voltic', price = 450000, spawn = GetHashKey('Voltic'), showroom=2},
 [166] = {vehicle = 'Zentorno', price = 750000, spawn = GetHashKey('Zentorno'), showroom=2},
 [167] = {vehicle = 'Itali GTB', price = 630000, spawn = GetHashKey('Italigtb'), showroom=2},
 [168] = {vehicle = 'Itali GTB Custom', price = 735000, spawn = GetHashKey('Italigtb2'), showroom=2},
 [169] = {vehicle = 'Coil Raident', price = 337500, spawn = GetHashKey('raiden'), showroom=2},
 [170] = {vehicle = 'Tesla X', price = 375000, spawn = GetHashKey('teslax'), showroom=2},
 [171] = {vehicle = 'Tezeract', price = 1200000, spawn = GetHashKey('tezeract'), showroom=2},
 [172] = {vehicle = 'Jester Classic', price = 337500, spawn = GetHashKey('jester3'), showroom=2},
 [173] = {vehicle = 'Flashgt', price = 281250, spawn = GetHashKey('flashgt'), showroom=2},
 [174] = {vehicle = 'Entity XXR', price = 1500000, spawn = GetHashKey('entity2'), showroom=2},
 [175] = {vehicle = 'Hustler', price = 337500, spawn = GetHashKey('hustler'), showroom=2},
 [176] = {vehicle = 'Viseris', price = 600000, spawn = GetHashKey('viseris'), showroom=2},
 [177] = {vehicle = 'Z190', price = 356250, spawn = GetHashKey('z190'), showroom=2},
 [178] = {vehicle = 'GT500', price = 525000, spawn = GetHashKey('gt500'), showroom=2},
 [179] = {vehicle = 'Kamacho', price = 225000, spawn = GetHashKey('kamacho'), showroom=2},
 [180] = {vehicle = 'SC1', price = 480000, spawn = GetHashKey('sc1'), showroom=2},
 [181] = {vehicle = 'Pariah', price = 525000, spawn = GetHashKey('pariah'), showroom=2},
 [182] = {vehicle = 'Cyclone', price = 645000, spawn = GetHashKey('cyclone'), showroom=2},
 [183] = {vehicle = 'Visione', price = 915000, spawn = GetHashKey('visione'), showroom=2},
 [184] = {vehicle = 'XA21', price = 585000, spawn = GetHashKey('XA21'), showroom=2},
 [185] = {vehicle = 'Pfister 811', price = 637500, spawn = GetHashKey('pfister811'), showroom=2},
 [186] = {vehicle = 'Cheetah', price = 825000, spawn = GetHashKey('cheetah'), showroom=2},
 [187] = {vehicle = 'Tyrant', price = 1162500, spawn = GetHashKey('tyrant'), showroom=2},
 [188] = {vehicle = 'Taipan', price = 1185000, spawn = GetHashKey('taipan'), showroom=2},
 [189] = {vehicle = 'Neon', price = 1065000, spawn = GetHashKey('neon'), showroom=2},
 [190] = {vehicle = 'Windsor', price = 506250, spawn = GetHashKey('Windsor'), showroom=2},
 [191] = {vehicle = 'Windsor Drop', price = 525000, spawn = GetHashKey('Windsor2'), showroom=2},
 [192] = {vehicle = 'Audi RS7', price = 1087500, spawn = GetHashKey('rs7'), showroom=2},
 [193] = {vehicle = 'BMW M3', price = 840000, spawn = GetHashKey('bmwm3e92'), showroom=2},
 [194] = {vehicle = 'BMW M3 Sport', price = 1106250, spawn = GetHashKey('m3e92gts'), showroom=2},
 [195] = {vehicle = 'Mercedes s65', price = 1125000, spawn = GetHashKey('s65'), showroom=2},
 [196] = {vehicle = 'Mercedes c63s', price = 900000, spawn = GetHashKey('c63s'), showroom=2},
 [197] = {vehicle = 'Rolls Royce', price = 900000, spawn = GetHashKey('wraith'), showroom=2},
 [198] = {vehicle = 'Schlagen', price = 675000, spawn = GetHashKey('Schlagen'), showroom=2},
 --Stephens Motorworks
 [300] = {vehicle='Ford Raptor', spawn=GetHashKey('f150'), price=700000, showroom=3},
 [301] = {vehicle='Contender', spawn=GetHashKey('contender'), price=400000, showroom=3},
 [302] = {vehicle='Trophy Truck', spawn=GetHashKey('trophytruck'), price=700000, showroom=3},
 [303] = {vehicle='Trophy Truck 2', spawn=GetHashKey('trophytruck2'), price=900000, showroom=3},
 [304] = {vehicle='Sand King', spawn=GetHashKey('sandking'), price=375000, showroom=3},
 [305] = {vehicle='Sand King 2', spawn=GetHashKey('sandking2'), price=600000, showroom=3},
 [306] = {vehicle='Rebel', spawn=GetHashKey('rebel2'), price=400000, showroom=3},
 [307] = {vehicle='Bodhi', spawn=GetHashKey('bodhi2'), price=275000, showroom=3},
 [308] = {vehicle='DLoader', spawn=GetHashKey('dloader'), price=150000, showroom=3},
 [309] = {vehicle='Slam Van', spawn=GetHashKey('slamvan'), price=250000, showroom=3},
 [310] = {vehicle='Guardian', spawn=GetHashKey('guardian'), price=725000, showroom=3},
 [311] = {vehicle='Dubsta', spawn=GetHashKey('dubsta3'), price=1150000, showroom=3},
 [312] = {vehicle='Sadler', spawn=GetHashKey('Sadler'), price=250000, showroom=3},
 [313] = {vehicle='Bobcat XL', spawn=GetHashKey('bobcatxl'), price=300000, showroom=3},
 [314] = {vehicle='2017 Nissan Titan', spawn=GetHashKey('nissantitan17'), price=1150000, showroom=3},
 [315] = {vehicle='Baller Sport', spawn=GetHashKey('baller3'), price=937500, showroom=3},
 [316] = {vehicle='BMW X6 F16', spawn=GetHashKey('x6m'), price=2250000, showroom=3},
 [317] = {vehicle='Mercedes GL63', spawn=GetHashKey('gl63'), price=2000000, showroom=3},
 [318] = {vehicle='1971 Land Rover', spawn=GetHashKey('lrii109a'), price=937500, showroom=3},
 [319] = {vehicle='Tahoe', spawn=GetHashKey('tahoe'), price=1687500, showroom=3},
 [320] = {vehicle='BeeJay XL', spawn=GetHashKey('bjxl'), price=1125000, showroom=3},
 [321] = {vehicle='Toros', spawn=GetHashKey('toros'), price=2437500, showroom=3},
 [322] = {vehicle='Dubsta2', spawn=GetHashKey('Dubsta2'), price=2062500, showroom=3},
 [323] = {vehicle='Audi SQ7', price = 1500000, spawn = GetHashKey('sq72016'), showroom=3},
 [324] = {vehicle='Range Rover', price = 1000000, spawn = GetHashKey('rr14'), showroom=3},
 [325] = {vehicle='BMW M2', price = 1000000, spawn = GetHashKey('m2'), showroom=3},
 [326] = {vehicle='BMW M3 E36', price = 1000000, spawn = GetHashKey('rmodm3e36'), showroom=3},
 [327] = {vehicle='BMW M3 F80', price = 1000000, spawn = GetHashKey('m3f80'), showroom=3},
 [328] = {vehicle='BMW M4 F82', price = 1000000, spawn = GetHashKey('rr14'), showroom=3},
 [329] = {vehicle='BMW M5', price = 1000000, spawn = GetHashKey('bmci'), showroom=3},
 [330] = {vehicle='BMW M5 F90', price = 1000000, spawn = GetHashKey('m5f90'), showroom=3},
 [331] = {vehicle='BMW M6 F13', price = 1000000, spawn = GetHashKey('m6f13'), showroom=3},
 [332] = {vehicle='BMW X5M 2016', price = 1000000, spawn = GetHashKey('x5m2016'), showroom=3},
 [333] = {vehicle='FERRARI 288 GTO', price = 1000000, spawn = GetHashKey('f288gto'), showroom=3},
 [334] = {vehicle='FERRARI 458 EPECIALE', price = 1000000, spawn = GetHashKey('458speciale'), showroom=3},
 [335] = {vehicle='FERRARI FM 488', price = 1000000, spawn = GetHashKey('fm488'), showroom=3},
 [336] = {vehicle='FERRARI F8 12', price = 1000000, spawn = GetHashKey('f812'), showroom=3},
 [337] = {vehicle='FERRARI F12 M', price = 1000000, spawn = GetHashKey('f12m'), showroom=3},
 [338] = {vehicle='FERRARI F40', price = 1000000, spawn = GetHashKey('f40'), showroom=3}, 
 [339] = {vehicle='FERRARI GTC4', price = 1000000, spawn = GetHashKey('fergtc4'), showroom=3}, 
 [340] = {vehicle='FERRARI LAFERRARI', price = 1000000, spawn = GetHashKey('laferrari'), showroom=3}, 
 [341] = {vehicle='FERRARI 360', price = 1000000, spawn = GetHashKey('modena'), showroom=3}, 
 [342] = {vehicle='Lamborghini 750', price = 1000000, spawn = GetHashKey('rmodlp750'), showroom=3}, 
 [343] = {vehicle='Lamborghini GALLARDO 2005', price = 1000000, spawn = GetHashKey('gallardo2005'), showroom=3}, 
 [344] = {vehicle='Lamborghini URUS 2018', price = 1000000, spawn = GetHashKey('urus2018'), showroom=3},
 [345] = {vehicle='Lamborghini VENENO', price = 1000000, spawn = GetHashKey('rmodveneno'), showroom=3},
 [346] = {vehicle='Lamborghini LP610', price = 1000000, spawn = GetHashKey('lp610'), showroom=3},
 [347] = {vehicle='Lamborghini LP770', price = 1000000, spawn = GetHashKey('rmodlp770'), showroom=3},
 [348] = {vehicle='NISSAN THREELADYZ', price = 1000000, spawn = GetHashKey('threeladyz'), showroom=3},
 [349] = {vehicle='NISSAN LWGTR', price = 1000000, spawn = GetHashKey('lwgtr'), showroom=3},
 [350] = {vehicle='NISSAN Skyline', price = 1000000, spawn = GetHashKey('Skyline'), showroom=3},
 [351] = {vehicle='NISSAN TITAN 17', price = 1000000, spawn = GetHashKey('nissantitan17'), showroom=3}, 
 [352] = {vehicle='VW GOLF GTI', price = 1000000, spawn = GetHashKey('golfgti'), showroom=3},
 [353] = {vehicle='PAGANI Huayra BC', price = 1000000, spawn = GetHashKey('bc'), showroom=3}, 
 [354] = {vehicle='PaganiZondaR', price = 1000000, spawn = GetHashKey('ktkzr'), showroom=3}, 
 [355] = {vehicle='PaganiZondaTricolore', price = 1000000, spawn = GetHashKey('tricolore'), showroom=3},
 [356] = {vehicle='Porsche 718', price = 1000000, spawn = GetHashKey('718'), showroom=3},
 [357] = {vehicle='Porsche 718 Caymans', price = 1000000, spawn = GetHashKey('718caymans'), showroom=3},
 [358] = {vehicle='Porsche 718 GT3', price = 1000000, spawn = GetHashKey('911gt3rs'), showroom=3},
 [359] = {vehicle='Porsche 911 TBS', price = 1000000, spawn = GetHashKey('911tbs'), showroom=3},
 [360] = {vehicle='Porsche PANAMERA TSPORT', price = 1000000, spawn = GetHashKey('pturismo'), showroom=3},
 [361] = {vehicle='Aston Martin VITAGE', price = 1000000, spawn = GetHashKey('virage'), showroom=3},
 [362] = {vehicle='KoenigseggAgeraR', price = 1000000, spawn = GetHashKey('acsr'), showroom=3},
 [363] = {vehicle='KoenigseggRegera', price = 1000000, spawn = GetHashKey('regera'), showroom=3},
 [364] = {vehicle='LotusEvoraGTE', price = 1000000, spawn = GetHashKey('evora'), showroom=3},
 [365] = {vehicle='MazdaRX7', price = 1000000, spawn = GetHashKey('rx7tunable'), showroom=3},
 [366] = {vehicle='PlymouthHemiCuda', price = 1000000, spawn = GetHashKey('hemicuda'), showroom=3},
 [367] = {vehicle='MBAMGGTc', price = 1000000, spawn = GetHashKey('amggt'), showroom=3},
 [368] = {vehicle='STALION2', price = 10000, spawn = GetHashKey('STALION2'), showroom=3},  
 [369] = {vehicle='Mustang', price = 1000000, spawn = GetHashKey('rmodmustang'), showroom=3},  
 [370] = {vehicle='Audi R8', price = 1000000, spawn = GetHashKey('lms'), showroom=3}, 
 [371] = {vehicle='ZENVO', price = 1000000, spawn = GetHashKey('ts1'), showroom=3},
 [372] = {vehicle='BMW M4SP', price = 100000, spawn = GetHashKey('M4SP'), showroom=3},
 [373] = {vehicle='Lexus RCF', price = 100000, spawn = GetHashKey('rcf'), showroom=3},   
 [374] = {vehicle='FXXK', price = 1000000, spawn = GetHashKey('fxxk'), showroom=3},
 [375] = {vehicle='towtruck2', price = 1000, spawn = GetHashKey('towtruck2'), showroom=3},   
 [376] = {vehicle='Z type', price = 1000, spawn = GetHashKey('ztype'), showroom=3},
 [377] = {vehicle='Mesa canis', price = 1000, spawn = GetHashKey('mesa3'), showroom=3}, 
-- Wheels In Motion
 [400] = {vehicle='Ducti', price = 3187500, spawn = GetHashKey('desmo'), showroom=4},
 [401] = {vehicle='R6', price = 3687500, spawn = GetHashKey('r6'), showroom=4},
 [402] = {vehicle='Harley', price = 3000000, spawn = GetHashKey('hvrod'), showroom=4},
 [403] = {vehicle='Vortex', price = 825000, spawn = GetHashKey('vortex'), showroom=4},
 [404] = {vehicle='Esskey', price = 293750, spawn = GetHashKey('esskey'), showroom=4},
 [405] = {vehicle='Avarus', price = 368750, spawn = GetHashKey('avarus'), showroom=4},
 [406] = {vehicle='Sanctus', price = 837500, spawn = GetHashKey('sanctus'), showroom=4},
 [407] = {vehicle='Zombie', price = 607500, spawn = GetHashKey('zombiea'), showroom=4},
 [408] = {vehicle='Zombie Luxuary', price = 762500, spawn = GetHashKey('zombieb'), showroom=4},
 [409] = {vehicle='Bagger', price = 331250, spawn = GetHashKey('bagger'), showroom=4},
 [410] = {vehicle='Thrust', price = 312500, spawn = GetHashKey('thrust'), showroom=4},
 [411] = {vehicle='Bati 801', price = 2187500, spawn = GetHashKey('bati'), showroom=4},
 [412] = {vehicle='Bati 801RR', price = 2375000, spawn = GetHashKey('bati2'), showroom=4},
 [413] = {vehicle='BF400', price = 225000, spawn = GetHashKey('bf400'), showroom=4},
 [414] = {vehicle='Carbon RS', price = 743750, spawn = GetHashKey('carbonrs'), showroom=4},
 [415] = {vehicle='Double T', price = 406250, spawn = GetHashKey('double'), showroom=4},
 [416] = {vehicle='Hakuchou', price = 500000, spawn = GetHashKey('hakuchou'), showroom=4},
 [417] = {vehicle='Hakuchou Sport', price = 1343750, spawn = GetHashKey('hakuchou2'), showroom=4},
 [418] = {vehicle='Nemesis', price = 818750, spawn = GetHashKey('nemesis'), showroom=4},
 [419] = {vehicle='Daemon', price = 875000, spawn = GetHashKey('daemon'), showroom=4},
 [420] = {vehicle='Daemon High', price = 170000, spawn = GetHashKey('daemon2'), showroom=4},
 [421] = {vehicle='Nightblade', price = 406250, spawn = GetHashKey('nightblade'), showroom=4},
 [422] = {vehicle='Sovereign', price = 1687500, spawn = GetHashKey('sovereign'), showroom=4},
 [423] = {vehicle='Wolfsbane', price = 312500, spawn = GetHashKey('Wolfsbane'), showroom=4},
 [424] = {vehicle='Cliffhanger', price = 200000, spawn = GetHashKey('Cliffhanger'), showroom=4},
 [425] = {vehicle='Yamaha TMAX 500', price = 562500, spawn = GetHashKey('tmax'), showroom=4},
 [426] = {vehicle='Chimera', price = 687500, spawn = GetHashKey('Chimera'), showroom=4},
 [427] = {vehicle='Gargoyle', price = 937500, spawn = GetHashKey('Gargoyle'), showroom=4},
 [428] = {vehicle='BF Raptor', price = 2000000, spawn = GetHashKey('Raptor'), showroom=4},
 [429] = {vehicle='BMW 1100R Street Racer', price = 406250, spawn = GetHashKey('bmwsr'), showroom=4},
 [430] = {vehicle='BMW 1100R Naked Street Racer', price = 406250, spawn = GetHashKey('bmwsrn'), showroom=4},
 [431] = {vehicle='Harley Davidson Fat Boy', price = 406250, spawn = GetHashKey('hdfb'), showroom=4},
 [432] = {vehicle='Harley-Davidson Knucklehead', price = 406250, spawn = GetHashKey('hdkn'), showroom=4},
 [433] = {vehicle='F131', price = 406250, spawn = GetHashKey('f131'), showroom=4}, 
 [434] = {vehicle='KAWASAKI 400', price = 406250, spawn = GetHashKey('zl400b'), showroom=4},
 
--coche
 [435] = {vehicle='Audi 1', price = 1000, spawn = GetHashKey('A8AUDI'), showroom=5},
 [436] = {vehicle='Audi 1', price = 1000, spawn = GetHashKey('rs4avant'), showroom=5},
 [437] = {vehicle='Audi 1', price = 1000, spawn = GetHashKey('s5'), showroom=5},
 [438] = {vehicle='Audi 1', price = 1000, spawn = GetHashKey('rs5'), showroom=5},
 [439] = {vehicle='Audi 1', price = 1000, spawn = GetHashKey('sq72016'), showroom=5},
 [440] = {vehicle='Audi 1', price = 1000, spawn = GetHashKey('rs318'), showroom=5},
 [441] = {vehicle='Audi 1', price = 1000, spawn = GetHashKey('r8ppi'), showroom=5},
 [442] = {vehicle='Audi 1', price = 1000, spawn = GetHashKey('r820'), showroom=5},
 [443] = {vehicle='Audi 1', price = 1000, spawn = GetHashKey('ctsv16'), showroom=5},

 --['Buick'] = { "gsxb", "cnty", "rmaster", "rdmstr96", "bgnx"},
 [444] = {vehicle='Buick 1', price = 1000, spawn = GetHashKey('gsxb'), showroom=5},
 [445] = {vehicle='Buick 1', price = 1000, spawn = GetHashKey('cnty'), showroom=5},
 [446] = {vehicle='Buick 1', price = 1000, spawn = GetHashKey('rmaster'), showroom=5},
 [447] = {vehicle='Buick 1', price = 1000, spawn = GetHashKey('rdmstr96'), showroom=5},
 [448] = {vehicle='Buick 1', price = 1000, spawn = GetHashKey('bgnx'), showroom=5}, 
}

local showrooms = {
  [1] = {x = -221.909, y = -1329.717, z = 30.890, id = 1}, -- Bennys | ID: 1
  [2] = {x = -772.501, y = -232.721, z = 37.080, id = 2}, -- Supers | ID: 2
  [3] = {x = 198.918, y = -1000.093, z = -99.000, id = 3}, -- Stephens Motorworks | ID: 3
  [4] = {x = 1986.814, y = 3035.480, z = 47.056, id = 4}, -- Wheels In Motion | ID: 4
  --[5] = {x = -783.503, y = -222.996, z = 37.322, id = 5},
}	

Citizen.CreateThread(function()
 WarMenu.CreateMenu('vehicles', 'Vehicles')
 while true do
  Citizen.Wait(5)
  for ind,v in pairs(showrooms) do 
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 25) and DecorGetInt(GetPlayerPed(-1), "Job") == 15 then
    DrawMarker(2, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 0.5,0.5,0.5, 100,20,255, 200, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 2.5) then
     API_DrawTxt('~b~Press ~g~E~b~ To Access Store')
     if IsControlJustPressed(0, 38) then
       currentshowroom = {id = v.id, x = v.x, y = v.y, z = v.z}
       WarMenu.OpenMenu('vehicles')
     end
    end
   end
  end
  if WarMenu.IsMenuOpened('vehicles') then
   for ind,v in pairs(vehicle_list) do 
    if v.showroom == currentshowroom.id then 
     local updatedPrice = v.price * exports['core']:getVat(8) * 2
     if currentshowroom.id == 2 then updatedPrice = v.price end
     if WarMenu.Button(v.vehicle, "~g~$"..updatedPrice) then
      Wait(250)
      SpawnVehicle(v.spawn, currentshowroom.x, currentshowroom.y, currentshowroom.z)
      Wait(100)
      preview = true 
      currentcar = v
      currentcarPrice = updatedPrice
      WarMenu.CloseMenu('vehicles')
     end
    end
   end
   WarMenu.Display()
  end
  if preview then 
   API_DrawTxt('~b~Press ~g~ENTER~b~ To Confirm Purchase')
   if IsControlJustPressed(0, 18) then
    ShowPurchase()
    preview = false 
   elseif IsControlJustPressed(0, 177) then 
   	DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1), false))
   	preview = false 
   end
  end
 end
end)

function SpawnVehicle(vehiclehash, x,y,z)
 if DoesEntityExist(vehicle) then DeleteVehicle(vehicle) end
 RequestModel(vehiclehash)
 Citizen.CreateThread(function() 
  while not HasModelLoaded(vehiclehash) do  
   Citizen.Wait(0)  
  end
  vehicle = CreateVehicle(vehiclehash, x,y,z, 115, true, false)
  TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
  SetVehicleEngineOn(vehicle, true, true)
  local id = NetworkGetNetworkIdFromEntity(vehicle)
  SetNetworkIdCanMigrate(id, true)
  SetNetworkIdExistsOnAllMachines(id, true)
  SetVehicleIsConsideredByPlayer(vehicle, true)
  SetVehicleDirtLevel(vehicle, 0)
  DecorSetInt(vehicle, "_Fuel_Level", 50000)
 end)
end

RegisterNetEvent("sports:getcar")
AddEventHandler("sports:getcar",function(target, price)
  local data = GetVehProps(GetVehiclePedIsIn(GetPlayerPed(-1), false)) 
  local model = GetDisplayNameFromVehicleModel(data.model)
  TriggerServerEvent('super:purchase2', price, target, model, data)
end)



function getResult()
 DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 6)
  while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0);
    Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
    local result = GetOnscreenKeyboardResult()
    return tonumber(result)
  end
end


function GetVehProps(vehicle)
  local color1, color2 = GetVehicleColours(vehicle)
  local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)

  return {
    model            = GetEntityModel(vehicle),
    plate            = GetVehicleNumberPlateText(vehicle),
    plateIndex       = GetVehicleNumberPlateTextIndex(vehicle),
    health           = GetEntityHealth(vehicle),
    dirtLevel        = GetVehicleDirtLevel(vehicle),
    color1           = color1,
    color2           = color2,
    pearlescentColor = pearlescentColor,
    wheelColor       = wheelColor,
    wheels           = GetVehicleWheelType(vehicle),
    windowTint       = GetVehicleWindowTint(vehicle),
    neonEnabled      = {
     IsVehicleNeonLightEnabled(vehicle, 0),
     IsVehicleNeonLightEnabled(vehicle, 1),
     IsVehicleNeonLightEnabled(vehicle, 2),
     IsVehicleNeonLightEnabled(vehicle, 3),
    },
    neonColor        = table.pack(GetVehicleNeonLightsColour(vehicle)),
    tyreSmokeColor   = table.pack(GetVehicleTyreSmokeColor(vehicle)),
    modSpoilers      = GetVehicleMod(vehicle, 0),
    modFrontBumper   = GetVehicleMod(vehicle, 1),
    modRearBumper    = GetVehicleMod(vehicle, 2),
    modSideSkirt     = GetVehicleMod(vehicle, 3),
    modExhaust       = GetVehicleMod(vehicle, 4),
    modFrame         = GetVehicleMod(vehicle, 5),
    modGrille        = GetVehicleMod(vehicle, 6),
    modHood          = GetVehicleMod(vehicle, 7),
    modFender        = GetVehicleMod(vehicle, 8),
    modRightFender   = GetVehicleMod(vehicle, 9),
    modRoof          = GetVehicleMod(vehicle, 10),
    modEngine        = GetVehicleMod(vehicle, 11),
    modBrakes        = GetVehicleMod(vehicle, 12),
    modTransmission  = GetVehicleMod(vehicle, 13),
    modHorns         = GetVehicleMod(vehicle, 14),
    modSuspension    = GetVehicleMod(vehicle, 15),
    modArmor         = GetVehicleMod(vehicle, 16),
    modTurbo         = IsToggleModOn(vehicle,  18),
    modSmokeEnabled  = IsToggleModOn(vehicle,  20),
    modXenon         = IsToggleModOn(vehicle,  22),
    modFrontWheels   = GetVehicleMod(vehicle, 23),
    modBackWheels    = GetVehicleMod(vehicle, 24),
    modPlateHolder    = GetVehicleMod(vehicle, 25),
    modVanityPlate    = GetVehicleMod(vehicle, 26),
    modTrimA        = GetVehicleMod(vehicle, 27),
    modOrnaments      = GetVehicleMod(vehicle, 28),
    modDashboard      = GetVehicleMod(vehicle, 29),
    modDial         = GetVehicleMod(vehicle, 30),
    modDoorSpeaker      = GetVehicleMod(vehicle, 31),
    modSeats        = GetVehicleMod(vehicle, 32),
    modSteeringWheel    = GetVehicleMod(vehicle, 33),
    modShifterLeavers   = GetVehicleMod(vehicle, 34),
    modAPlate       = GetVehicleMod(vehicle, 35),
    modSpeakers       = GetVehicleMod(vehicle, 36),
    modTrunk        = GetVehicleMod(vehicle, 37),
    modHydrolic       = GetVehicleMod(vehicle, 38),
    modEngineBlock      = GetVehicleMod(vehicle, 39),
    modAirFilter      = GetVehicleMod(vehicle, 40),
    modStruts       = GetVehicleMod(vehicle, 41),
    modArchCover      = GetVehicleMod(vehicle, 42),
    modAerials        = GetVehicleMod(vehicle, 43),
    modTrimB        = GetVehicleMod(vehicle, 44),
    modTank         = GetVehicleMod(vehicle, 45),
    modWindows        = GetVehicleMod(vehicle, 46),
    modLivery       = GetVehicleMod(vehicle, 48)
  }

end

RegisterNetEvent("super:bought")
AddEventHandler("super:bought",function(data, plate)
  DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1), false))
	local pos = GetEntityCoords(GetPlayerPed(-1))
  RequestModel(data.model)
	while not HasModelLoaded(data.model) do
	Citizen.Wait(0)
	end
	spawned = CreateVehicle(data.model, pos.x, pos.y, pos.z, 322.345, true, false)
	SetVehicleNumberPlateText(spawned, plate)
	SetEntityAsMissionEntity(spawned, true, true)
	SetVehicleIsConsideredByPlayer(spawned, true)
	TaskWarpPedIntoVehicle(GetPlayerPed(-1), spawned, -1)
end)

function ShowPurchase()
 if (IsPedInAnyVehicle(GetPlayerPed(PlayerId()))) then    
  SetNuiFocus(true, true)
  SendNUIMessage({open = true})
 end
end

RegisterNUICallback('escape', function(data, cb)
  SetNuiFocus(false)
  SendNUIMessage({open = false})
  cb('ok')
end)

RegisterNUICallback('confirmsale', function(data, cb) 
 if tonumber(data.price) > tonumber(currentcarPrice) then 
  --if tonumber(currentcarPrice) < tonumber(currentcarPrice*1.50) then
   local test = GetVehProps(GetVehiclePedIsIn(GetPlayerPed(-1), false)) 
   local model = GetDisplayNameFromVehicleModel(currentcar.vehicle)
   DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1), false))
   TriggerServerEvent('super:purchase', currentcarPrice, data.ownerid, data.price, currentcar.vehicle, test)
   _GuiEnabled = false
   SetNuiFocus(false)
   SendNUIMessage({open = false})
   cb('ok')
  --else 
  -- TriggerEvent('chatMessage', 'Max Profit Of 25%, Max Sell Price: $'..tonumber(currentcarPrice*1.25))
 -- end
 else
  TriggerEvent('chatMessage', 'Minimum Sale Price: $'..tonumber(currentcarPrice*1.10))
 end
end)

function API_DrawTxt(text)
  SetTextFont(0)
  SetTextProportional(0)
  SetTextScale(0.32, 0.32)
  SetTextColour(0, 255, 255, 255)
  SetTextDropShadow(0, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(1)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(0.5, 0.93) 
end