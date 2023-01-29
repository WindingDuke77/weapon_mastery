# How to make a upgrades

All the following code will need to be inside `garrymod/addons/weapon_mastery/lua/weapon_mastery/upgrades.lua` for it to work

## Creating a new catergory

To create a new catergory do the following

```lua
upgrade["Name You want"] = {}

upgrade["Name You want"] = {
	gobalCheck = function (wep) -- Check if a gun can be upgraded from this catergory
		return true
	end,
	upgrades = {
		// upgrades go here
	}
}

```

## Creating a new Upgrade

The following is a upgrade object, this will need to be put inside of upgrades inside of a catergory

\*\* = Required

Attributes upgrade

```lua
{
	name = "Name of the upgrade", -- **
    desc = "Description of the upgrade", -- **
    cost = 5, -- Cost of the upgrade in points -- **
    maxLevel = 5, -- How many times can this upgrade be bought -- **
    type = "Attribute", -- Type of upgrade. Can be "Attribute" or "func" -- **
    Attribute = {
        name = "Damage", -- Name of variable to change  -- **
        value = 10, -- Value to change the variable by  -- **
        type = "Percent", -- Type of change. Can be "Bool", "Add", "Percent", "String" -- **
        location = "Secondary", -- what table to change the variable in. -- **
        Round = true, -- Round the value to the nearest whole number
        invert = false, -- Invert the value (if type is Percent)
    },
    check = function(wep) -- Check if a gun can be upgraded from this upgrade
        if wep.Secondary.Damage then
            return true
        end
        return false
    end
}
```

Function upgrade

```lua
{
	name = "Name of the upgrade", -- **
    desc = "Description of the upgrade", -- **
    cost = 5, -- Cost of the upgrade in points -- **
    maxLevel = 5, -- How many times can this upgrade be bought -- **
    type = "func", -- Type of upgrade. Can be "Attribute" or "func" -- **
    func = function(wep, level) -- Function is ran when ever the upgrades are applied
        -- Do stuff
        -- the function is only ran once so you will use level to check what level the upgrade is
    end,
    check = function(wep) -- Check if a gun can be upgraded from this upgrade
        if wep.Secondary.Damage then
            return true
        end
        return false
    end
}
```
