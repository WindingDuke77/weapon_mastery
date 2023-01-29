local catergory_name = "Weapon Mastery"

local function addpointsFunc(calling, target, weapon, amount)
    local command = target:AddWeaponMasteryPoints(weapon, amount)
    weapon = weapons.Get(weapon) and weapons.Get(weapon).PrintName or weapon
    if command then
        ulx.fancyLogAdmin( calling, "#A added #i points to #T #s Mastery.", amount, target, weapon  )
    else
        ULib.tsayError( calling, "Invalid Gun", true )
    end
    
end
local addpoints = ulx.command( catergory_name, "ulx addpoints", addpointsFunc, "!addpoints" )
addpoints:addParam{ type=ULib.cmds.PlayerArg }
addpoints:addParam{ type=ULib.cmds.StringArg, hint="Gun Id", error="No Gun Specified", completes=ulx.weapon_completion }
addpoints:addParam{ type=ULib.cmds.NumArg, hint="amount", ULib.cmds.round }
addpoints:help( "Gives a player weapon mastery points." )
addpoints:defaultAccess( ULib.ACCESS_SUPERADMIN )

local function setpointsFunc(calling, target, weapon, amount)
    local command = target:SetWeaponMasteryPoints(weapon, amount)
    weapon = weapons.Get(weapon) and weapons.Get(weapon).PrintName or weapon
    if command then
        ulx.fancyLogAdmin( calling, "#A set #T #s Mastery to #i.", target, weapon, amount )
    else
        ULib.tsayError( calling, "Invalid Gun", true )
    end
end
local setpoints = ulx.command( catergory_name, "ulx setpoints", setpointsFunc, "!setpoints" )
setpoints:addParam{ type=ULib.cmds.PlayerArg }
setpoints:addParam{ type=ULib.cmds.StringArg, hint="Gun Id", error="No Gun Specified", completes=ulx.weapon_completion }
setpoints:addParam{ type=ULib.cmds.NumArg, hint="amount", ULib.cmds.round }
setpoints:help( "Sets a players weapon mastery points." )
setpoints:defaultAccess( ULib.ACCESS_SUPERADMIN )

local function addlevelFunc(calling, target, weapon, amount)
    local command = target:AddWeaponMasteryLevel(weapon, amount)
    weapon = weapons.Get(weapon) and weapons.Get(weapon).PrintName or weapon
    if command then
        ulx.fancyLogAdmin( calling, "#A added #i levels to #T #s Mastery.", amount, target, weapon  )
    else
        ULib.tsayError( calling, "Invalid Gun", true )
    end
    
end
local addlevel = ulx.command( catergory_name, "ulx addlevel", addlevelFunc, "!addlevel" )
addlevel:addParam{ type=ULib.cmds.PlayerArg }
addlevel:addParam{ type=ULib.cmds.StringArg, hint="Gun Id", error="No Gun Specified", completes=ulx.weapon_completion }
addlevel:addParam{ type=ULib.cmds.NumArg, hint="amount", ULib.cmds.round }
addlevel:help( "Gives a player weapon mastery levels." )
addlevel:defaultAccess( ULib.ACCESS_SUPERADMIN )

local function setlevelFunc(calling, target, weapon, amount)
    local command = target:SetWeaponMasteryLevel(weapon, amount)
    weapon = weapons.Get(weapon) and weapons.Get(weapon).PrintName or weapon
    if command then
        ulx.fancyLogAdmin( calling, "#A set #T #s Mastery to #i.", target, weapon, amount )
    else
        ULib.tsayError( calling, "Invalid Gun", true )
    end
end
local setlevel = ulx.command( catergory_name, "ulx setlevel", setlevelFunc, "!setlevel" )
setlevel:addParam{ type=ULib.cmds.PlayerArg }
setlevel:addParam{ type=ULib.cmds.StringArg, hint="Gun Id", error="No Gun Specified", completes=ulx.weapon_completion }
setlevel:addParam{ type=ULib.cmds.NumArg, hint="amount", ULib.cmds.round }
setlevel:help( "Sets a players weapon mastery levels." )
setlevel:defaultAccess( ULib.ACCESS_SUPERADMIN )

local function ResetGunFunc(calling, target, weapon)
    local command = target:ResetWeaponMastery(weapon)
    weapon = weapons.Get(weapon) and weapons.Get(weapon).PrintName or weapon
    if command then
        ulx.fancyLogAdmin( calling, "#A reset #T #s Mastery.", target, weapon )
    else
        ULib.tsayError( calling, "Invalid Gun", true )
    end
end
local resetpoints = ulx.command( catergory_name, "ulx restgun", ResetGunFunc, "!restgun" )
resetpoints:addParam{ type=ULib.cmds.PlayerArg }
resetpoints:addParam{ type=ULib.cmds.StringArg, hint="Gun Id", error="No Gun Specified", completes=ulx.weapon_completion }
resetpoints:help( "Resets a players weapon mastery points." )
resetpoints:defaultAccess( ULib.ACCESS_SUPERADMIN )


