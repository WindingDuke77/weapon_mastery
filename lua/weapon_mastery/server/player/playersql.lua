// This Addon was created by:
// Bob Bobington#2947
// 
// any questions, please contact me

wmastery = wmastery or {}
wmastery.config = wmastery.config or {}
local config = wmastery.config
 
// Do not above this line.

local ply_meta = FindMetaTable("Player")

util.AddNetworkString("wmastery-update-level/xp")

function ply_meta:GetWeaponMastery(weapon)
    if not weapon then return end
    if config.Blacklist[weapon] then return end
    local weaponObject = weapons.Get(weapon)
    if not weaponObject then return end
    if config.BlacklistCatergorys[weaponObject.Category] then return end

    local steamID = self:SteamID64()

    local query = sql.Query("SELECT * FROM wmastery WHERE steamID = '"..steamID.."' AND weapon = '"..weapon.."'")

    if query == nil then
        sql.Query("INSERT INTO wmastery (steamID, weapon, XP, level, points, kills, npc_kills) VALUES ('"..steamID.."', '"..weapon.."', '0', '0', '0', '0', '0')")
        query = sql.Query("SELECT * FROM wmastery WHERE steamID = '"..steamID.."' AND weapon = '"..weapon.."'")
    end

    return query[1] 
end

function ply_meta:AddWeaponMasteryXP(weapon, XP)
    
    local steamID = self:SteamID64()

    local query = self:GetWeaponMastery(weapon)
    if query == nil then return end

    XP = XP * (config.LevelUpModifier or 1)
    XP = XP * (config.WeaponModifier[weapon] or 1)
    XP = XP * (config.RankModifier[self:GetUserGroup()] or 1)


    local newXP = query.XP + XP

    local newLevel, xpLeftOver =  wmastery.LevelsUpAmount(newXP, query.level)
    local points = query.points + newLevel
    newLevel = query.level + newLevel

    sql.Query("UPDATE wmastery SET XP = '"..newXP.."', level = '"..newLevel.."', points = '"..points.."' WHERE steamID = '"..steamID.."' AND weapon = '"..weapon.."'")
    
    local weaponEntity = weapons.Get(weapon) or {}
    local weaponName = weaponEntity.PrintName or weapon
    -- wmastery.notify(self, 0, 5, "You have leveled up your "..weaponName.." Mastery to level "..newLevel.."! You have "..points.." points to spend.")
    local infoTable = {
        weapon = weapon,
        weaponName = weaponName,
        prevLevel = query.level,
        newLevel = newLevel,
        prevXP = query.XP,
        newXP = newXP,
        points = points
    }
    net.Start("wmastery-update-level/xp") 
        net.WriteTable(infoTable)
    net.Send(self)
 
    return newXP, newLevel, points
end

function ply_meta:AddWeaponMasteryPoints(weapon, Points)
    local steamID = self:SteamID64()

    local query = self:GetWeaponMastery(weapon)
    if query == nil then return end

    local newPoints = query.points + Points

    sql.Query("UPDATE wmastery SET points = '"..newPoints.."' WHERE steamID = '"..steamID.."' AND weapon = '"..weapon.."'")

    return newPoints 
end

function ply_meta:SetWeaponMasteryPoints(weapon, Points)
    local steamID = self:SteamID64()

    local query = self:GetWeaponMastery(weapon)
    if query == nil then return end

    sql.Query("UPDATE wmastery SET points = '"..Points.."' WHERE steamID = '"..steamID.."' AND weapon = '"..weapon.."'")

    return Points 
end

function ply_meta:AddWeaponMasteryKills(weapon, amount, isNpc)
    
    local steamID = self:SteamID64()

    local query = self:GetWeaponMastery(weapon)
    if query == nil then return end

    if isNpc then
        query.npc_kills = query.npc_kills + amount
    else
        query.kills = query.kills + amount
    end

    sql.Query("UPDATE wmastery SET kills = '"..query.kills.."', npc_kills = '"..query.npc_kills.."' WHERE steamID = '"..steamID.."' AND weapon = '"..weapon.."'")

    return query.kills, query.npc_kills
end

function ply_meta:ResetWeaponMastery(weapon)
    local steamID = self:SteamID64()
    self:ResetWeaponMasteryUpgrades(weapon)

    sql.Query("UPDATE wmastery SET XP = '0', level = '0', points = '0', kills = '0', npc_kills = '0' WHERE steamID = '"..steamID.."' AND weapon = '"..weapon.."'")

    return true
end

function ply_meta:SetWeaponMasteryLevel(weapon, level)
    local steamID = self:SteamID64()

    local query = self:GetWeaponMastery(weapon)
    if query == nil then return end
    
    sql.Query("UPDATE wmastery SET XP = '0', level = '"..level.."' WHERE steamID = '"..steamID.."' AND weapon = '"..weapon.."'")

    return level
end

function ply_meta:AddWeaponMasteryLevel(weapon, level)
    local steamID = self:SteamID64()

    local query = self:GetWeaponMastery(weapon)
    if query == nil then return end

    local newLevel = query.level + level

    sql.Query("UPDATE wmastery SET XP = '0', level = '"..newLevel.."' WHERE steamID = '"..steamID.."' AND weapon = '"..weapon.."'")

    return newLevel
end

function ply_meta:ResetWeaponMasteryPoints(weapon)
        
    local steamID = self:SteamID64()

    local query = self:GetWeaponMastery(weapon)
    if query == nil then return end

    local cost = self:ResetWeaponMasteryUpgrades(weapon, true )
    local newPoints = tonumber(query.points) + cost

    sql.Query("UPDATE wmastery SET points = '"..newPoints.."' WHERE steamID = '"..steamID.."' AND weapon = '"..weapon.."'")

    return cost
end

util.AddNetworkString("wmastery-reset-upgrades")
net.Receive("wmastery-reset-upgrades", function (len, ply)
    local weapon = net.ReadString()
    local wepaonName = weapons.Get(weapon) and weapons.Get(weapon).PrintName or weapon
    
    local cost = ply:ResetWeaponMasteryPoints(weapon)
    wmastery.notify(ply, 0, 5, "You have reset your weapon mastery for "..wepaonName.." and gained "..cost.." points.")

    if ply:HasWeapon(weapon) then
        local wep = ply:GetWeapon(weapon)
        ply:ResetWeapon(wep)
    end


    wmastery.openClientUpgrade(ply, nil, weapon)
end)