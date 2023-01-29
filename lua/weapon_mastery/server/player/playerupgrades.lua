// This Addon was created by:
// Bob Bobington#2947
// 
// any questions, please contact me

wmastery = wmastery or {}
wmastery.config = wmastery.config or {}
local config = wmastery.config
 
// Do not above this line.

local ply_meta = FindMetaTable("Player")

if not file.IsDir("neuralstudio/weapon_mastery/upgrades", "DATA") then
    file.CreateDir("neuralstudio/weapon_mastery/upgrades")
end

function ply_meta:GetWeaponMasteryUpgrades(weapon)
    if not file.IsDir("neuralstudio/weapon_mastery/upgrades/" .. self:SteamID64(), "DATA") then
        file.CreateDir("neuralstudio/weapon_mastery/upgrades/" .. self:SteamID64())
    end

    local weaponObj = weapons.Get(weapon)
    if not weaponObj then return {} end

    if not file.Exists("neuralstudio/weapon_mastery/upgrades/" .. self:SteamID64() .. "/" .. weapon .. ".json", "DATA") then
        file.Write("neuralstudio/weapon_mastery/upgrades/" .. self:SteamID64() .. "/" .. weapon .. ".json", "{}")
    end

    local data = file.Read("neuralstudio/weapon_mastery/upgrades/" .. self:SteamID64() .. "/" .. weapon .. ".json", "DATA")
    local tbl = util.JSONToTable(data)

    return tbl
end

function ply_meta:SaveWeaponMasteryUpgrades(weapon, data)
    if not file.IsDir("neuralstudio/weapon_mastery/upgrades/" .. self:SteamID64(), "DATA") then
        file.CreateDir("neuralstudio/weapon_mastery/upgrades/" .. self:SteamID64())
    end

    local weaponObj = weapons.Get(weapon)
    if not weaponObj then return {} end

    file.Write("neuralstudio/weapon_mastery/upgrades/" .. self:SteamID64() .. "/" .. weapon .. ".json", util.TableToJSON(data, true))
end

function ply_meta:UpgradeWeaponMasteryUpgrade(weapon, upgradetype, upgrade)
    local upgradeObj = wmastery.upgrade[upgradetype]
    if not upgradeObj then return false, "Invalid Upgrade" end


    for k, v in pairs(upgradeObj.upgrades) do
        if v.gobalCheck and not v.gobalCheck() then continue end
        if v.name == upgrade then
            upgradeObj = v
            break
        end
    end

    if not upgradeObj then return false, "Invalid Upgrade" end

    local weaponObj = weapons.Get(weapon)
    if not weaponObj then return false, "No Weapon Data" end
    if upgradeObj.check and not upgradeObj.check(weaponObj) then return false, "Invalid Upgrade" end


    local upgrades = self:GetWeaponMasteryUpgrades(weapon) -- Get the upgrades for the weapon
    local playerUpgrade = upgrades[upgrade] -- Get the upgrade level for the upgrade

    local playerData = self:GetWeaponMastery(weapon) -- Get the player data for the weapon
    if not playerData then return false, "No Weapon Data" end

    playerData.points = tonumber(playerData.points) or 0
    if playerData.points < upgradeObj.cost then return false, "Not Enought Points" end

    self:AddWeaponMasteryPoints(weapon, -upgradeObj.cost) -- Remove the points from the player

    if not playerUpgrade then
        upgrades[upgrade] = 1
    else
        if playerUpgrade >= upgradeObj.maxLevel then return false end
        upgrades[upgrade] = playerUpgrade + 1
    end

    self:SaveWeaponMasteryUpgrades(weapon, upgrades) -- Save the upgrades
    self:ApplyWeaponMastery(self:GetWeapon(weapon)) -- Apply the upgrades to the weapon
    return true, "Upgraded"

end

function ply_meta:ResetWeaponMasteryUpgrades(weapon, findCost)
    if not file.IsDir("neuralstudio/weapon_mastery/upgrades/" .. self:SteamID64(), "DATA") then
        file.CreateDir("neuralstudio/weapon_mastery/upgrades/" .. self:SteamID64())
    end

    local weaponObj = weapons.Get(weapon)
    if not weaponObj then return {} end

    local cost = 0

    if findCost then
        local upgrades = self:GetWeaponMasteryUpgrades(weapon)
        for k, v in pairs(wmastery.upgrade) do
            for k2, v2 in ipairs(v.upgrades) do
                if upgrades[v2.name] then
                    cost = cost + (v2.cost * upgrades[v2.name])
                end
            end
        end
    end

    file.Write("neuralstudio/weapon_mastery/upgrades/" .. self:SteamID64() .. "/" .. weapon .. ".json", "{}")

    return cost
end

net.Receive("wmastery.upgrade", function (len, ply)
    local info = {
        weapon = net.ReadString(),
        type = net.ReadString(),
        upgrade = net.ReadString(),
    }

    local worked, reason = ply:UpgradeWeaponMasteryUpgrade( info.weapon, info.type, info.upgrade )
    local upgrade = {
        upgrade = info.upgrade,
        worked = worked,
        reason = reason
    }
    
    wmastery.openClientUpgrade(ply, upgrade, info.weapon)

end)

