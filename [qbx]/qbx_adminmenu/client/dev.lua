local showCoords = false
local vehicleDev = false
local showPropInfo = false
local vehicleTypes = {'Compacts', 'Sedans', 'SUVs', 'Coupes', 'Muscle', 'Sports Classics', 'Sports', 'Super', 'Motorcycles', 'Off-road', 'Industrial', 'Utility', 'Vans', 'Cycles', 'Boats', 'Helicopters', 'Planes', 'Service', 'Emergency', 'Military', 'Commercial', 'Trains', 'Open Wheel'}
local propsRadius = 12.5
local propsMaxResults = 5
local propsUpdateInterval = 400
local propsCopyRange = 2.0

local function getNearbyProps()
    local pedCoords = GetEntityCoords(cache.ped)
    local objects = GetGamePool('CObject')
    local nearby = {}

    for _, entity in ipairs(objects) do
        if DoesEntityExist(entity) then
            local coords = GetEntityCoords(entity)
            local distance = #(pedCoords - coords)

            if distance <= propsRadius then
                local rotation = GetEntityRotation(entity, 2)
                local heading = GetEntityHeading(entity)
                local hash = GetEntityModel(entity)
                local modelName = GetEntityArchetypeName(entity)

                nearby[#nearby + 1] = {
                    coords = coords,
                    rotation = rotation,
                    heading = heading,
                    distance = qbx.math.round(distance, 2),
                    hash = ('0x%X'):format(hash),
                    netId = NetworkGetEntityIsNetworked(entity) and NetworkGetNetworkIdFromEntity(entity) or false,
                    frozen = IsEntityPositionFrozen(entity),
                    visible = IsEntityVisible(entity),
                    model = modelName and modelName ~= '' and modelName or locale('dev_options.props_unknown')
                }
            end
        end
    end

    table.sort(nearby, function(a, b)
        return a.distance < b.distance
    end)

    if #nearby > propsMaxResults then
        for index = propsMaxResults + 1, #nearby do
            nearby[index] = nil
        end
    end

    return nearby
end

