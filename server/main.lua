local starterItems = require '@qbx_core.config.shared'.starterItems
local hasDonePreloading = {}

-- Functions

local function GiveStarterItems(source)
    if GetResourceState('ox_inventory') == 'missing' then return end
    while not exports.ox_inventory:GetInventory(source) do
        Wait(100)
    end
    for i = 1, #starterItems do
        local item = starterItems[i]
        if item.metadata and type(item.metadata) == 'function' then
            exports.ox_inventory:AddItem(source, item.name, item.amount, item.metadata(source))
        else
            exports.ox_inventory:AddItem(source, item.name, item.amount, item.metadata)
        end
    end
end

--local function loadHouseData(src)
--    local HouseGarages = {}
--    local Houses = {}
--    local result = MySQL.query.await('SELECT * FROM houselocations', {})
--    if result[1] ~= nil then
--        for _, v in pairs(result) do
--            local owned = false
--           if tonumber(v.owned) == 1 then
--                owned = true
--            end
--            local garage = v.garage ~= nil and json.decode(v.garage) or {}
--            Houses[v.name] = {
--                coords = json.decode(v.coords),
--                owned = owned,
--                price = v.price,
--                locked = true,
--                adress = v.label,
--                tier = v.tier,
--                garage = garage,
--                decorations = {},
--            }
--            HouseGarages[v.name] = {
--                label = v.label,
--                takeVehicle = garage,
--            }
--        end
--    end
--    TriggerClientEvent("renzu_garage:client:houseGarageConfig", src, HouseGarages)
--    TriggerClientEvent("qb-houses:client:setHouseConfig", src, Houses)
--end

-- Discord logging function
local function sendToDiscord(name, message, color)
    local discordWebhook = "https://canary.discord.com/api/webhooks/1255278139291209831/rmq4wlFMeMTEHiU1fnQ08jWhHdrJ5e4wJ7ETkBOuzm1I82w2Qi_-u57NUIO1rjUNUY_D" -- Replace with your Discord webhook URL
    
    local embeds = {
        {
            ["title"] = name,
            ["type"] = "rich",
            ["color"] = color,
            ["description"] = message,
            ["footer"] = {
                ["text"] = "Pappu MultiCharacter Logs",
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ") -- Adding timestamp in ISO 8601 format
        }
    }

    PerformHttpRequest(discordWebhook, 
        function(err, text, headers) 
            if err == 200 then
                print("Message sent successfully to Discord")
            else
                print("Error sending message to Discord: " .. err)
            end
        end, 
        'POST', 
        json.encode({ username = "Pappu MultiCharacter", embeds = embeds }), 
        { ['Content-Type'] = 'application/json' }
    )
end


-- Commands
lib.addCommand('relog', {
    help = 'Ritorna alla selezione del personaggio',
    restricted = 'group.admin' },
    function(source)
        exports.qbx_core:Logout(source)
        TriggerClientEvent('pappu-multicharacter:client:chooseChar', source)
    end
)

lib.addCommand('closeNUI', {
    help = 'Close Multi NUI',
    },
    function(source)
        TriggerClientEvent('pappu-multicharacter:client:closeNUI', source)
    end
)

-- Events

AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
    Wait(1000) -- 1 second should be enough to do the preloading in other resources
    hasDonePreloading[Player.PlayerData.source] = true
end)

AddEventHandler('QBCore:Server:OnPlayerUnload', function(src)
    hasDonePreloading[src] = false
end)

RegisterNetEvent('pappu-multicharacter:server:disconnect', function()
    local src = source
    local Player = exports.qbx_core:GetPlayer(source)
    if Player then
        local citizenid = Player.PlayerData.citizenid
        local firstname = Player.PlayerData.charinfo.firstname
        local lastname = Player.PlayerData.charinfo.lastname
        local fivemname = GetPlayerName(src)
        sendToDiscord("Player Disconnected", string.format("Citizen ID: %s\nFirst Name: %s\nLast Name: %s\nFiveM Name: %s", citizenid, firstname, lastname, fivemname), 15158332)
    end
    DropPlayer(src, Lang:t("commands.droppedplayer"))
end)

RegisterNetEvent('pappu-multicharacter:server:loadUserData', function(cData)
    local src = source
    if exports.qbx_core:Login(source, citizenid) then
        repeat
            Wait(10)
        until hasDonePreloading[src]
        local fivemname = GetPlayerName(src)
        sendToDiscord("Player Loaded", string.format("Citizen ID: %s\nFiveM Name: %s", cData.citizenid, fivemname), 3066993)
        -- loadHouseData(src)
        if Config.SkipSelection then
            local coords = json.decode(cData.position)
            TriggerClientEvent('pappu-multicharacter:client:spawnLastLocation', src, coords, cData)
        else
            if GetResourceState('qb-apartments') == 'started' then
                TriggerClientEvent('apartments:client:setupSpawnUI', src, cData)
            else
                TriggerClientEvent('qbx_spawn:client:setupSpawns', src, cData, false, nil)
                TriggerClientEvent('qbx_spawn:client:openUI', src, true)
            end
        end
        TriggerEvent("qb-log:server:CreateLog", "joinleave", "Loaded", "green", "**".. GetPlayerName(source) .. "** (<@"..(GetPlayerIdentifier(source, 'discord'):gsub("discord:", "") or "unknown").."> |  ||"  ..(GetPlayerIdentifier(source, 'ip') or 'undefined') ..  "|| | " ..(GetPlayerIdentifier(source, 'license') or 'undefined') .." | " ..citizenid.." | "..source..") loaded..")
    end
end)

