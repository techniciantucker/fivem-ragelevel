local undergroundInterior = false
local insideInterior = false
local time = {h = 12, m = 0}

RegisterNetEvent('sync:updateTime')
AddEventHandler('sync:updateTime', function(hour, min)
 if not undergroundInterior then
  time.h = hour
  time.m = min
  if hour and min then
   NetworkOverrideClockTime(hour, min, 0)
  end
 else
  NetworkOverrideClockTime(23, 0, 0)
  ClearOverrideWeather()
  ClearWeatherTypePersist()
  SetWeatherTypePersist('EXTRASUNNY')
  SetWeatherTypeNow('EXTRASUNNY')
  SetWeatherTypeNowPersist('EXTRASUNNY')
 end
end)

Citizen.CreateThread(function()
 TriggerServerEvent('sync:requestSync')
 while true do
  Citizen.Wait(0)
  if undergroundInterior then
   SetTrafficDensity(0.0, 0.0)
   SetPedDensity(0.0)
  else
   if isNight() then
    SetTrafficDensity(0.25, 55.0)
    SetPedDensity(0.20)
   else
    SetTrafficDensity(0.55, 0.25)
    SetPedDensity(0.65)
   end
  end
 end
end)

function SetTrafficDensity(density, parked)
 SetParkedVehicleDensityMultiplierThisFrame(parked)
 SetVehicleDensityMultiplierThisFrame(density)
 SetRandomVehicleDensityMultiplierThisFrame(density)
end

function SetPedDensity(density)
 SetPedDensityMultiplierThisFrame(density)
 SetScenarioPedDensityMultiplierThisFrame(density, density)
end

function isNight()
 local hour = GetClockHours()
 if hour > 20 or hour < 5 then
  return true
 end
end

function isDay()
 local hour = GetClockHours()
 if hour > 5 and hour < 20 then
  return true
 end
end


-- Weather Shit
local newWeather = 'CLEAR'
local todaysForecast = {}

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(50)
  if not insideInterior then
   ClearOverrideWeather()
   ClearWeatherTypePersist()
   SetWeatherTypePersist(newWeather)
   SetWeatherTypeNow(newWeather)
   SetWeatherTypeNowPersist(newWeather)
  else
   ClearOverrideWeather()
   ClearWeatherTypePersist()
   SetWeatherTypePersist('CLEAR')
   SetWeatherTypeNow('CLEAR')
   SetWeatherTypeNowPersist('CLEAR')
  end
 end
end)

RegisterNetEvent('sync:updateWeather')
AddEventHandler('sync:updateWeather', function(newWhther, todaysForecast)
 local phoneApp = ''

 SetWeatherTypeOverTime(newWhther, 15.0)
 Wait(15000)
 newWeather = newWhther
 todaysForecast = todaysForecast
 for i=1, #todaysForecast do
  if i == 1 then
   phoneApp = phoneApp..'<div class="currentWeather"><h5>'..getDate(i)..'<font style="float: right; padding-right: 10px;">25° - '..getWeatherIcon(todaysForecast[i])..'</font></h5></div>'
  else
   phoneApp = phoneApp..'<div class="nextWeather"><h5>'..getDate(i)..'<font style="float: right; padding-right: 10px;">25° - '..getWeatherIcon(todaysForecast[i])..'</font></h5></div>'
  end
 end
 TriggerEvent('phone:weatherApp', phoneApp, 25)
end)

function getDate(i)
 local month = GetClockMonth()
 local dayOfMonth = GetClockDayOfMonth()+i-1

  if month == 0 then
    month = "January"
  elseif month == 1 then
    month = "February"
  elseif month == 2 then
    month = "March"
  elseif month == 3 then
    month = "April"
  elseif month == 4 then
    month = "May"
  elseif month == 5 then
    month = "June"
  elseif month == 6 then
    month = "July"
  elseif month == 7 then
    month = "August"
  elseif month == 8 then
    month = "September"
  elseif month == 9 then
    month = "October"
  elseif month == 10 then
    month = "November"
  elseif month == 11 then
    month = "December"
  end

 return dayOfMonth.."th "..month
