discord = Config.Discord
webhook = Config.Discord.Webhooks

function prepareWebhook(args)
    if webhook[args.channel] then
        message = {
            userName = discord.Username,
            embeds = {{
                ["color"] = ConvertColor(args.channel),
                ["author"] = {
                    ["name"] = discord.CommunityName,
                    ["icon_url"] = discord.CommunityLogo
                },
                ["title"] = GetTitle(args.channel, webhook[args.channel]['icon']),
                ["description"] = args.embedmsg,
                ["footer"] = {
                    ["text"] = discord.FooterText.." • "..os.date("%x %X %p"),
                    ["icon_url"] = discord.FooterIcon,
                },
            }},
            avatar_url = discord.AvatarURL
        }

        content = {
            userName = discord.Username,
            content = args.embedmsg,
            avatar_url = discord.AvatarURL
        }
        if Config.Embed then
            SendLog({messageToDeliver = message, ip = args.ip, channel = args.channel})
        else
            SendLog({messageToDeliver = content, ip = args.ip, channel = args.channel})
        end
    else
        omen.warning("Channel "..args.channel.." not found in webhooks config")
    end
end
function getPlayerLocation(src)
    local coords = GetEntityCoords(src);
    local zone = GetNameOfZone(coords.x, coords.y, coords.z);
    local result = {coords = coords, postal = zone}
    return result
end
function GetPlayerDetails(src, config, channel)
    local check = {"PlayerID", "SteamID", "SteamURL", "Postal", "DiscordID", "License", "License2", "IP", "PlayTime", "playerPing"}

    local ids = ExtractIdentifiers(src)
	if Config.Postal then
        loc = getPlayerLocation(src)
        _postal = "\n**Nearest Postal:** ".. loc.postal ..""
    else
        _postal = ""
    end

    if Config.DiscordID then
        if ids.discord then
            _discordID ="\n**Discord ID:** <@" ..ids.discord:gsub("discord:", "").."> ("..ids.discord:gsub("discord:", "")..")"
        else
            _discordID = "\n**Discord ID:** N/A"
        end
    else
        _discordID = ""
    end

    if GetConvar("steam_webApiKey", "false") ~= 'false' then
        if Config.SteamID then
            if ids.steam then
                _steamID ="\n**Steam ID:** " ..ids.steam..""
            else
                _steamID = "\n**Steam ID:** N/A"
            end
        else
            _steamID = ""
        end

        if Config.SteamURL then
            if ids.steam then
                _steamURL ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16)..""
            else
                _steamURL = "\n**Steam URL:** N/A"
            end
        else
            _steamURL = ""
        end
    else
        _steamID = ""
        _steamURL = ""
        omen.warning("Steam API Key not set.")
    end

	if Config.License then
        if ids.license then
            _license ="\n**License:** " ..ids.license
        else
            _license = "\n**License:** N/A"
        end
    else
        _license = ""
    end

    if Config.License2 then
        if ids.license2 then
            _license2 ="\n**License 2:** " ..ids.license2
        else
            _license2 = "\n**License 2:** N/A"
        end
    else
        _license2 = ""
    end

	if Config.IP then
        if ids.ip then
            _ip ="\n**IP:** " ..ids.ip:gsub("ip:", "")
        else
            _ip = "\n**IP:** N/A"
        end
    else
        _ip = ""
    end

	if Config.PlayerID then
        if channel ~= 'joins' then
            _playerID ="\n**Player ID:** " ..src..""
        else
            _playerID = "\n**Player ID:** N/A"
        end
    else
        _playerID = ""
    end

    if Config.PlayerPing then
        _ping = "\n**Ping:** `"..GetPlayerPing(src)..'ms`'
    else
        _ping = ""
    end

    if Config.Health or Config.Armor then
        _hp = "\n"
        local playerPed = GetPlayerPed(src)
        if Config.Health then
            local maxHealth = math.floor(GetEntityMaxHealth(playerPed) / 2)
            local health = math.floor(GetEntityHealth(playerPed) / 2)
            _hp = _hp.."**Health:** ❤: `"..health.."/"..maxHealth.."`"
        end
        if Config.Armor then
            if Config.Health then
                _hp = _hp.." **|** "
            end
            local maxArmour = GetPlayerMaxArmour(src)
            local armour = GetPedArmour(playerPed)
            _hp = _hp.."**Armor:** 🛡: `"..armour.."/"..maxArmour.."`"
        end
    else
        _hp = ""
    end

    if Config.MoreDetails then
        xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer ~= nil then
            acc = "\n\n**Account: **"
            if Config.Name then
                acc = acc.."\n**Character Name:** "..xPlayer.name
            end
            if Config.Job then
                acc = acc.."\n**Job:** "..xPlayer.job.name.."\n**Job Grade:** "..xPlayer.job.grade
            end
            if Config.Money then
                if xPlayer.getAccount('money').money ~= nil then
                    _cash = ESX.Math.GroupDigits(xPlayer.getAccount('money').money)
                else
                    _cash = 'N/A'
                end
            end
            if Config.Bank then
                if xPlayer.getAccount('bank').money ~= nil then
                    _bank = ESX.Math.GroupDigits(xPlayer.getAccount('bank').money)
                else
                    _bank = 'N/A'
                end
            end
            if Config.BlackMoney then
                if xPlayer.getAccount('black_money').money ~= nil then
                    _blmon = ESX.Math.GroupDigits(xPlayer.getAccount('black_money').money)
                else
                    _blmon = 'N/A'
                end
                acc = acc.."\n**Money:** $".._cash.."\n**Bank Balance:** $".._bank.."\n**Black Money:** $".._blmon
            end
        else
            acc = ""
        end
    else
        acc = ""
    end

    return _playerID.._postal.._hp.._discordID.._steamID.._steamURL.._license.._license2.._session.._total.._ip..acc
