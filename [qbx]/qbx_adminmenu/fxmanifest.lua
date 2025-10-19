fx_version 'cerulean'
game 'gta5'

description 'qbx_adminmenu'
repository 'https://github.com/Qbox-project/qbx_adminmenu'
version '0.1.0'

ox_lib 'locale'

shared_scripts {
    '@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}

client_scripts {
    'client/main.lua',
    'client/admin.lua',
    'client/player.lua',
    'client/reports.lua',
    'client/dev.lua',
    'client/server.lua',
    'client/vectors.lua',
    'client/vehicle.lua',
}

files {
    'locales/*.json',
    'html/keycapture.html',
}

ui_page 'html/keycapture.html'

lua54 'yes'
use_experimental_fxv2_oal 'yes'