local function drawPropInfo(data)
    local nearestForCopy

    if #data == 0 then
        local pedCoords = GetEntityCoords(cache.ped)

        qbx.drawText3d({
            text = locale('dev_options.props_none'),
            coords = vec3(pedCoords.x, pedCoords.y, pedCoords.z + 1.0),
            scale = 0.35,
            font = 6,
            enableOutline = true,
            disableDrawRect = true
        })

        return
    end

    local lineSpacing = 0.12

    for index = 1, #data do
        local info = data[index]
        local coords = info.coords
        local rotation = info.rotation
        local networkLabel = info.netId and tostring(info.netId) or locale('dev_options.props_local')
        local frozenLabel = info.frozen and locale('dev_options.props_true') or locale('dev_options.props_false')
        local visibleLabel = info.visible and locale('dev_options.props_true') or locale('dev_options.props_false')
        local isWithinCopyRange = info.distance <= propsCopyRange

        if isWithinCopyRange and (not nearestForCopy or info.distance < nearestForCopy.distance) then
            nearestForCopy = info
        end

        local lines = {
            ('~o~[%s]~w~ %s'):format(index, info.model),
            ('~o~%s:~w~ %s | ~o~%s:~w~ %s m'):format(locale('dev_options.props_hash'), info.hash, locale('dev_options.props_distance'), info.distance),
            ('~o~xyz:~w~ %s, %s, %s'):format(
                qbx.math.round(coords.x, 2),
                qbx.math.round(coords.y, 2),
                qbx.math.round(coords.z, 2)
            ),
            ('~o~rot:~w~ %s, %s, %s | ~o~%s:~w~ %s'):format(
                qbx.math.round(rotation.x, 1),
                qbx.math.round(rotation.y, 1),
                qbx.math.round(rotation.z, 1),
                locale('dev_options.props_heading'),
                qbx.math.round(info.heading, 1)
            ),
            ('~o~%s:~w~ %s | ~o~%s:~w~ %s | ~o~%s:~w~ %s'):format(
                locale('dev_options.props_network'),
                networkLabel,
                locale('dev_options.props_frozen'),
                frozenLabel,
                locale('dev_options.props_visible'),
                visibleLabel
            )
        }

        lines[#lines + 1] = ('~g~[E]~w~ %s'):format(locale('dev_options.props_copy_prompt'))

        local baseZ = coords.z + 1.3 + lineSpacing * (#lines - 1)

        for lineIndex = 1, #lines do
            qbx.drawText3d({
                text = lines[lineIndex],
                coords = vec3(coords.x, coords.y, baseZ - (lineIndex - 1) * lineSpacing),
                scale = 0.32,
                font = 6,
                enableOutline = true,
                disableDrawRect = true
            })
        end
    end

    if nearestForCopy and IsControlJustReleased(0, 38) then
        local coords = nearestForCopy.coords
        local rotation = nearestForCopy.rotation
        local clipboardValue = (
            '%s | hash=%s | coords=vec3(%s, %s, %s) | rotation=vec3(%s, %s, %s) | heading=%s | distance=%s | netId=%s | frozen=%s | visible=%s'
        ):format(
            nearestForCopy.model,
            nearestForCopy.hash,
            qbx.math.round(coords.x, 2),
            qbx.math.round(coords.y, 2),
            qbx.math.round(coords.z, 2),
            qbx.math.round(rotation.x, 1),
            qbx.math.round(rotation.y, 1),
            qbx.math.round(rotation.z, 1),
            qbx.math.round(nearestForCopy.heading, 1),
            qbx.math.round(nearestForCopy.distance, 2),
            nearestForCopy.netId or 'local',
            nearestForCopy.frozen and 'true' or 'false',
            nearestForCopy.visible and 'true' or 'false'
        )

        lib.setClipboard(clipboardValue)
        exports.qbx_core:Notify(locale('success.prop_info_copied'), 'success')
    end
end

local options = {
    function() CopyToClipboard('coords2') lib.showMenu('qbx_adminmenu_dev_menu', MenuIndexes.qbx_adminmenu_dev_menu) end,
    function() CopyToClipboard('coords3') lib.showMenu('qbx_adminmenu_dev_menu', MenuIndexes.qbx_adminmenu_dev_menu) end,
    function() CopyToClipboard('coords4') lib.showMenu('qbx_adminmenu_dev_menu', MenuIndexes.qbx_adminmenu_dev_menu) end,
    function() CopyToClipboard('heading') lib.showMenu('qbx_adminmenu_dev_menu', MenuIndexes.qbx_adminmenu_dev_menu) end,
    function()
        showCoords = not showCoords
        while showCoords do
            local coords, heading = GetEntityCoords(cache.ped), GetEntityHeading(cache.ped)

            qbx.drawText2d({
                text = ('~o~vector4~w~(%s, %s, %s, %s)'):format(qbx.math.round(coords.x, 2), qbx.math.round(coords.y, 2), qbx.math.round(coords.z, 2), qbx.math.round(heading, 2)),
                coords = vec2(1.0, 0.5),
                scale = 0.5,
                font = 6
            })

            Wait(0)
        end
    end,
    function()
        vehicleDev = not vehicleDev
        while vehicleDev do
            if cache.vehicle then
                local clutch, gear, rpm, temperature = GetVehicleClutch(cache.vehicle), GetVehicleCurrentGear(cache.vehicle), GetVehicleCurrentRpm(cache.vehicle), GetVehicleEngineTemperature(cache.vehicle)
                local oil, angle, body, class = GetVehicleOilLevel(cache.vehicle), GetVehicleSteeringAngle(cache.vehicle), GetVehicleBodyHealth(cache.vehicle), vehicleTypes[GetVehicleClass(cache.vehicle)]
                local dirt, maxSpeed, netId, hash = GetVehicleDirtLevel(cache.vehicle), GetVehicleEstimatedMaxSpeed(cache.vehicle), VehToNet(cache.vehicle), GetEntityModel(cache.vehicle)
                local name = GetLabelText(GetDisplayNameFromVehicleModel(hash))
                qbx.drawText2d({
                    text = ('~o~Clutch: ~w~ %s | ~o~Gear: ~w~ %s | ~o~Rpm: ~w~ %s | ~o~Temperature: ~w~ %s'):format(qbx.math.round(clutch, 4), gear, qbx.math.round(rpm, 4), temperature),
                    coords = vec2(1.0, 0.575),
                    scale = 0.45,
                    font = 6
                })
                qbx.drawText2d({
                    text = ('~o~Oil: ~w~ %s | ~o~Steering Angle: ~w~ %s | ~o~Body: ~w~ %s | ~o~Class: ~w~ %s'):format(qbx.math.round(oil, 4), qbx.math.round(angle, 4), qbx.math.round(body, 4), class),
                    coords = vec2(1.0, 0.600),
                    scale = 0.45,
                    font = 6
                })
                qbx.drawText2d({
                    text = ('~o~Dirt: ~w~ %s | ~o~Est Max Speed: ~w~ %s | ~o~Net ID: ~w~ %s | ~o~Hash: ~w~ %s'):format(qbx.math.round(dirt, 4), qbx.math.round(maxSpeed, 4) * 3.6, netId, hash),
                    coords = vec2(1.0, 0.625),
                    scale = 0.45,
                    font = 6
                })
                qbx.drawText2d({
                    text = ('~o~Vehicle Name: ~w~ %s'):format(name),
                    coords = vec2(1.0, 0.650),
                    scale = 0.45,
                    font = 6
                })
                Wait(0)
            else
                Wait(800)
            end
        end
    end,
    function()
        showPropInfo = not showPropInfo

        if not showPropInfo then
            return
        end

        CreateThread(function()
            while showPropInfo do
                local propData = getNearbyProps()
                local nextUpdate = GetGameTimer() + propsUpdateInterval

                while showPropInfo and GetGameTimer() < nextUpdate do
                    drawPropInfo(propData)
                    Wait(0)
                end
            end
        end)
    end,
}

lib.registerMenu({
    id = 'qbx_adminmenu_dev_menu',
    title = locale('title.dev_menu'),
    position = 'top-right',
    onClose = function(keyPressed)
        CloseMenu(false, keyPressed, 'qbx_adminmenu_main_menu')
    end,
    onSelected = function(selected)
        MenuIndexes.qbx_adminmenu_dev_menu = selected
    end,
    options = {
        {label = locale('dev_options.label1'), description = locale('dev_options.desc1'), icon = 'fas fa-compass'},
        {label = locale('dev_options.label2'), description = locale('dev_options.desc2'), icon = 'fas fa-compass'},
        {label = locale('dev_options.label3'), description = locale('dev_options.desc3'), icon = 'fas fa-compass'},
        {label = locale('dev_options.label4'), description = locale('dev_options.desc4'), icon = 'fas fa-compass'},
        {label = locale('dev_options.label5'), description = locale('dev_options.desc5'), icon = 'fas fa-compass-drafting', close = false},
        {label = locale('dev_options.label6'), description = locale('dev_options.desc6'), icon = 'fas fa-car-side', close = false},
        {label = locale('dev_options.label7'), description = locale('dev_options.desc7'), icon = 'fas fa-cubes', close = false}
    }
}, function(selected)
    options[selected]()
end)