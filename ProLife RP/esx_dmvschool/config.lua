Config                 = {}
Config.DrawDistance    = 100.0
Config.MaxErrors       = 5
Config.SpeedMultiplier = 3.6

Config.Prices = {
  dmv         = 200,
  drive       = 500,
  drive_bike  = 500,
  drive_truck = 500
}

Config.VehicleModels = {
  drive       = 'blista',
  drive_bike  = 'sanchez',
  drive_truck = 'mule3'
}

Config.SpeedLimits = {
  residence = 50,
  town      = 80,
  freeway   = 120
}

Config.Zones = {

  DMVSchool = {
    Pos   = {x = -129.76, y = 6550.96, z = 28.52},
    Size  = {x = 1.5, y = 1.5, z = 1.0},
    Color = {r = 204, g = 204, b = 0},
    Type  = 1
  },

  VehicleSpawnPoint = {
    Pos   = {x = -112.52, y = 6568.04, z = 29.52},
    Size  = {x = 1.5, y = 1.5, z = 1.0},
    Color = {r = 204, g = 204, b = 0},
    Type  = -1
  },

}

Config.CheckPoints = {
  {
    Pos = {x = -108.52, y = 6566.8, z = 28.48},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      Citizen.CreateThread(function()
        setCurrentZoneType('town')
          DrawMissionText('Haz un ~r~stop~s~ antes de salir~y~ y gira a la izquierda. Limite de velocidad : ~y~' .. Config.SpeedLimits['town'] .. 'km/h', 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
        FreezeEntityPosition(vehicle, true)
        Citizen.Wait(4000)
        FreezeEntityPosition(vehicle, false)
        DrawMissionText('~g~Bien!~s~ Continua!', 5000)
      end)
    end
  },
    {
    Pos = {x = 58.52, y = 6620.16, z = 30.6},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      Citizen.CreateThread(function()
          DrawMissionText('Haz un ~r~stop~s~, ~y~ gira a la derecha.', 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
        FreezeEntityPosition(vehicle, true)
        Citizen.Wait(4000)
        FreezeEntityPosition(vehicle, false)
        DrawMissionText('~g~Bien!~s~ Continua!', 5000)
      end)
    end
  },
  {
    Pos = {x = -164.48, y = 6374.12, z = 30.44},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      Citizen.CreateThread(function()
        DrawMissionText('Haz un ~r~stop~s~, ~y~ gira a la izquierda', 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
        FreezeEntityPosition(vehicle, true)
        Citizen.Wait(4000)
        FreezeEntityPosition(vehicle, false)
        DrawMissionText('~g~Bien!~s~ Continua!', 5000)
      end)
    end
  },
  {
    Pos = {x = -109.28, y = 6290.44, z = 30.2},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      Citizen.CreateThread(function()
        DrawMissionText('Haz un ~r~stop~s~, ~y~ gira a la derecha', 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
        FreezeEntityPosition(vehicle, true)
        Citizen.Wait(4000)
        FreezeEntityPosition(vehicle, false)
        DrawMissionText('~g~Bien!~s~ Continua!', 5000)
      end)
    end
  },
  {
    Pos = {x = -152.8, y = 6233.4, z = 30.2},
    Action = function(playerPed, vehicle, setCurrentZoneType)
        setCurrentZoneType('freeway')
      DrawMissionText('Siga adelante hasta el carril que se le indicará. ~y~ Limite de velocidad : ~y~' .. Config.SpeedLimits['freeway'] .. 'km/h', 5000)
    end
  },

  {
    Pos = {x = -533.60, y = 5788.68, z = 34.4},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText('Reduce la velocidad para meterte al carril de la izquierda.', 5000)
    end
  },
  {
    Pos = {x = -566.72, y = 5712.6, z = 36.28},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText('Metete a el carril de la derecha.', 5000)
    end
  },
  {
    Pos = {x = -658.12, y = 5928.92, z = 15.08},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      Citizen.CreateThread(function()
        DrawMissionText('Haz un ~r~stop~s~, ~y~ gira a la derecha', 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
        FreezeEntityPosition(vehicle, true)
        Citizen.Wait(4000)
        FreezeEntityPosition(vehicle, false)
        DrawMissionText('~g~Bien!~s~ Continua!', 5000)
      end)
    end
  },
  {
    Pos = {x = -617.76, y = 6077.8, z = 7.16},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      setCurrentZoneType('town')
      DrawMissionText('Gire a la derecha y suba el carril. Limite de velocidad : ~y~' .. Config.SpeedLimits['town'] .. 'km/h', 5000)
    end
  },
  {
    Pos = {x = -444.72, y = 6071.96, z = 30.4},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      Citizen.CreateThread(function()
        DrawMissionText('Haz un ~r~stop~s~, ~y~ gira a la izquierda', 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
        FreezeEntityPosition(vehicle, true)
        Citizen.Wait(4000)
        FreezeEntityPosition(vehicle, false)
        DrawMissionText('~g~Bien!~s~ Continua!', 5000)
      end)
    end
  },
  {
    Pos = {x = -396.56, y = 6135.28, z = 30.56},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      Citizen.CreateThread(function()
        DrawMissionText('Haz un ~r~stop~s~, ~y~ gira a la izquierda', 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
        FreezeEntityPosition(vehicle, true)
        Citizen.Wait(4000)
        FreezeEntityPosition(vehicle, false)
        DrawMissionText('~g~Bien!~s~ Continua!', 5000)
      end)
    end
  },
  {
    Pos = {x = -409.52, y = 6217.28, z = 30.48},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText('Siga al último punto.', 5000)
    end
  },
  {
    Pos = {x = -105.0, y = 6556.6, z = 28.52},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      Citizen.CreateThread(function()
        DrawMissionText('Haz un ~r~stop~s~, ~y~ gira a la izquierda', 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
        FreezeEntityPosition(vehicle, true)
        Citizen.Wait(4000)
        FreezeEntityPosition(vehicle, false)
        DrawMissionText('~g~Bien!~s~ Continua!', 5000)
      end)
    end
  },
  {
    Pos = {x = -115.32, y = 6568.32, z = 28.52},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText('¡Enhorabuena, manténgase alerta!', 5000)
      PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
    end
  },

  {
    Pos = {x = -115.32, y = 6568.32, z = 28.52},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      ESX.Game.DeleteVehicle(vehicle)
    end
  },
  
}