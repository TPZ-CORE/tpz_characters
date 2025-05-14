fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Nosmakos'
description 'Titans Productions Zombies Core - Characters'
version '1.0.0'

ui_page 'html/index.html'

shared_scripts { 'config.lua', 'mp_config.lua', 'locales.lua'   }
client_scripts { 'client/*.lua' }
server_scripts { 'server/*.lua' }

exports { "getMPConfiguration", "getClothHashNamesList", "toggleOverlayChange" }

files { 'html/**/*' }

lua54 'yes'