end

MonthData = {
 {36, 20}, -- January
 {41, 24}, -- February
 {53, 34}, -- March
 {65, 43}, -- April
 {75, 54}, -- May
 {82, 61}, -- June
 {86, 66}, -- July
 {85, 64}, -- August
 {78, 58}, -- September
 {66, 46}, -- October
 {53, 37}, -- November
 {43, 28}, -- December
}
-- Customizable Variables
local MAX_INCREASE = 1.5
local MIN_INCREASE = 0.2
local RAND_FLUC = 0.2
local START_INCREASE_HR = 4
local STOP_INCREASE_HR = 16

function calcTemp(month, weather)
 local Max = MonthData[month][1]
 local Min = MonthData[month][2]
 local AbsMax
 local AbsMin
 local curTemp

 if weather == 'SNOW' or weather == 'BLIZZARD' or weather == 'SNOWLIGHT' or weather == 'XMAS' then
  AbsMax = 32 -- Using just below 32 since the temp will fluctuate by about 5
  AbsMin = -20
 elseif weather == 'EXTRASUNNY' then
  AbsMax = Max + 20
  AbsMin = Min + 20
 elseif weather == 'SMOG' then
  AbsMax = Max + 10
  AbsMin = Min + 10
 elseif weather == 'FOGGY' or weather == 'CLOUDS' or weather == 'THUNDER' or weather == 'HALLOWEEN' then
  AbsMax = Max - 10
  AbsMin = Min - 10
 else
  AbsMax = Max
  AbsMin = Min
 end
 curTemp = randf(AbsMin, AbsMax)
 if curTemp <= AbsMin then
  curTemp = AbsMin + randf(-RAND_FLUC, RAND_FLUC)
 else
  curTemp = curTemp - randf(MIN_INCREASE, MAX_INCREASE)
 end
 return curTemp
end

function randf(low, high)
 math.randomseed(GetClockDayOfMonth() + GetClockYear() + GetClockMonth() + GetClockHours())
 return low   + math.random()  * (high - low);
end

function FtoC( f )
 return ((f - 32) * (5 / 9))
end

function getWeatherIcon(weather)
 if weather == "CLEAR" then
  return '<i class="fa fa-sun"></i>'
 elseif weather == "EXTRASUNNY" then
  return '<i class="fa fa-sun"></i>'
 elseif weather == "CLOUDS" then
  return '<i class="fa fa-cloud"></i>'
 elseif weather == "OVERCAST" then
  return '<i class="fa fa-cloud-sun"></i>'
 elseif weather == "RAIN" then
  return '<i class="fa fa-cloud-rain"></i>'
 elseif weather == "CLEARING" then
  return '<i class="fa fa-cloud-sun-rain"></i>'
 elseif weather == "THUNDER" then
  return '<i class="fa fa-bolt"></i>'
 elseif weather == "SMOG" then
  return '<i class="fa fa-cloud-moon"></i>'
 elseif weather == "FOGGY" then
  return '<i class="fa fa-cloud-moon"></i>'
 end
end

-- Interior Checker
Citizen.CreateThread(function()
 while true do
  Citizen.Wait(250)
  local playerCoords = GetEntityCoords(PlayerPedId(), true)
  if playerCoords['z'] < -10 and not IsEntityInWater(PlayerPedId()) then
   undergroundInterior = true
  else
   if undergroundInterior then
    NetworkOverrideClockTime(tonumber(time.h), tonumber(time.m), 0)
   end
   undergroundInterior = false
   Citizen.Wait(250)
  end

  if insideInterior then
   ClearOverrideWeather()
   ClearWeatherTypePersist()
   SetWeatherTypePersist('CLEAR')
   SetWeatherTypeNow('CLEAR')
   SetWeatherTypeNowPersist('CLEAR')
  end
 end
end)



AddEventHandler('sync:insideInterior', function(status)
 insideInterior = status
end)
