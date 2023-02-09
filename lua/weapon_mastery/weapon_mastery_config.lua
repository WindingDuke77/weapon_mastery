// This Addon was created by:
// Bob Bobington#2947
// 
// any questions, please contact me

wmastery = wmastery or {}
wmastery.config = wmastery.config or {}
local config = wmastery.config
 
// Do not above this line.

config.openKey = KEY_F6 // Key to open the menu. (https://wiki.facepunch.com/gmod/Enums/KEY)

config.Blacklist = { // Weapons that are not allowed to be used for leveling up. (case sensitive)
    ["weapon_physcannon"] = true,
    ["weapon_physgun"] = true,
    ["gmod_tool"] = true,
    ["keys"] = true,
    ["gmod_camera"] = true,
    ["itemstore_pickup"] = true 
}

config.BlacklistCatergorys = { // Weapons that are not allowed to be used for leveling up. (case sensitive)
    ["Half-Life 2"] = true, // DO NOT Remove, HL2 weapons cant be modified
    ["DarkRP (Utility)"] = true,
}

config.XPAmount = { // Amount XP given Per Action
    ["NPC Kill"] = 10,
    ["Player Kill"] = 50,
}

// NOTE: The following will stack. So if you have a rank modifier of 2 and a weapon modifier of 1.5, it will be 3.
config.LevelUpModifier = 1.5 // How easy it is to level up. 1.5 is the default

config.WeaponModifier = { // makes it easier or harder to level up with a certain weapon. 1 is default. 0.5 is half as fast, 2 is twice as fast.
    // ["weapon_class"] = modifier
    ["weapon_ak47"] = 0.5,
}

config.RankModifier = { // makes it easier or harder to level up with a certain rank. 1 is default. 0.5 is half as fast, 2 is twice as fast.
    // ["Rank"] = modifier
    ["moderator"] = 1.5,
    ["admin"] = 2,
    ["superadmin"] = 3,
    ["vip"] = 1.2,
    ["vip+"] = 1.1,
}