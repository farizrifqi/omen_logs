CreateThread(function()
    print('\n░█████╗░███╗░░░███╗███████╗███╗░░██╗  ██╗░░░░░░█████╗░░██████╗░░██████╗')
    print('██╔══██╗████╗░████║██╔════╝████╗░██║  ██║░░░░░██╔══██╗██╔════╝░██╔════╝')
    print('██║░░██║██╔████╔██║█████╗░░██╔██╗██║  ██║░░░░░██║░░██║██║░░██╗░╚█████╗░')
    print('██║░░██║██║╚██╔╝██║██╔══╝░░██║╚████║  ██║░░░░░██║░░██║██║░░╚██╗░╚═══██╗')
    print('╚█████╔╝██║░╚═╝░██║███████╗██║░╚███║  ███████╗╚█████╔╝╚██████╔╝██████╔╝')
    print('░╚════╝░╚═╝░░░░░╚═╝╚══════╝╚═╝░░╚══╝  ╚══════╝░╚════╝░░╚═════╝░╚═════╝░\n')
    print('----------------------------- ^3O M E N^7 -----------------------------\n')
    omen.success("Omen Logs successfully loaded.")
end)

-- join/connect
AddEventHandler("playerConnecting", function(name, setReason, deferrals)
	local _source = source
	local ids = ExtractIdentifiers(_source)
	Wait(50)
	embedmsg = '```diff\n+ '..GetPlayerName(_source)..' ['..ids.steam..'] '.._U('connect')..' - '..os.date("%X")..'```'
	prepareWebhook({embedmsg = embedmsg, pid = source, channel = 'connect'})
end)

-- leave/disconnect/exiting
AddEventHandler("playerDropped", function(reason)
	local _source = source
	local pname = GetPlayerName(source)
	local ids = ExtractIdentifiers(_source)
	Wait(50)
	embedmsg = '```diff\n- '..pname..' ['..ids.steam..'] '.._U('leave')..' (Reason: '..reason..') - '..os.date("%X")..'```'
	prepareWebhook({embedmsg = embedmsg, pid = source, channel = 'leave'})
end)

-- chat
AddEventHandler('chatMessage', function(source, name, msg)
	local pname = GetPlayerName(source)
	local ids = ExtractIdentifiers(source)
	commmand = msg:gsub("%/", "")
	--if msg:sub(1, 1) ~= '/' then
	embedmsg = '```css\n'..pname..' ['..ids.steam..'] '..msg..'```'
	--end
	prepareWebhook({embedmsg = embedmsg, pid = source, channel = 'chat'})
end)

RegisterServerEvent('omenlogs:playerdied')
AddEventHandler('omenlogs:playerdied',function(args)
	if Config.DeathLogs then
		local pname = GetPlayerName(source)
		local ids = ExtractIdentifiers(source)
		local format = {}
		if args.weapon == nil then wep = "" else wep = ""..args.weapon.."" end
		if args.killer == 0 then 
			--format.embedmsg = '```css\n'..pname..' ['..ids.steam..'] '..args.deathreason..' - '..args.loc..' ('..args.coords..')```'
			format.embedmsg = '```css\n'..pname..' ['..ids.steam..'] '..args.deathreason..' ```'
			format.channel = 'death'
		else
			--format.embedmsg = '**' .. GetPlayerName(args.killer) .. '** '..args.deathreason..' - '..args.loc..' ('..args.coords.x..')```'
			format.embedmsg = '```css\n' .. GetPlayerName(args.killer) .. '** '..args.deathreason..'```'
			format.killer = args.killer
			format.channel = 'kill'
		end
		format.pid = source
		prepareWebhook(format)
	end
end)
RegisterServerEvent('omen_logs:shoot')
AddEventHandler('omen_logs:shoot', function(weapon, count)
	if Config.ShootLogs then
		prepareWebhook({embedmsg = _U('shoot', GetPlayerName(source), weapon, count), pid = source, channel = 'shoot'})
    end
end)

local storage = nil
RegisterNetEvent('omen_logs:sendclientlogstorage')
AddEventHandler('omen_logs:sendclientlogstorage', function(_storage)
	storage = _storage
end)
if GetCurrentResourceName() ~= "omen_logs" then
    omen.warning('This resource should be named omen_logs')
end