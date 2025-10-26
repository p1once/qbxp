local ITEM = 'realestate_tablet'

-- Register usable item so using it opens the UI
CreateThread(function()
    -- Wait a tick to ensure qbx_core export is ready
    Wait(0)
    if exports and exports.qbx_core and exports.qbx_core.CreateUseableItem then
        exports.qbx_core:CreateUseableItem(ITEM, function(source)
            local player = exports.qbx_core:GetPlayer(source)
            local requiredJob = GetConvar('realestate_tablet:job', 'realestate')
            if not player or not player.PlayerData or not player.PlayerData.job or player.PlayerData.job.name ~= requiredJob then
                exports.qbx_core:Notify(source, 'Accès réservé aux agents immobiliers.', 'error')
                return
            end
            TriggerClientEvent('realestate-tab:client:open', source)
        end)
    else
        print('^3[realestate-tab]^7 qbx_core CreateUseableItem not available; item use will not open the tablet.')
    end
end)