RegisterNetEvent('pappu-multicharacter:server:createCharacter', function(data)
    local src = source
    local newData = {}
    newData.cid = data.cid
    newData.charinfo = data
    if exports.qbx_core:Login(src, false, newData) then
        repeat
            Wait(10)
        until hasDonePreloading[src]
        local fivemname = GetPlayerName(src)
        sendToDiscord("Character Created", string.format("Citizen ID: %s\nFirst Name: %s\nLast Name: %s\nFiveM Name: %s", newData.cid, data.firstname, data.lastname, fivemname), 3066993)
        if GetResourceState('qb-apartments') == 'started' and Apartments.Starting then
            local randbucket = (GetPlayerPed(src) .. math.random(1,999))
            SetPlayerRoutingBucket(src, randbucket)
            print('^2[qb-core]^7 '..GetPlayerName(src)..' has successfully loaded!')
            -- loadHouseData(src)
            TriggerClientEvent("pappu-multicharacter:client:closeNUI", src)
            TriggerClientEvent('apartments:client:setupSpawnUI', src, newData)
            GiveStarterItems(src)
        else
            print('^2[qb-core]^7 '..GetPlayerName(src)..' has successfully loaded!')
            -- loadHouseData(src)
            TriggerClientEvent("pappu-multicharacter:client:closeNUIdefault", src)
            GiveStarterItems(src)
        end
    end
end)

RegisterNetEvent('pappu-multicharacter:server:deleteCharacter', function(citizenid)
    local src = source
    exports.qbx_core:DeleteCharacter(src, citizenid)
    local fivemname = GetPlayerName(src)
    sendToDiscord("Character Deleted", string.format("Citizen ID: %s\nFiveM Name: %s", citizenid, fivemname), 15158332)
    TriggerClientEvent('exports.qbx_core:Notify', src, "Character deleted!" , "success")
end)

-- Callbacks

lib.callback.register("pappu-multicharacter:server:GetUserCharacters", function(source)
    local src = source
    local license, license2 = GetPlayerIdentifierByType(src, 'license'), GetPlayerIdentifierByType(src, 'license2')
    local characters = {}
    if not license then
        return characters
    end
    MySQL.query('SELECT * FROM players WHERE license = ? OR license = ?', {license2, license}, function(result)
        if result[1] ~= nil then
            for _, v in pairs(result) do
                local charinfo = json.decode(v.charinfo)
                local data = {
                    citizenid = v.citizenid,
                    charinfo = charinfo,
                    cData = v
                }
                table.insert(characters, data)
            end
            return characters
        else
            return characters
        end
    end)
end)

lib.callback.register("pappu-multicharacter:server:GetServerLogs", function(_)
    MySQL.query('SELECT * FROM server_logs', {}, function(result)
        return result
    end)
end)

lib.callback.register("pappu-multicharacter:server:GetNumberOfCharacters", function(source)
    local license, license2 = GetPlayerIdentifierByType(src, 'license'), GetPlayerIdentifierByType(src, 'license2')
    local numOfChars = 0

    if next(Config.PlayersNumberOfCharacters) then
        for _, v in pairs(Config.PlayersNumberOfCharacters) do
            if v.license == license or v.license == license2 then
                numOfChars = v.numberOfChars
                break
            else
                numOfChars = Config.DefaultNumberOfCharacters
            end
        end
    else
        numOfChars = Config.DefaultNumberOfCharacters
    end
    return numOfChars
end)

lib.callback.register("pappu-multicharacter:server:setupCharacters", function(source)
    local license, license2 = GetPlayerIdentifierByType(src, 'license'), GetPlayerIdentifierByType(src, 'license2')
    local plyChars = {}
    MySQL.query('SELECT * FROM players WHERE license = ? or license = ?', {license, license2}, function(result)
        for i = 1, (#result), 1 do
            result[i].charinfo = json.decode(result[i].charinfo)
            result[i].money = json.decode(result[i].money)
            result[i].job = json.decode(result[i].job)
            plyChars[#plyChars+1] = result[i]
        end
        return plyChars
    end)
end)

lib.callback.register("pappu-multicharacter:server:getSkin", function(_, cid)
    local result = MySQL.query.await('SELECT * FROM playerskins WHERE citizenid = ? AND active = ?', {cid, 1})
    if result[1] ~= nil then
        return result[1].model, result[1].skin
    else
        return
    end
end)