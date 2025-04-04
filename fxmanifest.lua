fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Tafé | YourMAPS'
description 'A fully configurable RedM flag system – players can equip, drop, and pick up custom flags with animations and attachments.'


client_scripts {
    'config.lua',
    'client/client.lua'
    
}
server_scripts {
    'config.lua',
    'server/server.lua'
}

data_file 'DLC_ITYP_REQUEST' 'stream/prop_yourflags_script.ytyp'