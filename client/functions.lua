function getDeathReason(dc)
    local deathcause
    Weapons = {
        -- molotov
        'WEAPON_MOLOTOV',
        -- minigun
        'WEAPON_MINIGUN',
        -- vehicle weapon
        'VEHICLE_WEAPON_ROTORS',
        -- smg
        'WEAPON_MICROSMG', 'WEAPON_SMG',
        -- lightweight
        'WEAPON_MG', 'WEAPON_COMBATMG',
        -- vehicle
        'WEAPON_RUN_OVER_BY_CAR', 'WEAPON_RAMMED_BY_CAR',
        -- sniper
        'WEAPON_MARKSMANRIFLE', 'WEAPON_SNIPERRIFLE', 'WEAPON_HEAVYSNIPER', 'WEAPON_ASSAULTSNIPER', 'WEAPON_REMOTESNIPER',
        -- knife
        'WEAPON_DAGGER', 'WEAPON_KNIFE', 'WEAPON_SWITCHBLADE', 'WEAPON_HATCHET', 'WEAPON_BOTTLE',
        -- bomb
        'WEAPON_GRENADE', 'WEAPON_PROXMINE', 'WEAPON_EXPLOSION', 'WEAPON_STICKYBOMB', 'WEAPON_PIPEBOMB',
        -- heavygun
        'WEAPON_GRENADELAUNCHER', 'WEAPON_RPG', 'WEAPON_FLAREGUN', 'WEAPON_HOMINGLAUNCHER', 'WEAPON_FIREWORK', 'VEHICLE_WEAPON_TANK',
        -- melee
        'WEAPON_UNARMED', 'WEAPON_CROWBAR', 'WEAPON_BAT', 'WEAPON_GOLFCLUB', 'WEAPON_HAMMER', 'WEAPON_NIGHTSTICK',
        -- pistol
        'WEAPON_SNSPISTOL', 'WEAPON_HEAVYPISTOL', 'WEAPON_VINTAGEPISTOL', 'WEAPON_PISTOL', 'WEAPON_APPISTOL', 'WEAPON_COMBATPISTOL',
        -- shotgun
        'WEAPON_BULLPUPSHOTGUN', 'WEAPON_ASSAULTSHOTGUN', 'WEAPON_DBSHOTGUN', 'WEAPON_PUMPSHOTGUN', 'WEAPON_HEAVYSHOTGUN', 'WEAPON_SAWNOFFSHOTGUN',
        -- rifle
        'WEAPON_CARBINERIFLE', 'WEAPON_MUSKET', 'WEAPON_ADVANCEDRIFLE', 'WEAPON_ASSAULTRIFLE', 'WEAPON_SPECIALCARBINE', 'WEAPON_COMPACTRIFLE', 'WEAPON_BULLPUPRIFLE'
    }
    for i, CurrentWeapon in ipairs(Weapons) do
		if 'WEAPON_MOLOTOV' == CurrentWeapon then
			if dc == GetHashKey(CurrentWeapon) then deathcause = 'torched' end
        elseif 'WEAPON_MINIGUN' == CurrentWeapon then
            if dc == GetHashKey(CurrentWeapon) then deathcause = 'shredded' end
        elseif 'VEHICLE_WEAPON_ROTORS' == CurrentWeapon then
            if dc == GetHashKey(CurrentWeapon) then deathcause = 'vehiclewep' end
        elseif 'WEAPON_MICROSMG' == CurrentWeapon or 'WEAPON_SMG' == CurrentWeapon then
            if dc == GetHashKey(CurrentWeapon) then deathcause = 'riddled' end
        elseif 'WEAPON_MG' == CurrentWeapon or 'WEAPON_COMBATMG' == CurrentWeapon then
            if dc == GetHashKey(CurrentWeapon) then deathcause = 'machinegunned' end
        elseif 'WEAPON_RUN_OVER_BY_CAR' == CurrentWeapon or 'WEAPON_RAMMED_BY_CAR' == CurrentWeapon then
            if dc == GetHashKey(CurrentWeapon) then deathcause = 'flattened' end
        elseif 'WEAPON_MARKSMANRIFLE' == CurrentWeapon or 'WEAPON_SNIPERRIFLE' == CurrentWeapon or 'WEAPON_HEAVYSNIPER' == CurrentWeapon or 'WEAPON_ASSAULTSNIPER' == CurrentWeapon or 'WEAPON_REMOTESNIPER' == CurrentWeapon then
            if dc == GetHashKey(CurrentWeapon) then deathcause = 'sniped' end
        elseif 'WEAPON_DAGGER' == CurrentWeapon or 'WEAPON_KNIFE' == CurrentWeapon or 'WEAPON_SWITCHBLADE' == CurrentWeapon or 'WEAPON_HATCHET' == CurrentWeapon or 'WEAPON_BOTTLE' == CurrentWeapon then
            if dc == GetHashKey(CurrentWeapon) then deathcause = 'knifed' end
        elseif 'WEAPON_GRENADE' == CurrentWeapon or 'WEAPON_PROXMINE' == CurrentWeapon or 'WEAPON_EXPLOSION' == CurrentWeapon or 'WEAPON_STICKYBOMB' == CurrentWeapon or 'WEAPON_PIPEBOMB' == CurrentWeapon then
            if dc == GetHashKey(CurrentWeapon) then deathcause = 'bombed' end
        elseif 'WEAPON_GRENADELAUNCHER' == CurrentWeapon or 'WEAPON_RPG' == CurrentWeapon or 'WEAPON_HOMINGLAUNCHER' == CurrentWeapon or 'WEAPON_FLAREGUN' == CurrentWeapon or 'WEAPON_FIREWORK' == CurrentWeapon or 'VEHICLE_WEAPON_TANK' == CurrentWeapon then
            if dc == GetHashKey(CurrentWeapon) then deathcause = 'oblirated' end
        elseif 'WEAPON_UNARMED' == CurrentWeapon or 'WEAPON_CROWBAR' == CurrentWeapon or 'WEAPON_BAT' == CurrentWeapon or 'WEAPON_GOLFCLUB' == CurrentWeapon or 'WEAPON_HAMMER' == CurrentWeapon or 'WEAPON_NIGHTSTICK' == CurrentWeapon then
            if dc == GetHashKey(CurrentWeapon) then deathcause = 'dibunuh' end
        elseif 'WEAPON_SNSPISTOL' == CurrentWeapon or 'WEAPON_HEAVYPISTOL' == CurrentWeapon or 'WEAPON_VINTAGEPISTOL' == CurrentWeapon or 'WEAPON_PISTOL' == CurrentWeapon or 'WEAPON_APPISTOL' == CurrentWeapon or 'WEAPON_COMBATPISTOL' == CurrentWeapon then
            if dc == GetHashKey(CurrentWeapon) then deathcause = 'pistoled' end
        elseif 'WEAPON_BULLPUPSHOTGUN' == CurrentWeapon or 'WEAPON_ASSAULTSHOTGUN' == CurrentWeapon or 'WEAPON_DBSHOTGUN' == CurrentWeapon or 'WEAPON_PUMPSHOTGUN' == CurrentWeapon or 'WEAPON_HEAVYSHOTGUN' == CurrentWeapon or 'WEAPON_SAWNOFFSHOTGUN' == CurrentWeapon then
            if dc == GetHashKey(CurrentWeapon) then deathcause = 'pulverized' end
        elseif 'WEAPON_CARBINERIFLE' == CurrentWeapon or 'WEAPON_MUSKET' == CurrentWeapon or 'WEAPON_ADVANCEDRIFLE' == CurrentWeapon or 'WEAPON_ASSAULTRIFLE' == CurrentWeapon or 'WEAPON_SPECIALCARBINE' == CurrentWeapon or 'WEAPON_COMPACTRIFLE' == CurrentWeapon or 'WEAPON_BULLPUPRIFLE' == CurrentWeapon then
            if dc == GetHashKey(CurrentWeapon) then deathcause = 'rifled' end
        else 
            deathcause = 'killed'
        end
	end
    return deathcause
end