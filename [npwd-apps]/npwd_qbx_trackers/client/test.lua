RegisterCommand('trk', function()
    if exports and exports.npwd and exports.npwd.openApp then
        exports.npwd:openApp('npwd_qbx_trackers')
    else
        print('npwd export not available')
    end
end)

