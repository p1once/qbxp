local resources = { 'qb-core', 'qbx_core' }

return function(name, cb)
    for i = 1, #resources do
        local resource = resources[i]
        AddEventHandler(('__cfx_export_%s_%s'):format(resource, name), function(setCB)
            setCB(cb)
        end)
    end
end
