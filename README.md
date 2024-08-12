# Pappu-Multicharacter with QBOX support
Custom Multi Character Feature for QBOX And inspired by NoPixel 4.0. 

## Features
- Ability To Create Max 4 Characters.
- Ability Delete Any Character.
- Ability To See Character Information During Selection.
- Ability To Customise Your Character Slot At [config.lua](https://github.com/JSTM4NU/pappu-multicharacter-QBX/blob/main/config.lua).
- **New**: Ability to log character creation, deletion, and selection to a Discord [webhook](https://github.com/JSTM4NU/pappu-multicharacter-QBX/blob/main/server/main.lua#L61).
## Preview
![Group 5765](https://github.com/P4ScriptsFivem/pappu-multicharacter/assets/120780563/904aa0c6-cabf-4b9a-82ca-ac224e5cc24b)


## Features
If You Use [qb-houses](https://github.com/qbcore-framework/qb-houses)
Go To Line 324 in Server/main.lua [here](https://github.com/qbcore-framework/qb-houses/blob/main/server/main.lua#L324)

Repplace This 
```
    TriggerClientEvent('qb-multicharacter:client:chooseChar', src)
```
With This  
```
    TriggerClientEvent('pappu-multicharacter:client:chooseChar', src)
```

## Screenshots
![Group 847](https://github.com/P4ScriptsFivem/pappu-multicharacter/assets/120780563/9d7d768b-799f-4dfe-9567-62077479db63)


## Installation
### Manual
- Download the script and put it in the `[standalone]` directory.
- Add the following code to your server.cfg/resouces.cfg

```
ensure qbx_core
ensure pappu-multicharacter
ensure qbx_spawn
ensure illenium-appearance
ensure Renewed-Weathersync
```

## Dependencies
- [qbx_core](https://github.com/Qbox-project/qbx_core)
- [qbx_spawn](https://github.com/Qbox-project/qbx_spawn) - Spawn selector
- [illenium-appearance](https://github.com/iLLeniumStudios/illenium-appearance) - For the character creation and saving outfits.
- [Renewed_Weathersync](https://github.com/Renewed-Scripts/Renewed-Weathersync) - To sync the weather while creating the character

## Credits & Original Repositories
- [pappu-multicharacter](https://github.com/P4ScriptsFivem/pappu-multicharacter)
- [qb-multicharacter](https://github.com/qbcore-framework/qb-multicharacter)
  
## License
[GPL-3.0 license](LICENSE)
