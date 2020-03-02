---------------------------------------------------------------------------
-- Notification compatible with icons shown from URL
---------------------------------------------------------------------------
RegisterNetEvent("clrp_ms:CustomURLIcon")
AddEventHandler("clrp_ms:CustomURLIcon", function(title, body, time, url, showBar, pos)
    SendNUIMessage({
        type = "notification_customurlicon",
        title = title,
        body = body,
        time = time,
        url = url,
        showBar = showBar,
        pos = pos
    })
end)
---------------------------------------------------------------------------
-- Notification compatible with icons shown from local images
---------------------------------------------------------------------------
RegisterNetEvent("clrp_ms:CustomIcon")
AddEventHandler("clrp_ms:CustomIcon", function(title, body, time, iconFile, showBar, pos)
    SendNUIMessage({
        type = "notification_customicon",
        title = title,
        body = body,
        time = time,
        iconFile = iconFile,
        showBar = showBar,
        pos = pos
    })
end)
---------------------------------------------------------------------------
-- Success Notification
---------------------------------------------------------------------------
RegisterNetEvent("clrp_ms:Success")
AddEventHandler("clrp_ms:Success", function(title, body, time, showBar, pos)
    SendNUIMessage({
        type = "notification_success",
        title = title,
        body = body,
        time = time,
        showBar = showBar,
        pos = pos
    })
end)
---------------------------------------------------------------------------
-- Error Notification
---------------------------------------------------------------------------
RegisterNetEvent("clrp_ms:Error")
AddEventHandler("clrp_ms:Error", function(title, body, time, showBar, pos)
    SendNUIMessage({
        type = "notification_error",
        title = title,
        body = body,
        time = time,
        showBar = showBar,
        pos = pos
    })
end)
---------------------------------------------------------------------------
-- Warning Notification
---------------------------------------------------------------------------
RegisterNetEvent("clrp_ms:Warning")
AddEventHandler("clrp_ms:Warning", function(title, body, time, showBar, pos)
    SendNUIMessage({
        type = "notification_warning",
        title = title,
        body = body,
        time = time,
        showBar = showBar,
        pos = pos
    })
end)
---------------------------------------------------------------------------
-- Info Notification
---------------------------------------------------------------------------
RegisterNetEvent("clrp_ms:Info")
AddEventHandler("clrp_ms:Info", function(title, body, time, showBar, pos)
    SendNUIMessage({
        type = "notification_info",
        title = title,
        body = body,
        time = time,
        showBar = showBar,
        pos = pos
    })
end)