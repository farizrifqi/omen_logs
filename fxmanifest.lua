
game 'gta5'
fx_version 'cerulean'

author 'zeraneL'
description 'FiveM Logs integrated to Discord'
version '1.0.0'

client_script {
    'client/client.lua',
    'client/functions.lua'
}

server_script {
    'server/server.lua',
    'server/functions.lua'
}

shared_script {
    'modules/*.lua',
    'config.lua',
    'discord/*.lua',
    'locales/*.lua'
}