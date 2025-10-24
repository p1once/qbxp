fx_version 'bodacious'
game 'gta5'

--[[📱 QBCore Store - QB Phone Script 📱]]

scriptname 'qb-phone'
author '✨ QBCore Store ✨ - Join us on Discord: https://discord.gg/qbcoreframework'
description '📱 QB Phone - Redesigned by QBCore Store. Inspired by iPhone. 🍎'

-- ⚙️ Script Configuration & Info ⚙️
-- Enjoy a sleek, modern phone interface designed for QBCore!
-- For support and updates, visit our Discord community. 🚀

----------------------------

ui_page 'html/index.html'

shared_scripts {
    'config.lua',
    '@qb-apartments/config.lua',
}

client_scripts {
    'client/main.lua',
    'client/animation.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
    '@qb-garages/config.lua',
}

files {
    'html/*.html',
    'html/js/*.js',
    'html/img/*.png',
    'html/css/*.css',
    'html/img/backgrounds/*.png',
    'html/img/apps/*.png',
}


lua54 'yes'

dependency '/assetpacks'