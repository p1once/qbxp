fx_version "cerulean"
game "gta5"

description "NPWD Trackers GPS app (Qbox)"
version "1.1.0"
repository "local/npwd_qbx_trackers"

ox_lib "locale"
lua54 "yes"
use_experimental_fxv2_oal "yes"

shared_scripts {
    '@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua'
}

client_scripts {
    'client/client.lua',
    'client/test.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}

ui_page 'web/dist/index.html'

files {
    'locales/*.json',
    'web/dist/index.html',
    'web/dist/**/*'
}

provide 'npwd_qbx_trackers'
