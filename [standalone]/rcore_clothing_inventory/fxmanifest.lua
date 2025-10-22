fx_version 'cerulean'
lua54 'yes'

game 'gta5'

name 'rcore_clothing_inventory'
description 'Adds purchased outfits from rcore_clothing to ox_inventory as clothing items.'
author 'OpenAI ChatGPT'

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

dependencies {
    'rcore_clothing',
    'ox_inventory'
}