end

function SendLog(load)
    if webhook[load.channel] then
        PerformHttpRequest(webhook[load.channel]['webhookurl'], function(err, text, headers)
            GetStatus(err, load.channel)
        end, 'POST', json.encode(load.messageToDeliver), {
            ['Content-Type'] = 'application/json'
        })
    else
        omen.warning("No webhook for channel "..args.channel)
    end
end
function GetStatus(status, channel)
	if status == 404 or status == 401 and webhook[channel]['webhookurl'] ~= "DISCORD_WEBHOOK" and webhook[channel]['webhookurl'] ~= "" then
		print('^3Warn: JD_logs webhook. Possible invalid webhook for "'..channel..'" webhook. Status code: '..status)
        omen.warning("Invalid webhook url for channel "..args.channel..". Status: "..status)
	end
end
function ConvertColor(channel)
    if webhook[channel] then
        src = webhook[channel]['color']
        if string.find(src,"#") then
            return tonumber(src:gsub("#",""),16)
        else
            return src
        end
    else
        return 000000
    end
end

function ExtractIdentifiers(src)
    local identifiers = {}
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)
        if string.find(id, "steam:") then
            identifiers['steam'] = id
        elseif string.find(id, "ip:") then
            identifiers['ip'] = id
        elseif string.find(id, "discord:") then
            identifiers['discord'] = id
        elseif string.find(id, "license:") then
            identifiers['license'] = id
        elseif string.find(id, "license2:") then
            identifiers['license2'] = id
        elseif string.find(id, "xbl:") then
            identifiers['xbl'] = id
        elseif string.find(id, "live:") then
            identifiers['live'] = id
        elseif string.find(id, "fivem:") then
            identifiers['fivem'] = id
        end
    end

    return identifiers
end
exports('ExtractIdentifiers', ExtractIdentifiers)
function GetTitle(channel, icon)
    if icon then
		return icon.." "..firstToUpper(channel)
	else
		return "❓ "..firstToUpper(channel)
	end
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end