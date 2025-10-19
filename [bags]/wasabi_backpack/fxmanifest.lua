-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'Wasabi Backpack for Ox Inventory'
version '1.0.4'

client_scripts {
    'client/**.lua'
}

server_scripts {
  'server/**.lua'
}

shared_scripts {
  '@ox_lib/init.lua',
  'config.lua'
}

-- Explicitly register the client export for broader compatibility
exports {
  'openBackpack'
}

dependencies {
  'ox_inventory'
}
