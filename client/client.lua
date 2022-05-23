-- Death
CreateThread(function()
    if Config.DeathLogs then
        local deathcause, wep, theKiller, deathreason
        if IsEntityDead(PlayerPedId()) then
            local coords = GetEntityCoords(PlayerPedId());
            local zone = GetNameOfZone(coords.x, coords.y, coords.z);
            local killer = GetPedSourceOfDeath(PlayerPedId())
            local playername = GetPlayerName(killer)
            deathcause = GetPedCauseOfDeath(PlayerPedId())
            wep = Weapons[tostring(deathcause)]
            if IsEntityAPed(killer) and IsPedAPlayer(killer) then
                theKiller = NetworkGetPlayerIndexFromPed(killer)
            elseif IsEntityAVehicle(killer) and IsEntityAPed(GetPedInVehicleSeat(killer, -1)) and IsPedAPlayer(GetPedInVehicleSeat(killer, -1)) then
                theKiller = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(killer, -1))
            end
            -- check death reason
            if (theKiller == PlayerId()) then
                deathreason = _U('suicide')
            elseif (theKiller == nil) then
                deathreason = _U('died')
            else
				deathreason = _U(getDeathReason(deathcause))
            end
            if deathreason == _U('suicide') or deathreason == _U('died') then
				TriggerServerEvent('omenlogs:playerdied', { pid = GetPlayerServerId(PlayerId()), killer = 0, deathreason = deathreason, weapon = wep, loc = zone, coords = coords })
			else
				TriggerServerEvent('omenlogs:playerdied', { pid = GetPlayerServerId(PlayerId()), killer = GetPlayerServerId(theKiller), deathreason = deathreason, weapon = wep, loc = zone, coords = coords })
			end
			theKiller = nil
			deathreason = nil
			deathcause = nil
			wep = nil
        end
    end
end)

-- Shooting
CreateThread(function()
	local currWeapon = 0
	local fireWeapon = nil
	local timeout = 0
	local fireCount = 0
	while true do
		Wait(0)
		local playerped = GetPlayerPed(PlayerId())
		if IsPedShooting(playerped) then
			fireWeapon = GetSelectedPedWeapon(playerped)
			fireCount = fireCount + 1
			timeout = 1000
		elseif not IsPedShooting(playerped) and fireCount ~= 0 and timeout ~= 0 then
			if timeout ~= 0 then
				timeout = timeout - 1
			end
			if fireWeapon ~= GetSelectedPedWeapon(playerped) then
				timeout = 0
			end
			if fireCount ~= 0 and timeout == 0 then
				if not Weapons[tostring(fireWeapon)] then
					TriggerServerEvent('omen_logs:shoot', "???")
					return
				end
                TriggerServerEvent('omen_logs:shoot', Weapons[tostring(fireWeapon)], fireCount)
				fireCount = 0
			end
		end
	end
end)
local clientStorage = {}
RegisterNetEvent('omen_logs:clientlogstorage')
AddEventHandler('omen_logs:clientlogstorage', function(args)
    if #clientStorage <= 4 then
		table.insert(clientStorage, args)
	else
		table.remove(clientStorage, 1)
		table.insert(clientStorage, args)
	end
end)
RegisterNetEvent('omen:getclientlogstorage')
AddEventHandler('omen:getclientlogstorage', function()
    TriggerServerEvent('omen:sendclientlogstorage', clientStorage)
end)