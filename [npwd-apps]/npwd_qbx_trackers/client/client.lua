lib.locale()

RegisterNUICallback('npwd:qbx_trackers:list', function(_, cb)
    local list = lib.callback.await('qbx_vehicle_tracker:server:list', false)
    cb({ status = list and 'ok' or 'error', data = list or {} })
end)

RegisterNUICallback('npwd:qbx_trackers:requestWaypoint', function(data, cb)
    local plate = data and data.plate
    local coords = lib.callback.await('qbx_vehicle_tracker:server:getTrackedVehiclePosition', false, plate)
    if coords then
        SetNewWaypoint(coords.x, coords.y)
        exports.npwd:createNotification({
            notisId = 'npwd:qbx_trackers:requestWaypoint',
            appId = 'npwd_qbx_trackers',
            content = locale('marked'),
            keepOpen = false,
            duration = 5000,
            path = '/npwd_qbx_trackers',
        })
        cb({ status = 'ok' })
    else
        exports.npwd:createNotification({
            notisId = 'npwd:qbx_trackers:requestWaypoint',
            appId = 'npwd_qbx_trackers',
            content = locale('cannot_locate'),
            keepOpen = false,
            duration = 5000,
            path = '/npwd_qbx_trackers',
        })
        cb({ status = 'error' })
    end
end)

