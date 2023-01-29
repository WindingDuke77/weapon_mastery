// This Addon was created by:
// Bob Bobington#2947
// 
// any questions, please contact me

wmastery = wmastery or {}
wmastery.config = wmastery.config or {}
local config = wmastery.config
 
// Do not above this line.
local ply_meta = FindMetaTable("Player")


function ply_meta:ApplyWeaponMastery(weapon)
    timer.Simple(0, function () // This is to make sure the weapon is fully loaded before applying the upgrades.
        if not IsValid(weapon) then return end
        if not weapon:IsWeapon() then return end
        local wepClass = weapon:GetClass()
        local upgrades = self:GetWeaponMasteryUpgrades(wepClass)
        if not upgrades then return end
        if table.Count(upgrades) == 0 then return end

        local upgradesNames = {}
        for k, v in pairs(upgrades) do
            upgradesNames[k] = true 
        end
        local foundUpgrades = {}

        for k, v in pairs(wmastery.upgrade) do // upgrade types ( Primary, Secondary, Melee, etc. )
            for k2, v2 in ipairs(v.upgrades) do // upgrades ( Damage, Accuracy, etc. )
                if upgradesNames[v2.name] then
                    table.insert(foundUpgrades, {
                        catergory = k,
                        upgrade = k2,
                    })
                end
            end
        end
        if #foundUpgrades == 0 then return  end


        self:ApplyWeaponMasteryUpgrade(weapon, upgrades, foundUpgrades)
    end)
end
local i = 0

function wmastery.applyAttribute(wep, upgrade, level)
    local attributeObj = upgrade.Attribute
    local attribute = wep[attributeObj.location]
    attribute = attribute[attributeObj.name]
    if attribute == nil then return end

    local statLocation = { attributeObj.location, attributeObj.name }

    if attributeObj.type == "Bool" then
        wep[attributeObj.location][attributeObj.name] = attributeObj.value
        return wmastery.applyTFAStat(wep, statLocation, attributeObj.value)
    end

    if attributeObj.type == "String" then
        wep[attributeObj.location][attributeObj.name] = attributeObj.value
        return wmastery.applyTFAStat(wep, statLocation, attributeObj.value)
    end

    local newNumber = attribute

    local decmial = false 
    // check if the number is a decimal
    if newNumber % 1 ~= 0 then
        decmial = true
        newNumber = newNumber * 10000
    end

    if attributeObj.type == "Add" then
        newNumber = newNumber + attributeObj.value * level
    elseif attributeObj.type == "Percent" then
        local precent = attributeObj.value * level / 100 
        if attributeObj.invert then
            precent = 1 - precent
        else
            precent = 1 + precent
        end
        newNumber = newNumber * precent
    elseif attributeObj.type == "Multiple" then
        newNumber = newNumber * (attributeObj.value * level)
    end

    if attributeObj.Round then
        newNumber = math.Round(newNumber)
    end

    if decmial then
        newNumber = newNumber / 10000
    end

    wep[attributeObj.location][attributeObj.name] = newNumber
    wmastery.applyTFAStat(wep, statLocation, newNumber)
end

function wmastery.applyTFAStat(weapon, location, newVar)
    local tfaLocation = location[1] .. "_TFA"
    if not weapon[tfaLocation] then return end
    weapon[tfaLocation][location[2]] = newVar
    weapon:ClearStatCache(location[1] .. "." .. location[2])
end

function ply_meta:ApplyWeaponMasteryUpgrade(weapon, upgrades, foundUpgrades)
    if not foundUpgrades then return end
    if table.Count(foundUpgrades) == 0 then return end

    self:ResetWeapon(weapon)
    timer.Simple(0, function ()
        weapon = self:GetWeapon(weapon:GetClass())
        self:SelectWeapon( weapon:GetClass() )

        for k, v in ipairs(foundUpgrades) do
            local upgrade = wmastery.upgrade[v.catergory]
            if not upgrade then continue end
            upgrade = upgrade.upgrades[v.upgrade]
            if not upgrade then continue end

            local level = upgrades[upgrade.name]
            if not level then continue end

            if upgrade.type == "func" then
                upgrade.func(weapon, level)
            elseif upgrade.type == "Attribute" then
                wmastery.applyAttribute(weapon, upgrade, level)
            end
        end

        weapon.Wmastery_NotOriginal = true 
    end)
end

function ply_meta:ResetWeapon(weapon)
    if not weapon then return end
    if not weapon.Wmastery_NotOriginal then return end

    self:StripWeapon(weapon:GetClass())
    local weapon = self:Give(weapon:GetClass())
    weapon.Wmastery_Given = true
end


function ply_meta:ApplyAllWeaponMastery()
    local weps = self:GetWeapons()
    for k, v in ipairs(weps) do
        self:ApplyWeaponMastery(v)
    end
end

hook.Add("PlayerSpawn", "wmastery_applyAll", function(ply, transition)
    ply:ApplyAllWeaponMastery()
end)

hook.Add("WeaponEquip", "wmastery_apply", function(wep, ply)
    timer.Simple(0, function ()
        if wep.Wmastery_Given then return end
        ply:ApplyWeaponMastery(wep)
    end)

end)

