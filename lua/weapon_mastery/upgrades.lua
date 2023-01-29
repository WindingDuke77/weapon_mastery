// This Addon was created by:
// Bob Bobington#2947
// 
// any questions, please contact me

wmastery = wmastery or {}
wmastery.upgrade = wmastery.upgrade or {}
local upgrade = wmastery.upgrade
 
// Do not above this line.

upgrade.Primary = {} // For the primary weapon ammo and its settings

upgrade.Primary = {
    gobalCheck = function(wep)
        if wep.Primary then
            return true
        end
        return false
    end,
    upgrades = {
        {
            name = "Increase Primary Damage",
            desc = "Increase the damage of the weapon by 10%.",
            cost = 5,
            maxLevel = 5,
            type = "Attribute",
            Attribute = {
                name = "Damage",
                value = 10,
                type = "Percent",
                location = "Primary",
                Round = true,
            },
            check = function(wep)
                if wep.Primary.Damage then
                    return true
                end
                return false
            end
        },
        {
            name = "Decrease Primary Recoil",
            desc = "Decrease the recoil of the weapon by 10%.",
            cost = 2,
            maxLevel = 5,
            type = "Attribute",
            Attribute = {
                name = "Recoil",
                value = 10,
                type = "Percent",
                location = "Primary",
                invert = true 
            },
            check = function(wep)
                if wep.Primary.Recoil then
                    return true
                end
                return false
            end
        },
        {
            name = "Increase Primary Clip Size",
            desc = "Increase the clip size of the weapon by 10%.",
            cost = 2,
            maxLevel = 5,
            type = "Attribute",
            Attribute = {
                name = "ClipSize",
                value = 10,
                type = "Percent",
                location = "Primary",
                Round = true
            },
            check = function(wep)
                if wep.Primary.ClipSize and wep.Primary.ClipSize > 1 then
                    return true
                end
                return false
            end
        },
        {
            name = "Increase Primary Fire Rate",
            desc = "Increase the fire rate of the weapon by 10%.",
            cost = 5,
            maxLevel = 5,
            type = "Attribute",
            Attribute = {
                name = "Delay",
                value = 5,
                type = "Percent",
                location = "Primary",
                invert = true 
            },
            check = function(wep)
                if wep.Primary.Delay and wep.Primary.Delay > 0 then
                    return true
                end
                return false
            end

        },
        {
            name = "Primary Multishot",
            desc = "Increase the amount of bullets fired by 1.",
            cost = 10,
            maxLevel = 3,
            type = "Attribute",
            Attribute = {
                name = "NumShots",
                value = 1,
                type = "Add",
                location = "Primary",
                Round = true
            },
            check = function(wep)
                if wep.Primary.NumShots and wep.Primary.NumShots > 1 then
                    return true
                end
                return false
            end
        },
        {
            name = "Increase Primary RPM",
            desc = "Increase the RPM of the weapon by 10%.",
            cost = 5,
            maxLevel = 5,
            type = "Attribute",
            Attribute = {
                name = "RPM",
                value = 10,
                type = "Percent",
                location = "Primary",
                invert = false  
            },
            check = function(wep)
                if wep.Primary.RPM and wep.Primary.RPM > 0 then
                    return true
                end
                return false
            end
        }
    }
}

upgrade.Secondary = {} // For the secondary weapon ammo and its settings

upgrade.Secondary = {
    gobalCheck = function(wep)
        if wep.Secondary then
            return true
        end
        return false
    end,
    upgrades = {
        {
            name = "Increase Secondary Damage",
            desc = "Increase the damage of the weapon by 10%.",
            cost = 5,
            maxLevel = 5,
            type = "Attribute",
            Attribute = {
                name = "Damage",
                value = 10,
                type = "Percent",
                location = "Secondary",
                Round = true,
            },
            check = function(wep)
                if wep.Secondary.Damage then
                    return true
                end
                return false
            end
        },
        {
            name = "Decrease Secondary Recoil",
            desc = "Decrease the recoil of the weapon by 10%.",
            cost = 2,
            maxLevel = 5,
            type = "Attribute",
            Attribute = {
                name = "Recodil",
                value = 10,
                type = "Percent",
                location = "Secondary",
                invert = true 
            },
            check = function(wep)
                if wep.Secondary.Recoil then
                    return true
                end
                return false
            end
        },
        {
            name = "Increase Secondary Clip Size",
            desc = "Increase the clip size of the weapon by 10%.",
            cost = 2,
            maxLevel = 5,
            type = "Attribute",
            Attribute = {
                name = "ClipSize",
                value = 10,
                type = "Percent",
                location = "Secondary",
                Round = true
            },
            check = function(wep)
                if wep.Secondary.ClipSize and wep.Secondary.ClipSize > 1 then
                    return true
                end
                return false
            end
        },
        {
            name = "Increase Secondary Fire Rate",
            desc = "Increase the fire rate of the weapon by 10%.",
            cost = 5,
            maxLevel = 5,
            type = "Attribute",
            Attribute = {
                name = "Delay",
                value = 5,
                type = "Percent",
                location = "Secondary",
                invert = true 
            },
            check = function(wep)
                if wep.Secondary.Delay and wep.Secondary.Delay > 0 then
                    return true
                end
                return false
            end
        },
        {
            name = "Increase Secondary RPM",
            desc = "Increase the RPM of the weapon by 10%.",
            cost = 5,
            maxLevel = 5,
            type = "Attribute",
            Attribute = {
                name = "RPM",
                value = 10,
                type = "Percent",
                location = "Secondary",
                invert = false  
            },
            check = function(wep)
                if wep.Secondary.RPM and wep.Secondary.RPM > 0 then
                    return true
                end
                return false
            end
        }
    }
}


