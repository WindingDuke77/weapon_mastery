// This Addon was created by:
// Bob Bobington#2947
// 
// any questions, please contact me

wmastery = wmastery or {}
wmastery.config = wmastery.config or {}
wmastery.SQL = wmastery.SQL or {}
local config = wmastery.config
 
// Do not above this line.

function wmastery.CalcLevelRequirement(level)
    return math.Round(100 * (level ^ 2.5))
end

function wmastery.LevelsUpAmount(xp, level)
    local amount = 0
    local leftOverXp = 0
    local currentLevel = level
    local levelRequirement = wmastery.CalcLevelRequirement(currentLevel)

    while xp >= levelRequirement do
        xp = xp - levelRequirement
        amount = amount + 1
        currentLevel = currentLevel + 1
        levelRequirement = wmastery.CalcLevelRequirement(currentLevel)
    end

    return amount, xp

end

function wmastery.GetValidUpgrades(wep)
    local validUpgrades = {}

    for k, v in pairs(wmastery.upgrade) do
        if v.gobalCheck and not v.gobalCheck(wep) then continue end
        for k2, v2 in ipairs(v.upgrades) do
            if v2.check and not v2.check(wep) then continue end
            v2.catergory = k
            table.insert(validUpgrades, v2)
        end
    end

    return validUpgrades
end
