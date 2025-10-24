local baseLib = lib

if not baseLib or baseLib.name ~= 'ox_lib' then
    error('ox_lib must be started before loaf_lib', 0)
end

local exported = setmetatable({}, {
    __index = baseLib,
})

function exported.RegisterCallback(name, cb)
    return baseLib.callback.register(name, cb)
end

if IsDuplicityVersion() then
    function exported.TriggerCallback(name, target, cb, ...)
        return baseLib.callback(name, target, cb, ...)
    end

    function exported.TriggerCallbackSync(name, target, ...)
        return baseLib.callback.await(name, target, ...)
    end
else
    function exported.TriggerCallback(name, cb, ...)
        return baseLib.callback(name, false, cb, ...)
    end

    function exported.TriggerCallbackSync(name, ...)
        return baseLib.callback.await(name, false, ...)
    end
end

exports('GetLib', function()
    return exported
end)
