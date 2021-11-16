fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
	'@es_extended/imports.lua', -- comment if using QBUS
    'config.lua'
}

server_scripts {
	--'@mysql-async/lib/MySQL.lua', -- don't need mysql for this installation
	'server/*.lua',
}

client_scripts {
	'client/*.lua',
}