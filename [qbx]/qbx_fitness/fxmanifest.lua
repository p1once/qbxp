fx_version 'cerulean'
game 'gta5'

name 'qbx_fitness'
description 'Fitness progression system for Qbox players'
repository 'https://github.com/Qbox-project/qbox'
version '0.1.0'

ox_lib 'locale'

shared_scripts {
    '@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua',
    'config/shared.lua'
}

client_scripts {
    '@qbx_core/modules/playerdata.lua',
    'config/client.lua',
    'client/main.lua',
    'client/equipment.lua'
}

server_scripts {
    'config/server.lua',
    'server/main.lua'
}

dependencies {
    'ox_lib',
    'qbx_core'
}

lua54 'yes'
