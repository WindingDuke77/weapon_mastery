// This Addon was created by:
// Bob Bobington#2947
// 
// any questions, please contact me

wmastery = wmastery or {}
wmastery.config = wmastery.config or {}
local config = wmastery.config
 
// Do not above this line.
hook.Add("OnNPCKilled", "wmastery-OnNPCKilled", function(npc, attacker, inflictor)
    if not attacker:IsPlayer() then return end

    local ply = attacker
    local plyWep = ply:GetActiveWeapon()

    if not plyWep:IsValid() then return end

    local wepClass = plyWep:GetClass()

    ply:AddWeaponMasteryKills(wepClass, 1, true /* isNPC */)
    ply:AddWeaponMasteryXP(wepClass, config.XPAmount["NPC Kill"])
end)

hook.Add("PlayerDeath", "wmastery-PlayerDeath", function(victim, inflictor, attacker)
    if not attacker:IsPlayer() then return end

    local ply = attacker
    local plyWep = ply:GetActiveWeapon()

    if not plyWep:IsValid() then return end

    local wepClass = plyWep:GetClass()

    ply:AddWeaponMasteryKills(wepClass, 1)
    ply:AddWeaponMasteryXP(wepClass, config.XPAmount["Player Kill"])
end)

hook.Add("PlayerButtonUp", "wmastery-openUpgrade", function(ply, key)
    if key ~= config.openKey then return end 
    wmastery.openClientUpgrade(ply)
end)
