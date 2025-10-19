fx_version 'cerulean'
game 'gta5'

description 'GPS Vehicle Tracker item + NPWD locate integration'
version '1.0.0'

lua54 'yes'
use_experimental_fxv2_oal 'yes'

dependencies {
    'ox_lib',
    'ox_inventory',
    'qbx_core'
}

shared_scripts {
    '@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua'
}

client_scripts {
    'client/client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}

