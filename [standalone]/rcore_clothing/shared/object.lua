local function resolveOnce(promiseObject)
    local resolved = false

    local function wrapper(value)
        if not resolved then
            promiseObject:resolve(value)
            resolved = true
        end
    end

    return wrapper, function()
        return resolved
    end
end

local function tryExport(resourceName, exportName, resolve)
    if resourceName == nil or resourceName == '' then
        return false
    end

    if exportName == nil or exportName == '' then
        return false
    end

    local success, sharedObject = xpcall(function()
        local resourceExports = exports[resourceName]

        if resourceExports and resourceExports[exportName] then
            return resourceExports[exportName]()
        end
    end, debug.traceback)

    if success and sharedObject ~= nil then
        resolve(sharedObject)
        return true
    end

    return false
end

local function tryEvent(eventName, resolve)
    if eventName == nil or eventName == '' then
        return false
    end

    local resolved = false

    local success = xpcall(function()
        TriggerEvent(eventName, function(obj)
            resolved = true
            resolve(obj)
        end)
    end, debug.traceback)

    return success and resolved
end

function GetSharedObjectSafe()
    local object = promise:new()
    local resolve, isResolved = resolveOnce(object)

    if not Config.Framework then
        print('^1================ WARNING ================^7')
        print('^7Could not ^2load^7 shared object!^7')
        print('^1================ WARNING ================^7')
        return object
    end

    if Config.Framework == 1 then
        local resourceName = Config.FrameworkTriggers['resourceName']

        if resourceName == nil or resourceName == '' then
            resourceName = 'es_extended'
        end

        local eventName = Config.FrameworkTriggers['object']

        if eventName == nil or eventName == '' then
            eventName = 'esx:getSharedObject'
        end

        if not tryExport(resourceName, 'getSharedObject', resolve) then
            tryEvent(eventName, resolve)
        end
    elseif Config.Framework == 2 then
        local resourceName = Config.FrameworkTriggers['resourceName']

        if resourceName == nil or resourceName == '' then
            resourceName = 'qb-core'
        end

        local eventName = Config.FrameworkTriggers['object']

        if eventName == nil or eventName == '' then
            eventName = 'QBCore:GetObject'
        end

        if not tryExport(resourceName, 'GetCoreObject', resolve) then
            if not tryExport(resourceName, 'GetSharedObject', resolve) then
                tryEvent(eventName, resolve)
            end
        end
    end

    SetTimeout(1000, function()
        if not isResolved() then
            print('^1================ WARNING ================^7')
            print('^7Could not ^2load^7 shared object!^7')
            print('^1================ WARNING ================^7')
        end
    end)

    return object
end
