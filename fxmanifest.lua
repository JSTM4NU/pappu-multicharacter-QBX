fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'pappu (adapted by jstm4nu)'
description 'pappu-multicharacter adapted to work on QBX Core'
version '1.0.5'

shared_scripts {
    '@qbx_core/shared/locale.lua',
    '@ox_lib/init.lua',
    'locales/en.lua',
    'locales/it.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts  {
    '@oxmysql/lib/MySQL.lua',
    '@qb-apartments/config.lua',
    'server/main.lua'
}

ui_page 'html/index.html'

files {
    'html/image/*.png',
    'html/image/*.gif',
    "html/js/*",
    'html/index.html',
    'html/css/*',
}

dependencies {
    'qbx_core',
    'qbx_spawn'
}
