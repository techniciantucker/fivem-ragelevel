--[[--------------------------------------------------------------------------
	
	* Mello Trainer
	* (C) Michael Goodwin 2017
	* http://github.com/thestonedturtle/mellotrainer/releases
	
	* This menu used the Scorpion Trainer as a framework to build off of.
	* https://github.com/pongo1231/ScorpionTrainer
	* (C) Emre Cürgül 2017
	 
	* A lot of useful functionality has been converted from the lambda menu.
	* https://lambda.menu
	* (C) Oui 2017
	
	* Additional Contributors:
	* WolfKnight (https://forum.fivem.net/u/WolfKnight)
	
--------------------------------------------------------------------------]]--




-- Format: {string, x, y, z, scenery_required*, scenery_to_remove*, isLoaded!}
-- * = Table ! = Boolean

local locations = {}

locations.safeHouses = {
	{ "Michael's Safehouse", -827.138, 176.368, 70.4999 },
	{ "Franklin's Safehouse", -18.0355, -1456.94, 30.4548 },
	{ "Franklin's Safehouse 2", 10.8766, 545.654, 175.419 },
	{ "Trevor's Safehouse", 1982.13, 3829.44, 32.3662 },
	{ "Trevor's Safehouse 2", -1157.05, -1512.73, 4.2127 },
	{ "Trevor's Safehouse 3", 91.1407, -1280.65, 29.1353 },
	{ "Michael's Safehouse Inside", -813.603, 179.474, 72.1548 },
	{ "Franklin's Safehouse Inside", -14.3803, -1438.51, 31.1073 },
	{ "Franklin's Safehouse 2 Inside", 7.11903, 536.615, 176.028 },
	{ "Trevor's Safehouse Inside", 1972.61, 3817.04, 33.4278 },
	{ "Trevor's Safehouse 2 Inside", -1151.77, -1518.14, 10.6327 },
	{ "Trevor's Safehouse 3 Inside", 96.1536, -1290.73, 29.2664 }
}

locations.landmarks = {
	{ "Airport Entrance", -1034.6, -2733.6, 13.8 },
	{ "Airport Field", -1336.0, -3044.0, 13.9 },
	{ "Altruist Cult Camp", -1170.841, 4926.646, 224.295 },
	{ "Calafia Train Bridge", -517.869, 4425.284, 89.795 },
	{ "Cargo Ship", 899.678, -2882.191, 19.013 },
	{ "Chumash", -3192.6, 1100.0, 20.2 },
	{ "Chumash Historic Family Pier", -3426.683, 967.738, 8.347 },
	{ "Del Perro Pier", -1850.127, -1231.751, 13.017 },
	{ "Devin Weston's House", -2639.872, 1866.812, 160.135 },
	{ "El Burro Heights", 1384.0, -2057.1, 52.0 },
	{ "Elysian Island", 338.2, -2715.9, 38.5 },
	{ "Far North San Andreas", 24.775, 7644.102, 19.055 },
	{ "Ferris Wheel", -1670.7, -1125.0, 13.0 },
	{ "Fort Zancudo", -2047.4, 3132.1, 32.8 },
	{ "Fort Zancudo ATC Entrance", -2344.373, 3267.498, 32.811 },
	{ "Fort Zancudo ATC Top Floor", -2358.132, 3249.754, 101.451 },
	{ "God's Thumb", -1006.402, 6272.383, 1.503 },
	{ "Hippy Camp", 2476.712, 3789.645, 41.226 },
	{ "Jetsam", 760.4, -2943.2, 5.8 },
	{ "Jolene Cranley-Evans Ghost", 3059.620, 5564.246, 197.091 },
	{ "Kortz Center", -2243.810, 264.048, 174.615 },
	{ "Main LS Customs", -365.425, -131.809, 37.873 },
	{ "Marlowe Vineyards", -1868.971, 2095.674, 139.115 },
	{ "McKenzie Airfield", 2121.7, 4796.3, 41.1 },
	{ "Merryweather Dock", 486.417, -3339.692, 6.070 },
	{ "Mineshaft", -595.342, 2086.008, 131.412 },
	{ "Mt. Chiliad", 425.4, 5614.3, 766.5 },
	{ "Mt. Chiliad Summit", 450.718, 5566.614, 806.183 },
	{ "NOOSE Headquarters", 2535.243, -383.799, 92.993 },
	{ "Pacific Standard Bank", 235.046, 216.434, 106.287 },
	{ "Paleto Bay Pier", -275.522, 6635.835, 7.425 },
	{ "Playboy Mansion", -1475.234, 167.088, 55.841 },
	{ "Police Station", 436.491, -982.172, 30.699 },
	{ "Quarry", 2954.196, 2783.410, 41.004 },
	{ "Sandy Shores Airfield", 1747.0, 3273.7, 41.1 },
	{ "Satellite Dishes", 2062.123, 2942.055, 47.431 },
	{ "Sisyphus Theater Stage", 686.245, 577.950, 130.461 },
	{ "Trevor's Meth Lab", 1391.773, 3608.716, 38.942 },
	{ "Weed Farm", 2208.777, 5578.235, 53.735 },
	{ "Wind Farm", 2354.0, 1830.3, 101.1 }
}

locations.high = {
	{ "Airplane Graveyard Airplane Tail ", 2395.096, 3049.616, 60.053 },
	{ "FIB Building Roof", 150.126, -754.591, 262.865 },
	{ "Galileo Observatory Roof", -438.804, 1076.097, 352.411 },
	{ "IAA Building Roof", 134.085, -637.859, 262.851 },
	{ "Maze Bank Arena Roof", -324.300, -1968.545, 67.002 },
	{ "Maze Bank Roof", -75.015, -818.215, 326.176 },
	{ "Palmer-Taylor Power Station Chimney", 2732.931, 1577.540, 83.671 },
	{ "Rebel Radio", 736.153, 2583.143, 79.634 },
	{ "Sandy Shores Building Site Crane", 1051.209, 2280.452, 89.727 },
	{ "Satellite Dish Antenna", 2034.988, 2953.105, 74.602 },
	{ "Stab City", 126.975, 3714.419, 46.827 },
	{ "Very High Up", -129.964, 8130.873, 6705.307 },
	{ "Windmill Top", 2026.677, 1842.684, 133.313 }
}

locations.underwater = {
	{ "Dead Sea Monster", -3373.726, 504.714, -24.656 },
	{ "Humane Labs Tunnel", 3619.749, 2742.740, 28.690 },
	{ "Sunken Body", -3161.078, 3001.998, -37.974 },
	{ "Sunken Cargo Ship", 3199.748, -379.018, -22.500 },
	{ "Sunken Plane", -942.350, 6608.752, -20.912 },
	{ "Underwater Hatch", 4273.950, 2975.714, -170.746 },
	{ "Underwater UFO", 762.426, 7380.371, -111.377 },
	{ "Underwater WW2 Tank", 4201.633, 3643.821, -39.016 },
}

locations.houses = {
  {'3669 Wild Oats Dr', 223.918518066406, 513.820129394531, 140.766860961914, price = 750000, ipl="ipl5", item_max=360, weapon_max=5, maxCash=150000, id=1500},
  {'3667 Wild Oats Dr', 166.947738647461, 473.771453857422, 142.513244628906, price = 750000, ipl="ipl5", item_max=360, weapon_max=5, maxCash=150000, id=1501},
  {'3668 Wild Oats Dr', 149.477142333984, 475.156646728516, 142.500610351563, price = 750000, ipl="ipl5", item_max=360, weapon_max=5, maxCash=150000, id=1502},
  {'3661 Wild Oats Dr', 106.912811279297, 467.426177978516, 147.373962402344, price = 750000, ipl="ipl5", item_max=360, weapon_max=5, maxCash=150000, id=1502},
  {'3668 Wild Oats Dr', 119.682594299316, 494.203887939453, 147.342971801758, price = 775000, ipl="ipl5", item_max=360, weapon_max=5, maxCash=150000, id=1503},
  {'3666 Wild Oats Dr', 80.2189331054688, 486.094787597656, 148.201614379883, price = 750000, ipl="ipl5", item_max=360, weapon_max=5, maxCash=150000, id=1504},
  {'1277 Grove St', 85.2913589477539, -1959.39489746094, 21.1217079162598, price = 175000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1505},
  {'1278 Grove St', 77.1166610717773, -1948.58984375, 21.1741638183594, price = 175000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1506},
  {'1279 Grove St', 72.6471862792969, -1938.77770996094, 21.3691101074219, price = 175000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1507},
  {'1280 Grove St', 56.8239517211914, -1922.40063476563, 21.911060333252, price = 175000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1508},
  {'1281 Grove St', 39.6445655822754, -1911.810546875, 21.9535160064697, price = 175000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1509},
  {'1282 Grove St', 23.489013671875, -1896.48852539063, 22.9643936157227, price = 175000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1510},
  {'1283 Grove St', 4.85854005813599, -1883.77673339844, 23.6972579956055, price = 175000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1511},
  {'1284 Grove St', -5.25916337966919, -1871.79077148438, 24.151008605957, price = 175000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1512},
  {'1285 Grove St', -20.8427600860596, -1858.43969726563, 25.4086685180664, price = 185000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1513},
  {'1286 Grove St', -33.6299934387207, -1847.42309570313, 26.193546295166, price = 185000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1514},
  {'1287 Grove St', 113.839782714844, -1960.58666992188, 21.3279056549072, price = 175000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1515},
  {'1288 Grove St', 126.364685058594, -1929.68627929688, 21.3824081420898, price = 175000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1516},
  {'1289 Grove St', 117.816421508789, -1920.64367675781, 21.3233966827393, price = 175000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1517},
  {'1290 Grove St', 100.834327697754, -1912.82214355469, 21.4079418182373, price = 175000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1518},
  {'691 Covenant Ave', 104.17163848877, -1884.912109375, 24.3187770843506, price = 155000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1519},
  {'692 Covenant Ave', 114.91032409668, -1887.759765625, 23.9282245635986, price = 155000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1520},
  {'693 Covenant Ave', 127.841491699219, -1896.84252929688, 23.6741905212402, price = 155000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1521},
  {'694 Covenant Ave', 149.058776855469, -1903.83410644531, 23.5290241241455, price = 155000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1522},
  {'695 Covenant Ave', 130.330902099609, -1853.70874023438, 25.2348079681396, price = 155000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1523},
  {'696 Covenant Ave', 149.843780517578, -1865.37072753906, 24.5912036895752, price = 155000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1524},
  {'697 Covenant Ave', 171.397232055664, -1871.18444824219, 24.4002227783203, price = 155000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1525},
  {'698 Covenant Ave', 192.372039794922, -1883.29345703125, 25.0567588806152, price = 155000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1526},
  {'132 Roy Lowenstein Blvd', 208.257415771484, -1895.06188964844, 24.814136505127, price = 165000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1527},
  {'133 Roy Lowenstein Blvd', 178.824768066406, -1924.61889648438, 21.3710174560547, price = 165000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1528},
  {'134 Roy Lowenstein Blvd', 165.879913330078, -1945.05578613281, 20.2354125976563, price = 165000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1529},
  {'135 Roy Lowenstein Blvd', 148.955123901367, -1960.42102050781, 19.4586162567139, price = 165000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1530},
  {'137 Roy Lowenstein Blvd', 144.026153564453, -1969.39855957031, 18.8576240539551, price = 165000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1531},
  {'138 Roy Lowenstein Blvd', 250.255905151367, -1934.73803710938, 24.699369430542, price = 165000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1532},
  {'139 Roy Lowenstein Blvd', 257.994445800781, -1927.408203125, 25.4447746276855, price = 165000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1533},
  {'140 Roy Lowenstein Blvd', 270.295257568359, -1917.03833007813, 26.1803131103516, price = 165000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1534},
  {'890 Carson Ave', 282.642517089844, -1898.86499023438, 27.2674217224121, price = 35000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1535},
  {'8814 Jamestown St', 236.48747253418, -2045.73803710938, 18.3799839019775, price = 25000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1536},
  {'8815 Jamestown St', 251.442245483398, -2030.01037597656, 18.5071678161621, price = 40000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1537},
  {'8816 Jamestown St', 256.919799804688, -2023.81713867188, 19.2663135528564, price = 22000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1538},
  {'8817 Jamestown St', 279.739227294922, -1993.48034667969, 20.8037929534912, price = 15000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1539},
  {'8818 Jamestown St', 291.244171142578, -1980.76062011719, 21.6005325317383, price = 20000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1540},
  {'8819 Jamestown St', 325.260192871094, -1989.427734375, 24.1672706604004, price = 35000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1541},
  {'8820 Jamestown St', 324.137451171875, -1990.70532226563, 24.1672706604004, price = 35000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1542},
  {'1329 Jamestown St', 330.936614990234, -1981.87780761719, 24.1673145294189, price = 25000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1543},
  {'1327 Jamestown St', 333.826171875, -1978.31616210938, 24.1672763824463, price = 25000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1544},
  {'8821 Jamestown St', 312.293884277344, -1956.43896484375, 24.6167469024658, price = 15000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1545},
  {'131 Wild Oats Dr', 43.0048027038574, 468.421447753906, 148.096130371094, price = 250000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1546},
  {'132 Wild Oats Dr', 58.0044403076172, 449.992523193359, 147.031387329102, price = 250000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1547},
  {'3661 Wild Oats Dr', -7.58778667449951, 468.515777587891, 145.867630004883, price = 195000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1548},
  {'3659 Wild Oats Dr', -66.7435913085938, 490.804779052734, 144.691543579102, price = 250000, ipl="ipl4", item_max=120, weapon_max=4, maxCash=150000, id=1549},
  {'3657 Wild Oats Dr', -110.009078979492, 502.409149169922, 143.297927856445, price = 275000, ipl="ipl4", item_max=120, weapon_max=4, maxCash=150000, id=1550},
  {'3655 Wild Oats Dr', -175.006759643555, 502.447723388672, 137.420181274414, price = 285000, ipl="ipl4", item_max=120, weapon_max=4, maxCash=150000, id=1551},
  {'133 Wild Oats Dr', -230.731979370117, 488.698486328125, 128.768020629883, price = 310000, ipl="ipl4", item_max=120, weapon_max=4, maxCash=150000, id=1552},
  {'3581 Didion Dr', -355.006072998047, 470.101318359375, 112.511726379395, price = 400000, ipl="ipl6", item_max=120, weapon_max=4, maxCash=150000, id=1553},
  {'3651 Didion Dr', -312.326202392578, 474.574249267578, 111.83171081543, price = 350000, ipl="ipl6", item_max=120, weapon_max=4, maxCash=150000, id=1554},
  {'3572 Cox Way', -305.199951171875, 431.485504150391, 110.308853149414, price = 295000, ipl="ipl6", item_max=120, weapon_max=4, maxCash=150000, id=1555},
  {'3659 Cox Way', -400.113952636719, 427.348663330078, 112.341438293457, price = 475000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1556},
  {'3660 Cox Way', -451.712280273438, 395.310882568359, 104.774223327637, price = 495000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1557},
  {'3548 Cox Way', -500.508636474609, 398.362884521484, 98.2321624755859, price = 350000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1558},
  {'3565 Cox Way', -516.793029785156, 433.028411865234, 97.807991027832, price = 350000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1559},
  {'3543 Milton Rd', -537.074401855469, 477.408813476563, 103.193626403809, price = 500000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1560},
  {'3545 Milton Rd', -526.777770996094, 517.123413085938, 112.942558288574, price = 250000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1561},
  {'3549 Didion Dr', -500.528472900391, 552.31689453125, 120.60237121582, price = 210000, ipl="ipl6", item_max=120, weapon_max=4, maxCash=150000, id=1562},
  {'3587 Didion Dr', -459.185729980469, 537.95654296875, 121.453689575195, price = 250000, ipl="ipl6", item_max=120, weapon_max=4, maxCash=150000, id=1563},
  {'3545 Didion Dr', -426.1259765625, 535.524658203125, 122.265563964844, price = 250000, ipl="ipl6", item_max=120, weapon_max=4, maxCash=150000, id=1564},
  {'3583 Didion Dr', -386.652648925781, 504.867645263672, 120.412666320801, price = 430000, ipl="ipl6", item_max=120, weapon_max=4, maxCash=150000, id=1565},
  {'3551 Didion Dr', -378.084442138672, 525.319763183594, 121.402397155762, price = 295000, ipl="ipl6", item_max=120, weapon_max=4, maxCash=150000, id=1566},
  {'3566 Didion Dr', -349.092926025391, 514.394104003906, 120.650032043457, price = 25000, ipl="ipl6", item_max=120, weapon_max=4, maxCash=150000, id=1567},
  {'3560 Didion Dr', -298.023590087891, 380.015106201172, 112.095420837402, price = 400000, ipl="ipl6", item_max=120, weapon_max=4, maxCash=150000, id=1568},
  {'3558 Didion Dr', -323.500732421875, 379.009246826172, 110.01879119873, price = 250000, ipl="ipl6", item_max=120, weapon_max=4, maxCash=150000, id=1569},
  {'3556 Didion Dr', -371.816925048828, 343.579986572266, 109.942565917969, price = 255000, ipl="ipl6", item_max=120, weapon_max=4, maxCash=150000, id=1570},
  {'3552 Didion Dr', -444.394958496094, 343.549224853516, 105.469825744629, price = 355000, ipl="ipl6", item_max=120, weapon_max=4, maxCash=150000, id=1571},
  {'3550 Didion Dr', -469.289947509766, 329.310607910156, 104.735145568848, price = 325000, ipl="ipl6", item_max=120, weapon_max=4, maxCash=150000, id=1572},
  {'3567 Cox Way', -476.875518798828, 412.961456298828, 103.121765136719, price = 175000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1573},
  {'235 Milton Rd', -560.987670898438, 402.977508544922, 101.805358886719, price = 240000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1574},
  {'236 Milton Rd', -595.9443359375, 393.876647949219, 101.882347106934, price = 185000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1575},
  {'237 Milton Rd', -615.439514160156, 398.594116210938, 101.626594543457, price = 185000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1576},
  {'44971 Brouge Ave', 198.321197509766, -1725.564453125, 29.663646697998, price = 35000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1578},
  {'44972 Brouge Ave', 249.559722900391, -1730.74450683594, 29.6716537475586, price = 40000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1579},
  {'44973 Brouge Ave', 222.906951904297, -1702.79833984375, 29.699104309082, price = 45000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1580},
  {'44974 Brouge Ave', 257.458862304688, -1722.68139648438, 29.6541309356689, price = 40000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1581},
  {'44975 Brouge Ave', 269.182586669922, -1712.77233886719, 29.6685218811035, price = 38000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1582},
  {'1338 Macdonald St', 281.680938720703, -1694.58618164063, 29.6479320526123, price = 45000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1583},
  {'1339 Macdonald St', 252.694229125977, -1671.48205566406, 29.6631965637207, price = 40000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1584},
  {'44976 Brouge Ave', 241.133499145508, -1687.80480957031, 29.6995677947998, price = 45000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1585},
  {'1293 Roy Lowenstein Blvd', 332.765930175782, -1741.23107910152, 29.7305221557612, price = 40000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1586},
  {'13 Roy Lowenstein Blvd', 321.360290527344, -1760.16760253906, 29.621545791626, price = 30000, ipl="ipl1", item_max=120, weapon_max=4, maxCash=150000, id=1587},
  {'17 Roy Lowenstein Blvd', 304.634521484375, -1775.46826171875, 29.1013088226318, price = 40000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1588},
  {'18 Roy Lowenstein Blvd', 289.006988525391, -1792.44482421875, 28.0890560150146, price = 40000,   ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1589},
  {'1291 Grove St', 54.1420974731445, -1873.64575195313, 22.8058090209961, price = 13000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1590},
  {'1292 Grove St', 45.6420135498047, -1864.89880371094, 23.2782783508301, price = 20000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1591},
  {'1293 Grove St', 20.7029132843018, -1844.48547363281, 24.6017360687256, price = 15000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1592},
  {'1294 Grove St', -50.7482109069824, -1783.71008300781, 28.300817489624, price = 15000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1593},
  {'1295 Grove St', -42.3079109191895, -1792.63879394531, 27.8280181884766, price = 12000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1594},
  {'44977 Brouge Ave', 216.699966430664, -1717.37731933594, 29.6728572845459, price = 15000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1595},
  {'19 Roy Lowenstein Blvd', 328.533111572266, -1845.04260253906, 27.7480697631836, price = 36000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1596},
  {'20 Roy Lowenstein Blvd', 348.848968505859, -1820.4306640625, 28.8941192626953, price = 25000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1597},
  {'16 Roy Lowenstein Blvd', 380.222015380859, -1813.68762207031, 29.0583915710449, price = 5500, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1598},
  {'15 Roy Lowenstein Blvd', 378.777526855469, -1812.45947265625, 29.0608043670654, price = 5500, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1599},
  {'14 Roy Lowenstein Blvd', 367.099609375, -1802.556640625, 29.0795803070068, price = 5500, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1600},
  {'17 Macdonald St', 405.837463378906, -1795.20422363281, 29.0461673736572, price = 5500, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1601},
  {'18 Macdonald St', 398.599945068359, -1789.30627441406, 29.1549682617188, price = 5500, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1602},
  {'19 Macdonald St', 440.232635498047, -1830.00634765625, 28.3618564605713, price = 25000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1603},
  {'66 Jamestown St', 427.480621337891, -1841.79418945313, 28.4634456634521, price = 20000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1604},
  {'67 Jamestown St', 412.894989013672, -1855.87036132813, 27.3231315612793, price = 22000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1605},
  {'68 Jamestown St', 399.740478515625, -1864.67602539063, 26.7163772583008, price = 25000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1606},
  {'69 Jamestown St', 385.410980224609, -1881.97399902344, 26.0319347381592, price = 30000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1607},
  {'70 Jamestown St', 368.466003417969, -1896.10571289063, 25.1785316467285, price = 20000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1608},
  {'71 Jamestown St', 472.714477539063, -1775.01330566406, 29.0707664489746, price = 40000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1609},
  {'72 Jamestown St', 474.794708251953, -1757.84936523438, 29.0926284790039, price = 20000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1610},
  {'73 Jamestown St', 479.645141601563, -1736.42529296875, 29.1510257720947, price = 20000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1611},
  {'74 Jamestown St', 489.786926269531, -1714.20251464844, 29.7066135406494, price = 35000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1612},
  {'75 Jamestown St', 500.375793457031, -1697.67102050781, 29.7892436981201, price = 25000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1613},
  {'76 Jamestown St', 495.536224365234, -1822.73669433594, 28.8697071075439, price = 20000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1614},
  {'77 Jamestown St', 500.313415527344, -1812.85791015625, 28.8911590576172, price = 20000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1615},
  {'78 Jamestown St', 512.193237304688, -1790.67541503906, 28.9194660186768, price = 22000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1616},
  {'79 Jamestown St', 514.039306640625, -1780.89538574219, 28.9139766693115, price = 31000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1617},
  {'1 Roy Lowenstein Blvd', 467.265808105469, -1590.05041503906, 32.7922286987305, price = 15000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1618},
  {'2 Roy Lowenstein Blvd', 455.100921630859, -1579.97717285156, 32.7920341491699, price = 15000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1619},
  {'3 Roy Lowenstein Blvd', 460.879608154297, -1584.92443847656, 32.7920875549316, price = 16000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1620},
  {'4 Roy Lowenstein Blvd', 461.006317138672, -1573.67858886719, 32.7922592163086, price = 16000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1621},
  {'5 Roy Lowenstein Blvd', 465.721893310547, -1567.93237304688, 32.7923049926758, price = 16000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1622},
  {'6 Roy Lowenstein Blvd', 470.882202148438, -1561.80871582031, 32.792293548584, price = 16000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1622},
  {'1 Innocence Blvd', 436.464996337891, -1564.52661132813, 32.7923316955566, price = 16000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1623},
  {'1 Davis Ave', 430.367309570313, -1559.0390625, 32.7922782897949, price = 15000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1624},
  {'2 Davis Ave', 442.321472167969, -1569.29895019531, 32.7922859191895, price = 15000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1625},
  {'7 Roy Lowenstein Blvd', 480.242309570313, -1552.62475585938, 29.2826194763184, price = 80000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1626},
  {'8 Roy Lowenstein Blvd', 405.373718261719, -1751.58044433594, 29.710319519043, price = 20000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1627},
  {'9 Roy Lowenstein Blvd', 418.772064208984, -1735.7119140625, 29.6076946258545, price = 25000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1628},
  {'10 Roy Lowenstein Blvd', 430.684417724609, -1725.47802734375, 29.601432800293, price = 16000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1629},
  {'11 Roy Lowenstein Blvd', 443.298522949219, -1707.1416015625, 29.7049388885498, price = 25000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1630},
  {'1 Little Bighorn Ave', 559.225646972656, -1777.310546875, 33.4426422119141, price = 5000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1640},
  {'2 Little Bighorn Ave', 560.162353515625, -1777.08435058594, 33.4426422119141, price = 5000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1641},
  {'3 Little Bighorn Ave', 550.480773925781, -1770.70751953125, 33.4426383972168, price = 5000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1642},
  {'4 Little Bighorn Ave', 552.808715820313, -1765.1953125, 33.4426383972168, price = 5000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1643},
  {'2 Innocence Blvd', 555.768249511719, -1758.77685546875, 33.4426383972168, price = 5000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1644},
  {'3 Innocence Blvd', 561.657897949219, -1747.51599121094, 33.4426383972168, price = 5000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1645},
  {'4 Innocence Blvd', 559.590209960938, -1750.9794921875, 33.4426383972168, price = 5000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1646},
  {'5 Innocence Blvd', 561.690124511719, -1752.0888671875, 29.28005027771, price = 5000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1647},
  {'6 Innocence Blvd', 558.178833007813, -1759.5751953125, 29.3126964569092, price = 5000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1648},
  {'1 Little Bighorn Ave', 555.068298339844, -1766.38647460938, 29.3121128082275, price = 5000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1649},
  {'2 Little Bighorn Ave', 552.578674316406, -1771.53198242188, 29.311975479126, price = 5000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1650},
  {'3 Little Bighorn Ave', 550.620300292969, -1775.51257324219, 29.3119735717773, price = 5000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1651},
  {'4 Little Bighorn Ave', 566.466003417969, -1777.77087402344, 29.3535633087158, price = 5000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1652},
  {'1088 Forum Dr', 16.6787986755371, -1443.90344238281, 30.948802947998, price = 40000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1653},
  {'1089 Forum Dr', -14.1437072753906, -1442.05700683594, 31.1010856628418, price = 65000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1654},
  {'1090 Forum Dr', -33.1374969482422, -1446.42944335938, 31.8914070129395, price = 30000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1655},
  {'1091 Forum Dr', -46.0337219238281, -1445.56079101563, 32.4295921325684, price = 30000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1656},
  {'1092 Forum Dr', -64.1268157958984, -1449.96374511719, 32.5249137878418, price = 20000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1657},
  {'401 Hawick Ave', 310.030242919922, -208.261077880859, 54.221809387207, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1658},
  {'402 Hawick Ave', 307.414855957031, -216.241989135742, 54.221809387207, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1659},
  {'403 Hawick Ave', 311.176544189453, -217.892333984375, 54.221809387207, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1660},
  {'404 Hawick Ave', 312.966491699219, -218.531951904297, 54.221809387207, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1661},
  {'405 Hawick Ave', 311.615509033203, -203.818206787109, 54.2217674255371, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1662},
  {'406 Hawick Ave', 313.670593261719, -198.256134033203, 54.2217674255371, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1663},
  {'231 Meteor St', 315.530456542969, -195.171356201172, 54.2264366149902, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1664},
  {'232 Meteor St', 319.047882080078, -196.342208862305, 54.2264366149902, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1665},
  {'407 Hawick Ave', 312.813323974609, -218.570068359375, 58.0192489624023, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1666},
  {'408 Hawick Ave', 311.086029052734, -217.842208862305, 58.0192489624023, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1667},
  {'409 Hawick Ave', 307.51220703125, -216.650009155273, 58.0192489624023, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1668},
  {'410 Hawick Ave', 307.594604492188, -213.755249023438, 58.0192489624023, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1669},
  {'411 Hawick Ave', 309.711059570313, -208.12043762207, 58.0192489624023, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1670},
  {'412 Hawick Ave', 311.485473632813, -203.746948242188, 58.0192489624023, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1671},
  {'413 Hawick Ave', 313.430023193359, -198.353302001953, 58.0192489624023, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1672},
  {'414 Meteor St', 315.689605712891, -195.176666259766, 58.0192489624023, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1673},
  {'415 Meteor St', 319.208801269531, -196.481430053711, 58.0192375183105, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1674},
  {'416 Meteor St', 321.182891845703, -197.25666809082, 58.0192375183105, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1675},
  {'417 Hawick Ave', 329.665222167969, -224.972961425781, 54.2217712402344, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1676},
  {'418 Meteor St', 331.539916992188, -225.709884643555, 54.2217712402344, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1677},
  {'419 Meteor St', 334.964477539063, -227.086654663086, 54.2217712402344, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1678},
  {'420 Meteor St', 336.907623291016, -224.598754882813, 54.2217712402344, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1679},
  {'421 Meteor St', 339.042572021484, -219.41389465332, 54.2217712402344, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1680},
  {'422 Meteor St', 340.8125, -214.559417724609, 54.2217750549316, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1681},
  {'423 Meteor St', 342.790100097656, -209.494918823242, 54.2217750549316, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1682},
  {'424 Meteor St', 344.375946044922, -204.819137573242, 54.2218208312988, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1683},
  {'425 Meteor St', 346.474212646484, -199.631256103516, 54.2218132019043, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1684},
  {'426 Hawick Ave', 329.566467285156, -224.855743408203, 58.0192489624023, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1685},
  {'233 Meteor St', 331.49365234375, -225.759399414063, 58.0192489624023, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1686},
  {'234 Meteor St', 335.217254638672, -227.234039306641, 58.0192489624023, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1687},
  {'235 Meteor St', 336.810028076172, -224.740097045898, 58.0192489624023, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1688},
  {'236 Meteor St', 338.964263916016, -219.405395507813, 58.0192489624023, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1689},
  {'237 Meteor St', 340.763610839844, -214.916305541992, 58.0192489624023, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1690},
  {'238 Meteor St', 342.832916259766, -209.555221557617, 58.0192489624023, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1691},
  {'239 Meteor St', 344.670867919922, -204.83235168457, 58.0192489624023, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1692},
  {'240 Meteor St', 346.631744384766, -199.720458984375, 58.0192489624023, price = 4000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1693},
  {'1162 Power St', 285.467132568359, -160.434753417969, 64.6171264648438, price = 95000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1694},
  {'1161 Spanish Ave', 315.498992919922, -127.580055236816, 69.9769592285156, price = 80000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1695},
  {'1160 Spanish Ave', 352.754272460938, -141.946380615234, 66.6882781982422, price = 55000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1696},
  {'66219 Laguna Pl', 44.6463203430176, -29.7965888977051, 69.3947677612305, price = 65000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1697},
  {'66220 Laguna Pl', 47.226734161377, -28.8115119934082, 73.6836318969727, price = 65000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1698},
  {'66221 Laguna Pl', 46.3009338378906, -30.9651355743408, 73.6836318969727, price = 65000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1699},
  {'66222 Laguna Pl', 43.9569625854492, -36.7891960144043, 73.6836318969727, price = 65000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1700},
  {'8320 Power St', 234.597290039063, -107.607604980469, 74.3527374267578, price = 65000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1701},
  {'8321 Power St', 234.528884887695, -107.533767700195, 78.3569183349609, price = 70000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1702},
  {'1632 Eclipse Blvd', -425.740234375, 221.428665161133, 83.3779525756836, price = 78000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1703},
  {'1633 Eclipse Blvd', -419.361450195313, 221.499435424805, 83.3976898193359, price = 78000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1704},
  {'1634 Eclipse Blvd', -413.590911865234, 220.916961669922, 83.4316329956055, price = 78000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1705},
  {'74 South Mo Milton Dr', -819.813049316406, 268.122344970703, 86.3925704956055, price = 120000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1706},
  {'75 South Mo Milton Dr', -876.778015136719, 306.126037597656, 84.1539077758789, price = 350000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1707},
  {'72 Dunstable Ln', -881.9267578125, 364.203704833984, 85.3627090454102, price = 365000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1708},
  {'2835 Picture Perfect Drive', -824.668273925781, 422.582611083984, 92.1241760253906, price = 175000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1709},
  {'188 Picture Perfect Drive', -762.367553710938, 431.415893554688, 100.196907043457, price = 150000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1710},
  {'2893 Picture Perfect Drive', -718.253051757813, 449.321868896484, 106.909141540527, price = 495000, ipl="ipl4", item_max=120, weapon_max=4, maxCash=150000, id=1711},
  {'189 Picture Perfect Drive', -667.405456542969, 472.520904541016, 114.136627197266, price = 210000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1712},
  {'190 Picture Perfect Drive', -623.009155273438, 489.467803955078, 108.825889587402, price = 175000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1713},
  {'191 Picture Perfect Drive', -580.611389160156, 492.357635498047, 108.90306854248, price = 175000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1714},
  {'90 Milton Rd', -554.667419433594, 540.377136230469, 110.70711517334, price = 120000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1715},
  {'192 Picture Perfect Drive', -595.305053710938, 529.722229003906, 107.756378173828, price = 235000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1716},
  {'193 Picture Perfect Drive', -640.872924804688, 520.150573730469, 109.687705993652, price = 275000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1717},
  {'194 Picture Perfect Drive', -678.538208007813, 510.945495605469, 113.525985717773, price = 195000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1718},
  {'195 Picture Perfect Drive', -721.882263183594, 489.87109375, 109.385116577148, price = 188000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1719},
  {'196 Picture Perfect Drive', -784.189697265625, 459.174591064453, 100.179023742676, price = 150000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1720},
  {'197 Picture Perfect Drive', -833.445495605469, 455.732238769531, 89.4619598388672, price = 245000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1721},
  {'76 South Mo Milton Dr', -875.972229003906, 486.210266113281, 87.81591796875, price = 275000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1722},
  {'77 South Mo Milton Dr', -883.924133300781, 517.908020019531, 92.4428482055664, price = 250000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1723},
  {'78 South Mo Milton Dr', -850.515258789063, 521.368408203125, 90.6222305297852, price = 255000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1724},
  {'79 South Mo Milton Dr', -873.955139160156, 562.232543945313, 96.6193618774414, price = 243000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1725},
  {'80 South Mo Milton Dr', -904.813354492188, 587.093566894531, 100.990768432617, price = 235000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1726},
  {'81 South Mo Milton Dr', -958.211364746094, 606.434692382813, 106.035629272461, price = 210000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1727},
  {'6654 San Vitus Blvd', -206.333572387695, -7.46450138092041, 56.6229591369629, price = 75000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1728},
  {'6655 San Vitus Blvd', -206.172836303711, -7.62934827804565, 60.6270790100098, price = 75000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1729},
  {'6544 Spanish Ave', -142.678634643555, 62.5606956481934, 70.8436889648438, price = 85000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1730},
  {'6545 Spanish Ave', -153.771423339844, 69.3135223388672, 70.7745971679688, price = 85000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1731},
  {'6546 Spanish Ave', -165.139022827148, 76.352409362793, 70.6643371582031, price = 85000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1732},
  {'6547 Spanish Ave', -176.647979736328, 82.8485412597656, 70.232795715332, price = 85000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1733},
  {'6548 Spanish Ave', -188.185943603516, 89.2315521240234, 69.9297103881836, price = 85000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1734},
  {'6656 San Vitus Blvd', -197.824234008789, 86.4784774780273, 69.7562942504883, price = 110000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1735},
  {'6549 Spanish Ave', -150.345184326172, 123.335670471191, 70.225471496582, price = 75000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1736},
  {'6550 Spanish Ave', -159.764190673828, 128.813110351563, 70.2254638671875, price = 75000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1737},
  {'6551 Spanish Ave', 6.0392804145813, -8.8131103515625, 70.1161727905273, price = 65000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1738},
  {'22 Laguna Pl', 17.7873134613037, -12.8570919036865, 70.1161727905273, price = 65000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1739},
  {'23 Spanish Ave', 3.44558548927307, 36.9251098632813, 71.5304107666016, price = 175000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1740},
  {'1152 Alta Pl', 206.546264648438, -85.2609786987305, 69.2289123535156, price = 85000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1741},
  {'1153 Alta Pl', 201.922286987305, -133.212341308594, 63.4943466186523, price = 90000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1742},
  {'1154 Alta Pl', 188.0576171875, -145.784606933594, 61.5780181884766, price = 65000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1743},
  {'1337 Power St', 231.467712402344, -130.78938293457, 63.7633171081543, price = 80000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1744},
  {'1338 Power St', 225.534423828125, -161.023727416992, 58.9055442810059, price = 83000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1745},
  {'2042 North Conker Ave', 315.930419921875, 501.472900390625, 153.179794311523, price = 115000, ipl="ipl5", item_max=120, weapon_max=4, maxCash=150000, id=1746},
  {'2043 North Conker Ave', 331.196441650391, 466.089416503906, 151.174774169922, price = 230000, ipl="ipl5", item_max=120, weapon_max=4, maxCash=150000, id=1747},
  {'2044 North Conker Ave', 346.507904052734, 440.604064941406, 147.702423095703, price = 250000, ipl="ipl5", item_max=120, weapon_max=4, maxCash=150000, id=1748},
  {'2045 North Conker Ave', 373.434143066406, 428.146240234375, 145.684707641602, price = 275000, ipl="ipl5", item_max=120, weapon_max=4, maxCash=150000, id=1749},
  {'2046 North Conker Ave', 325.241119384766, 537.234741210938, 153.864883422852, price = 300000, ipl="ipl5", item_max=120, weapon_max=4, maxCash=150000, id=1750},
  {'3671 Whispymound Dr', 8.55611801147461, 540.339416503906, 176.027221679688, price = 500000, ipl="ipl4", item_max=120, weapon_max=4, maxCash=150000, id=1751},
  {'3673 Whispymound Dr', 45.6902656555176, 556.293640136719, 180.082153320313, price = 420000, ipl="ipl4", item_max=120, weapon_max=4, maxCash=150000, id=1752},
  {'3675 Whispymound Dr', 84.8436813354492, 562.221801757813, 182.768463134766, price = 399000, ipl="ipl4", item_max=120, weapon_max=4, maxCash=150000, id=1753},
  {'3677 Whispymound Dr', 119.155281066895, 564.816223144531, 183.959320068359, price = 275000, ipl="ipl4", item_max=120, weapon_max=4, maxCash=150000, id=1754},
  {'3679 Whispymound Dr', 150.395950317383, 555.749633789063, 183.737319946289, price = 550000, ipl="ipl4", item_max=120, weapon_max=4, maxCash=150000, id=1755},
  {'3680 Whispymound Dr', 215.941253662109, 620.677673339844, 187.633911132813, price = 400000, ipl="ipl4", item_max=120, weapon_max=4, maxCash=150000, id=1756},
  {'3681 Whispymound Dr', 231.698883056641, 672.740844726563, 189.945602416992, price = 575000, ipl="ipl4", item_max=120, weapon_max=4, maxCash=150000, id=1757},
  {'22134 Lake Vinewood Dr', 228.552642822266, 765.920654296875, 204.780746459961, price = 1200000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1758},
  {'3570 Cox Way', -372.033569335938, 408.122589111328, 110.593742370605, price = 545000, ipl="ipl6", item_max=120, weapon_max=4, maxCash=150000, id=1759},
  {'1 Didion Dr', -418.405670166016, 568.292114257813, 125.059959411621, price = 400000, ipl="ipl6", item_max=120, weapon_max=4, maxCash=150000, id=1760},
  {'2 Didion Dr', -474.737060546875, 585.976379394531, 128.683349609375, price = 675000, ipl="ipl6", item_max=120, weapon_max=4, maxCash=150000, id=1761},
  {'2820 Milton Rd', -520.090515136719, 594.278198242188, 120.836563110352, price = 585000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1762},
  {'1691 Kimble Hill Dr', -476.646636962891, 648.039367675781, 144.386672973633, price = 835000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1763},
  {'2850 Milton Rd', -515.160400390625, 628.854736328125, 133.559768676758, price = 495000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1764},
  {'1691 Kimble Hill Dr', -498.583801269531, 682.950561523438, 151.562927246094, price = 700000, ipl="ipl6", item_max=120, weapon_max=4, maxCash=150000, id=1765},
  {'1692 Kimble Hill Dr', -445.863098144531, 685.69482421875, 152.951263427734, price = 750000, ipl="ipl6", item_max=120, weapon_max=4, maxCash=150000, id=1766},
  {'1693 Kimble Hill Dr', -400.039337158203, 665.677795410156, 163.83024597168, price = 523000, ipl="ipl4", item_max=120, weapon_max=4, maxCash=150000, id=1767},
  {'1694 Kimble Hill Dr', -353.231048583984, 667.94189453125, 169.0703125, price = 786000, ipl="ipl4", item_max=120, weapon_max=4, maxCash=150000, id=1768},
  {'1695 Kimble Hill Dr', -308.071044921875, 643.286315917969, 176.130493164063, price = 550000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1769},
  {'1696 Kimble Hill Dr', -293.6103515625, 601.517150878906, 181.575576782227, price = 600000, ipl="ipl4", item_max=120, weapon_max=4, maxCash=150000, id=1779},
  {'1697 Kimble Hill Dr', -257.099243164063, 632.430480957031, 187.80517578125, price = 820000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1780},
  {'1698 Kimble Hill Dr', -232.567993164063, 588.717956542969, 190.535949707031, price = 610000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1781},
  {'1699 Kimble Hill Dr', -189.237884521484, 617.665771484375, 199.661270141602, price = 850000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1782},
  {'1700 Kimble Hill Dr', -185.457489013672, 591.839660644531, 197.82307434082, price = 598000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1783},
  {'1701 Kimble Hill Dr', -126.617713928223, 589.051086425781, 204.516906738281, price = 600000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1784},
  {'4585 Milton Rd', -533.675415039063, 709.1513671875, 153.087249755859, price = 651000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1785},
  {'4586 Milton Rd', -495.166351318359, 739.37890625, 163.030975341797, price = 638000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1786},
  {'4587 Milton Rd', -494.490295410156, 795.904968261719, 184.344772338867, price = 648000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1787},
  {'4588 Milton Rd', -536.434509277344, 818.968139648438, 197.510467529297, price = 658000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1788},
  {'4589 Milton Rd', -597.545043945313, 852.1123046875, 211.392211914063, price = 662000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1789},
  {'6085 Milton Rd', -658.504211425781, 887.324584960938, 229.248886108398, price = 1400000, ipl="ipl4", item_max=120, weapon_max=4, maxCash=150000, id=1790},
  {'1203 Normandy Dr', -655.101989746094, 804.080932617188, 199.001190185547, price = 750000, ipl="ipl4", item_max=120, weapon_max=4, maxCash=150000, id=1791},
  {'1205 Normandy Dr', -595.259948730469, 781.252807617188, 189.110458374023, price = 734000, ipl="ipl4", item_max=120, weapon_max=4, maxCash=150000, id=1792},
  {'1206 Normandy Dr', -566.161743164063, 761.748168945313, 185.425079345703, price = 384000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1793},
  {'1207 Normandy Dr', -579.899780273438, 733.646667480469, 184.211807250977, price = 527000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1794},
  {'1202 Normandy Dr', -663.707153320313, 742.346435546875, 174.284042358398, price = 648000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1795},
  {'1299 Normandy Dr', -746.8583984375, 808.448547363281, 215.028182983398, price = 500000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1796},
  {'1115 North Sheldon Ave', -824.193115234375, 806.679748535156, 202.784362792969, price = 495000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1797},
  {'1116 North Sheldon Ave', -867.609252929688, 785.365905761719, 191.93424987793, price = 522000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1798},
  {'1117 North Sheldon Ave', -912.51708984375, 777.704467773438, 187.012344360352, price = 585000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1799},
  {'1118 North Sheldon Ave', -931.718139648438, 808.074768066406, 184.780944824219, price = 600000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1800},
  {'1119 North Sheldon Ave', -962.611450195313, 812.953796386719, 177.566329956055, price = 575000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1801},
  {'1120 North Sheldon Ave', -998.912780761719, 816.300048828125, 173.049545288086, price = 585000, ipl="ipl4", item_max=120, weapon_max=4, maxCash=150000, id=1802},
  {'1121 North Sheldon Ave', -972.673034667969, 752.821228027344, 176.380844116211, price = 592000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1803},
  {'1122 North Sheldon Ave', -998.003662109375, 768.774291992188, 171.413009643555, price = 602000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1804},
  {'1123 North Sheldon Ave', -1067.53991699219, 794.992431640625, 166.915908813477, price = 620000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1805},
  {'1124 North Sheldon Ave', -1100.58239746094, 797.065979003906, 167.257797241211, price = 587000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1806},
  {'1125 North Sheldon Ave', -1130.20666503906, 784.06689453125, 163.887222290039, price = 450000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1807},
  {'1000 Hillcrest Ave', -1055.52160644531, 761.453918457031, 167.31787109375, price = 480000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1808},
  {'1126 North Sheldon Ave', -1118.21594238281, 762.396545410156, 164.288635253906, price = 560000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1809},
  {'1127 North Sheldon Ave', -1164.97583007813, 727.246337890625, 155.606735229492, price = 300000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1810},
  {'1128 North Sheldon Ave', -1197.24108886719, 693.626281738281, 147.420837402344, price = 325000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1811},
  {'1129 North Sheldon Ave', -1218.95739746094, 665.702026367188, 144.533401489258, price = 630000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1812},
  {'1130 North Sheldon Ave', -1248.49890136719, 643.290710449219, 142.680450439453, price = 725000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1813},
  {'1131 North Sheldon Ave', -1241.47131347656, 673.57568359375, 142.817718505859, price = 850000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1814},
  {'1132 North Sheldon Ave', -1291.1689453125, 649.634948730469, 141.501403808594, price = 935000, ipl="ipl1", item_max=120, weapon_max=4, maxCash=150000, id=1815},
  {'1133 North Sheldon Ave', -1277.92846679688, 629.478881835938, 143.178283691406, price = 875000, ipl="ipl4", item_max=120, weapon_max=4, maxCash=150000, id=1816},
  {'2831 Hangman Ave', -1338.0185546875, 605.866943359375, 134.379974365234, price = 780000, ipl="ipl1", item_max=120, weapon_max=4, maxCash=150000, id=1817},
  {'2832 Hangman Ave', -1366.94592285156, 610.8759765625, 133.899688720703, price = 810000, ipl="ipl1", item_max=120, weapon_max=4, maxCash=150000, id=1818},
  {'2833 Hangman Ave', -1363.65979003906, 570.051574707031, 134.972015380859, price = 790000, ipl="ipl1", item_max=120, weapon_max=4, maxCash=150000, id=1819},
  {'2834 Hangman Ave', -1346.66198730469, 561.017639160156, 130.531509399414, price = 900000, ipl="ipl1", item_max=120, weapon_max=4, maxCash=150000, id=1820},
  {'2835 Hangman Ave', -1404.95349121094, 561.482421875, 125.406204223633, price = 965000, ipl="ipl1", item_max=120, weapon_max=4, maxCash=150000, id=1821},
  {'2836 Hangman Ave', -1406.17407226563, 526.533874511719, 123.831275939941, price = 820000, ipl="ipl1", item_max=120, weapon_max=4, maxCash=150000, id=1822},
  {'1290 Ace Jones Dr', -1452.04174804688, 545.761291503906, 120.79931640625, price = 1700000, ipl="ipl1", item_max=120, weapon_max=4, maxCash=150000, id=1823},
  {'1291 Ace Jones Dr', -1500.32653808594, 522.981201171875, 118.272094726563, price = 910000, ipl="ipl1", item_max=120, weapon_max=4, maxCash=150000, id=1824},
  {'1292 Ace Jones Dr', -1454.14135742188, 512.920776367188, 117.634498596191, price = 1100000, ipl="ipl1", item_max=120, weapon_max=4, maxCash=150000, id=1825},
  {'1293 Ace Jones Dr', -1496.54577636719, 437.79296875, 112.497787475586, price = 955000, ipl="ipl1", item_max=120, weapon_max=4, maxCash=150000, id=1826},
  {'1294 Ace Jones Dr', -1540.21411132813, 421.615997314453, 110.013938903809, price = 915000, ipl="ipl1", item_max=120, weapon_max=4, maxCash=150000, id=1827},
  {'1295 Ace Jones Dr', -1805.02111816406, 437.063873291016, 128.707443237305, price = 3000000, ipl="ipl1", item_max=120, weapon_max=4, maxCash=150000, id=1828},
  {'1296 Ace Jones Dr', -1835.75830078125, 447.986419677734, 126.51441192627, price = 1800000, ipl="ipl1", item_max=120, weapon_max=4, maxCash=150000, id=1829},
  {'1015 North Rockford Dr', -1938.57250976563, 551.380798339844, 114.828544616699, price = 989000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1830},
  {'1016 North Rockford Dr', -1929.55834960938, 595.554748535156, 122.284828186035, price = 875000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1831},
  {'1017 North Rockford Dr', -1896.515625, 642.076599121094, 130.208938598633, price = 875000, ipl="ipl4", item_max=120, weapon_max=4, maxCash=150000, id=1832},
  {'2858 Hillcrest Ave', -1065.11535644531, 726.813293457031, 165.474594116211, price = 875000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1833},
  {'2859 Hillcrest Ave', -1002.69372558594, 684.767150878906, 160.904052734375, price = 880000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1834},
  {'2860 Hillcrest Ave', -1019.25842285156, 717.418212890625, 163.996353149414, price = 775000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1835},
  {'2861 Hillcrest Ave', -931.70068359375, 691.736999511719, 153.466583251953, price = 830000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1836},
  {'2862 Hillcrest Ave', -909.009765625, 694.122253417969, 151.434555053711, price = 825000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1837},
  {'2863 Hillcrest Ave', -885.768005371094, 699.369567871094, 151.270980834961, price = 810000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1838},
  {'2874 Hillcrest Ave', -853.02099609375, 696.144958496094, 148.786193847656, price = 850000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1839},
  {'2875 Hillcrest Ave', -819.998046875, 697.545837402344, 148.109878540039, price = 835000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1840},
  {'2876 Hillcrest Ave', -764.991333007813, 651.17138671875, 145.501342773438, price = 865000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1841},
  {'2877 Hillcrest Ave', -752.4912109375, 620.664855957031, 142.411651611328, price = 820000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1842},
  {'2878 Hillcrest Ave', -732.619812011719, 594.621032714844, 141.91569519043, price = 799000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1843},
  {'2864 Hillcrest Ave', -704.172119140625, 589.460815429688, 141.930541992188, price = 760000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1844},
  {'2865 Hillcrest Ave', -686.139953613281, 596.570007324219, 143.642196655273, price = 800000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1845},
  {'2866 Hillcrest Ave', -669.598022460938, 638.289428710938, 149.528854370117, price = 999000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1846},
  {'2867 Hillcrest Ave', -700.753356933594, 648.006530761719, 155.175430297852, price = 1200000, ipl="ipl2", item_max=120, weapon_max=4, maxCash=150000, id=1847},
  {'2114 Normandy Dr', -699.185363769531, 706.397521972656, 157.984573364258, price = 310000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1848},
  {'55 Hillcrest Ave', -662.369506835938, 679.14111328125, 153.910659790039, price = 999999, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1849},
  {'2115 Normandy Dr', -606.256591796875, 672.70654296875, 151.596878051758, price = 2500000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1850},
  {'2116 Normandy Dr', -564.101135253906, 683.8974609375, 146.20085144043, price = 850000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1851},
  {'2117 Normandy Dr', -559.411193847656, 664.599548339844, 145.455947875977, price = 200000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1852},
  {'1 Programmer Lane', -2587.819800000001, 1191.105700000001, 167.498900000001, price = 1200000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1853},
  {'1011 Vinewood Hills', -1944.137, 449.338, 102.702, price = 1000000, ipl="ipl3", item_max=120, weapon_max=4, maxCash=150000, id=1854}
}

locations.interiors = {
	{ "10 Car Garage Back Room", 223.193, -967.322, -99.000 },
	{ "10 Car Garage Bay", 228.135, -995.350, -99.000 },
	{ "Ammunation Gun Range", 22.153, -1072.854, 29.797 },
	{ "Ammunation Office", 12.494, -1110.130, 29.797 },
	{ "Bahama Mamas West", -1387.08, -588.4, 30.3195 },
	{ "Blaine County Savings Bank", -109.299, 6464.035, 31.627 },
	{ "Clucking Bell Farms Warehouse", -70.0624, 6263.53, 31.0909, { "CS1_02_cf_onmission1", "CS1_02_cf_onmission2", "CS1_02_cf_onmission3", "CS1_02_cf_onmission4" }, { "CS1_02_cf_offmission" }, false },
	{ "Control Office", 1080.97, -1976.0, 31.4721 },
	{ "Devin's Garage", 482.027, -1317.96, 29.2021 },
	{ "Eclipse Apartment 5", -762.762, 322.634, 175.401 },
	{ "Eclipse Apartment 9", -790.673, 334.468, 158.599 },
	{ "Eclipse Apartment 31", -762.762, 322.634, 221.855 },
	{ "Eclipse Apartment 40", -790.673, 334.468, 206.218 },
	{ "FIB Building Burnt", 159.553, -738.851, 246.152 },
	{ "FIB Building Floor 47", 134.573, -766.486, 234.152 },
	{ "FIB Building Floor 49", 134.635, -765.831, 242.152 },
	{ "FIB Building Lobby", 110.4, -744.2, 45.7,  { "FIBlobby" }, { "FIBlobbyfake" } },
	{ "FIB Building Top Floor", 135.733, -749.216, 258.152 },
	{ "Garment Factory", 717.397, -965.572, 30.3955 },
	{ "Hospital (Destroyed)", 302.651, -586.293, 43.3129, { "RC12B_Destroyed", "RC12B_HospitalInterior" }, { "RC12B_Default", "RC12B_Fixed" }, false },
	{ "Humane Labs Lower Level", 3525.495, 3705.301, 20.992 },
	{ "Humane Labs Upper Level", 3618.52, 3755.76, 28.6901 },
	{ "IAA Office", 117.220, -620.938, 206.047 },
	{ "Ice Planet Jewelery", 243.516, 364.099, 105.738 },
	{ "Janitor's Apartment", -110.721, -8.22095, 70.5197 },
	{ "Jewel Store", -630.07, -236.332, 38.0571, { "post_hiest_unload" }, { "jewel2ake", "bh1_16_refurb" }, false },
	{ "Lester's House", 1273.898, -1719.304, 54.771 },
	{ "Life Invader Office", -1049.13, -231.779, 39.0144,  { "facelobby" }, { "facelobbyfake" }, false },
	{ "Maze Bank Arena", -254.918, -2019.75, 30.1456 },
	{ "Morgue", 275.446, -1361.11, 24.5378,  { "Coroner_Int_on" }, {}, false },
	{ "O'Neil Farm", 2454.78, 4971.92, 46.8103,  { "farm", "farm_props", "farmint" }, { "farm_burnt", "farm_burnt_props", "farmint_cap" }, false },
	{ "Pacific Standard Bank Vault", 255.851, 217.030, 101.683 },
	{ "Paleto Bay Sheriff", -446.135, 6012.91, 31.7164 },
	{ "Raven Slaughterhouse", 967.357, -2184.71, 30.0613 },
	{ "Rogers Salvage & Scrap", -609.962, -1612.49, 27.0105 },
	{ "Sandy Shores Sheriff", 1853.18, 3686.63, 34.2671 },
	{ "Simeon's Dealership", -56.4951, -1095.8, 26.4224 },
	{ "Split Sides West Comedy Club", -564.261, 278.232, 83.1364 },
	{ "Strip Club DJ Booth", 126.135, -1278.583, 29.270 },
	{ "Torture Warehouse", 136.514, -2203.15, 7.30914 },
	{ "Doss Mc", 998.4809, -3164.711, -38.90733 },
	{ "Counterfeit cash", 1121.897, -3195.338, -40.4025 },
	{ "Document forge", 1163.842,-3195.7,-39.008 },
	{ "Meth Lab", 1009.5, -3196.6, -38.99682 },
	{ "Import Export", 994.5925, -3002.594, -39.64699 },
	{ "garage idea", 795.75439453125, -2997.3317871094, -22.960731506348 },
}


local IPLS = {}
IPLS.carrier = {
	"hei_carrier",
	"hei_carrier_DistantLights",
	"hei_Carrier_int1",
	"hei_Carrier_int2",
	"hei_Carrier_int3",
	"hei_Carrier_int4",
	"hei_Carrier_int5",
	"hei_Carrier_int6",
	"hei_carrier_LODLights"
}

IPLS.heistyacht = {
	"hei_yacht_heist",
	"hei_yacht_heist_Bar",
	"hei_yacht_heist_Bedrm",
	"hei_yacht_heist_Bridge",
	"hei_yacht_heist_DistantLights",
	"hei_yacht_heist_enginrm",
	"hei_yacht_heist_LODLights",
	"hei_yacht_heist_Lounge"
}

IPLS.north_yankton = {
	"plg_01",
	"prologue01",
	"prologue01_lod",
	"prologue01c",
	"prologue01c_lod",
	"prologue01d",
	"prologue01d_lod",
	"prologue01e",
	"prologue01e_lod",
	"prologue01",
	"prologue01_lod",
	"prologue01g",
	"prologue01h",
	"prologue01h_lod",
	"prologue01i",
	"prologue01i_lod",
	"prologue01j",
	"prologue01j_lod",
	"prologue01k",
	"prologue01k_lod",
	"prologue01z",
	"prologue01z_lod",
	"plg_02",
	"prologue02",
	"prologue02_lod",
	"plg_03",
	"prologue03",
	"prologue03_lod",
	"prologue03b",
	"prologue03b_lod",
	-- the commented code disables the 'Prologue' grave and
	-- enables the 'Bury the Hatchet' grave
	--"prologue03_grv_cov",
	--"prologue03_grv_cov_lod",
	"prologue03_grv_dug",
	"prologue03_grv_dug_lod",
	--"prologue03_grv_fun",
	"prologue_grv_torch",
	"plg_04",
	"prologue04",
	"prologue04_lod",
	"prologue04b",
	"prologue04b_lod",
	"prologue04_cover",
	"des_protree_end",
	"des_protree_start",
	"des_protree_start_lod",
	"plg_05",
	"prologue05",
	"prologue05_lod",
	"prologue05b",
	"prologue05b_lod",
	"plg_06",
	"prologue06",
	"prologue06_lod",
	"prologue06b",
	"prologue06b_lod",
	"prologue06_int",
	"prologue06_int_lod",
	"prologue06_pannel",
	"prologue06_pannel_lod",
	--"prologue_m2_door",
	--"prologue_m2_door_lod",
	"plg_occl_00",
	"prologue_occl",
	"plg_rd",
	"prologuerd",
	"prologuerdb",
	"prologuerd_lod"
}


locations.reqscen = {
	{ "Carrier", 3069.330, -4632.4, 15.043 },
	{ "Fort Zancudo UFO", -2052.000, 3237.000, 1456.973, { "ufo", "ufo_lod", "ufo_eye" }, {}, false },
	--{ "Heist Yacht", -2043.974, -1031.582, 11.981, IPLS.heistyacht, {}, false },
	{ "North Yankton", 3360.19, -4849.67, 111.8, IPLS.north_yankton, {}, false },
	{ "North Yankton Bank", 5309.519, -5212.375, 83.522, IPLS.north_yankton, {}, false },
	{ "SS Bulker (Intact)", -163.749, -2377.94, 9.3192, { "cargoship" }, { "sunkcargoship" }, false },
	{ "SS Bulker (Sunk)", -162.8918, -2365.769, 0.0, { "sunkcargoship" }, { "cargoship" }, false },
	{ "Train Crash Bridge", -532.1309, 4526.187, 88.7955, { "canyonriver01_traincrash", "railing_end" }, { "railing_start", "canyonriver01" }, false },
	{ "Yacht", -2023.661, -1038.038, 5.577 },
}

locations.broken = {
	{ "Carrier", 3069.330, -4704.220, 15.043, IPLS.carrier, {}, false },
	{ "Director Mod Trailer", -20.004, -10.889, 500.602 },
}


locations.categories = {
	["Safehouses"] = locations.safeHouses,
	["Landmarks"] = locations.landmarks,
	["Roof/High Up"] = locations.high,
	["Underwater"] = locations.underwater, 
	["Interiors"] = locations.interiors, 
	["Extra Exterior Scenery"] = locations.reqscen,
	["Houses"] = locations.houses
}


--[[------------------------------------------------------------------------
	Teleport to location 
------------------------------------------------------------------------]]--

locations.current = nil -- Holds the current location 
locations.old = nil     -- Holds the old location

function teleportToLocation(category,index)
	locations.old = locations.current
	local destination = locations.categories[category][index]

	-- Get Entity to Teleport
	local targetPed = GetPlayerPed(-1)
	if(IsPedInAnyVehicle(targetPed))then
		targetPed = GetVehiclePedIsUsing(targetPed)
	end

	-- If it has a 5th option then it requires locations.
	if(destination[5])then
		local required = destination[5]
		local removeThese = destination[6]
		local isLoaded = destination[7]

		if(not isLoaded)then
			-- Load the IPL before teleporting them.
			drawNotification("Loading scenery...")

			-- Remove requested IPLs
			if(getTableLength(removeThese) > 0)then
				for index,value in ipairs(removeThese)do
					if(IsIplActive(value))then
						RemoveIpl(value)
					end
				end
			end

			-- Add Required IPLs
			if(getTableLength(required) > 0)then
				for index,value in ipairs(required)do
					if(IsIplActive(value) == false)then
						RequestIpl(value)
					end
				end
			end
			drawNotification("Scenery Loaded!")
			destination.isLoaded = true
		end
	end

	SetEntityCoordsNoOffset( targetPed, destination[2], destination[3], destination[4], false, false, true )



	--local coords = {}
	--coords.x = destination[2]
	--coords.y = destination[3]
	--coords.z = destination[4]

	-- TeleportToCoords(targetPed, coords)

	if(locations.old ~= nil)then
		if(locations.old[6] ~= nil)then
			drawNotification("Unloading old scenery...")
			local removeList = locations.old[6]
			local keepList = {}
			-- Don't remove needed IPLs
			if(destination[5])then
				keepList = tableSet(destination[5])
			end
			if(getTableLength(removeList) > 0)then
				for index,value in ipairs(removeList)do
					if(keepList[value] == nil and IsIplActive(value))then
						RemoveIpl(value)
					end
				end
			end
			locations.old[7] = false
			drawNotification("Scenery Unloaded")
		end
	end

	locations.current = destination
end


function createLocationJSON()
	local jsonList = {}
	local count = 0
	for key,value in pairs(locations.categories) do
		local options = {}
		-- Create the submenu for all locations under each category.
		for index,currentObj in pairs(value)do
			local curOpt = {
				["menuName"] = currentObj[1],
				["data"] = {
					["action"] = "locationteleport "..tostring(index).." "..key -- Key may contain spaces so add to end
				}
			}
			table.insert(options,curOpt)
		end

		table.insert(jsonList, {
			["menuName"] = key,
			["data"] = {
				["sub"] = count
			},
			["submenu"] = options
		})
		count = count + 1
	end

	local customJSON = "{}"

    if ( getTableLength( jsonList ) > 0 ) then
        customJSON = json.encode( jsonList, { indent = true } )
    end
 
    SendNUIMessage( {
        createmenu = true,
        menuName = "createlocationsmenu",
        menudata = customJSON
    })
end

RegisterNUICallback("createlocationsmenu", function()
	createLocationJSON()
end)



RegisterNUICallback("locationteleport", function( data, cb )
	local index = tonumber(data.data[2])
	local category = table.concat(data.data, " ", 3)

	teleportToLocation(category, index)

	if(cb)then cb("ok")end
end)