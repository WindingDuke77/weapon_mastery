// This Addon was created by:
// Bob Bobington#2947
// 
// any questions, please contact me

wmastery = wmastery or {}
wmastery.config = wmastery.config or {}
local config = wmastery.config
 
// Do not above this line.
util.AddNetworkString("wmastery.openUpgrade-reply")
util.AddNetworkString("wmastery.upgrade")
util.AddNetworkString("wmastery.upgrade-reply")



local function sendClientUpgrade(ply, upgrade, wepClass)
    if wepClass then
        weapon = ply:GetWeapon(wepClass) 
    else 
        weapon = ply:GetActiveWeapon()
        wepClass = weapon:GetClass()
    end
    if not wepClass then return end

    

    local wepMastery = ply:GetWeaponMastery(wepClass)
    if not wepMastery then return wmastery.notify(ply, 1, 5, "This weapon is blacklisted from Weapon Mastery") end

    local wepUpgrades = ply:GetWeaponMasteryUpgrades(wepClass)

    local allInfo = {
        wepMastery = wepMastery,
        wepUpgrades = wepUpgrades,
        upgrade = upgrade or {},
        wepDetails = {
            wmastery.sanitiseTable(weapon.Primary),
            wmastery.sanitiseTable(weapon.Secondary),
        }
    }

    allInfo = util.TableToJSON(allInfo)
    allInfo = util.Compress(allInfo)

    net.Start("wmastery.openUpgrade-reply")
        net.WriteInt(#allInfo, 32)
        net.WriteData(allInfo, #allInfo)
    net.Send(ply)
end

function wmastery.openClientUpgrade(ply, upgrade, wepClass)
    timer.Simple(0.3, function() // a small delay to make sure the weapon is ready

        sendClientUpgrade(ply, upgrade, wepClass)

    end)
end

function wmastery.sanitiseTable(table)

    for k, v in pairs(table) do
        if type(v) == "table" then table[k] = nil continue end
        if type(v) == "function" then table[k] = nil continue end
        if type(v) == "Entity" then table[k] = nil continue end
        if type(v) == "Player" then table[k] = nil continue end
        if type(v) == "Weapon" then table[k] = nil continue end
        if type(v) == "Vector" then table[k] = nil continue end
        if type(v) == "Angle" then table[k] = nil continue end
    end

    return table
end