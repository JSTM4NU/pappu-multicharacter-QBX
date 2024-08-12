fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'pappu (adapted by jstm4nu and solareon)'
description 'pappu-multicharacter adapted to work on QBX Core with license2 support'
version '1.0.5'

shared_scripts {
    '@qbx_core/shared/locale.lua',
    '@ox_lib/init.lua',
    'locales/en.lua',
    'locales/it.lua',
    'locales/es.lua,
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts  {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

ui_page 'html/index.html'

files {
    'html/image/action_key.png',
    'html/image/action_dot.gif',
    "html/js/script.js",
    'html/index.html',
    'html/css/reset.css',
    'html/css/style.css'
}

dependencies {
    'qbx_core',
    'qbx_spawn',
    'illenium-appearance',
    'Renewed-Weathersync',
    'ox_inventory',
    'ox_lib'
}
