fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Nosmakos'
description 'TPZ-CORE - Characters'
version '2.0.1'

ui_page 'html/index.html'

shared_scripts { 'config/config.lua', 'config/components_config.lua', 'locales/*.lua' }
client_scripts { 'client/*.lua' }
server_scripts { 'server/*.lua' }

files { 'html/**/*' }


lua54 'yes'

