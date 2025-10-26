fx_version 'cerulean'
game 'gta5'

author 'Redutzu'
version '1.0.0'
description 'Information tablet'

ui_page 'nui/index.html'

shared_script '@ox_lib/init.lua'

client_scripts {
    'config.lua',
    'client.lua'
}

server_scripts {
    'server.lua'
}

files {
    'nui/index.html',
    'nui/index.js',
    'nui/style.css',
    'nui/img/*'
}
