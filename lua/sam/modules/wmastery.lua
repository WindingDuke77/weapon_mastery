if SAM_LOADED then return end

local sam, command, language = sam, sam.command, sam.language

command.set_category("Weapon Mastery")


command.new("AddPoints")
	:SetPermission("addpoints", "superadmin")
    :AddArg("player", {single_target = true})
    :AddArg("text", {hint = "weapon", optional = true})
	:AddArg("number", {hint = "points", optional = true, min = 0, default = 0, round = true})
	:OnExecute(function(ply, targets, weapon, points)
        local target = targets[1]
        local command = target:AddWeaponMasteryPoints(weapon, points)
        weapon = weapons.Get(weapon) and weapons.Get(weapon).PrintName or weapon
        if command then
            sam.player.send_message(nil, "{A} added {V} points to {T}'s " .. weapon .. " Mastery.", {
                A = ply, V = points, T = targets, W = weapon
            })
        else
            sam.player.send_message(nil, "{A} Tried to give Points to {T} but inputted a Invalid Weapon", {
                A = ply, T = targets, W = weapon
            })
        end
	end)
:End()

command.new("SetPoints")
    :SetPermission("setpoints", "superadmin")
    :AddArg("player", {single_target = true})
    :AddArg("text", {hint = "weapon", optional = true})
    :AddArg("number", {hint = "points", optional = true, min = 0, default = 0, round = true})
    :OnExecute(function(ply, targets, weapon, points)
        local target = targets[1]
        local command = target:SetWeaponMasteryPoints(weapon, points)
        weapon = weapons.Get(weapon) and weapons.Get(weapon).PrintName or weapon
        if command then
            sam.player.send_message(nil, "{A} set {T}'s " .. weapon .. " Mastery to {V} points.", {
                A = ply, V = points, T = targets, W = weapon
            })
        else
            sam.player.send_message(nil, "{A} Tried to set Points to {T} but inputted a Invalid Weapon", {
                A = ply, T = targets, W = weapon
            })
        end
    end)
:End()

command.new("AddLevel")
    :SetPermission("addlevel", "superadmin")
    :AddArg("player", {single_target = true})
    :AddArg("text", {hint = "weapon", optional = true})
    :AddArg("number", {hint = "level", optional = true, min = 0, default = 0, round = true})
    :OnExecute(function(ply, targets, weapon, level)
        local target = targets[1]
        local command = target:AddWeaponMasteryLevel(weapon, level)
        weapon = weapons.Get(weapon) and weapons.Get(weapon).PrintName or weapon
        if command then
            sam.player.send_message(nil, "{A} added {V} levels to {T}'s " .. weapon .. " Mastery.", {
                A = ply, V = level, T = targets, W = weapon
            })
        else
            sam.player.send_message(nil, "{A} Tried to give Levels to {T} but inputted a Invalid Weapon", {
                A = ply, T = targets, W = weapon
            })
        end
    end)
:End()

command.new("SetLevel")
    :SetPermission("setlevel", "superadmin")
    :AddArg("player", {single_target = true})
    :AddArg("text", {hint = "weapon", optional = true})
    :AddArg("number", {hint = "level", optional = true, min = 0, default = 0, round = true})
    :OnExecute(function(ply, targets, weapon, level)
        local target = targets[1]
        local command = target:SetWeaponMasteryLevel(weapon, level)
        weapon = weapons.Get(weapon) and weapons.Get(weapon).PrintName or weapon
        if command then
            sam.player.send_message(nil, "{A} set {T}'s " .. weapon .. " Mastery to {V} levels.", {
                A = ply, V = level, T = targets, W = weapon
            })
        else
            sam.player.send_message(nil, "{A} Tried to set Levels to {T} but inputted a Invalid Weapon", {
                A = ply, T = targets, W = weapon
            })
        end
    end)
:End()

command.new("ResetGun")
    :SetPermission("resetgun", "superadmin")
    :AddArg("player", {single_target = true})
    :AddArg("text", {hint = "weapon", optional = true})
    :OnExecute(function(ply, targets, weapon)
        local target = targets[1]
        local command = target:ResetWeaponMastery(weapon)
        weapon = weapons.Get(weapon) and weapons.Get(weapon).PrintName or weapon
        if command then
            sam.player.send_message(nil, "{A} reset {T}'s " .. weapon .. " Mastery.", {
                A = ply, T = targets, W = weapon
            })
        else
            sam.player.send_message(nil, "{A} Tried to reset {T}'s Mastery but inputted a Invalid Weapon", {
                A = ply, T = targets, W = weapon
            })
        end
    end)
:End()

