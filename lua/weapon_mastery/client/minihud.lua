wmastery = wmastery or {}
wmastery.config = wmastery.config or {}
local config = wmastery.config

net.Receive("wmastery-update-level/xp", function ()
    local weaponTable = net.ReadTable()
    wmastery.miniHudShow = true
    wmastery.miniHudWeapon = weaponTable
    wmastery.miniHudStart = SysTime()
    timer.Simple(7, function ()
        wmastery.miniHudShow = false
    end)
    
end)


surface.CreateFont("wmastery-titleFont", {
    font = "Cascadia Mono",
    size = 30,
    weight = 500,
    antialias = true,
    shadow = false
})

local function drawHud()
    if not wmastery.miniHudShow then return end

    local weaponTable = wmastery.miniHudWeapon or {}
    if not weaponTable.weaponName then return end

    weaponTable = {
        prevLevel = tonumber(weaponTable.prevLevel) or 0,
        newLevel = tonumber(weaponTable.newLevel) or 0,
        prevXP = tonumber(weaponTable.prevXP) or 0,
        newXP = tonumber(weaponTable.newXP) or 0,
        weaponName = weaponTable.weaponName or "Unknown"
    }

    local x, y = ScrW() / 1.23, ScrH() - ScrH() / 1.01
    local w, h = ScrW() / 6, ScrH() / 10

    local backgroundAlpha = Lerp((SysTime() - wmastery.miniHudStart ) / 5, 0, 255)
    backgroundAlpha = backgroundAlpha * 3
   
    draw.RoundedBox(0, x, y, w, h, Color(83, 83, 83, 0))

    weaponTable.weaponName = string.upper(string.sub(weaponTable.weaponName, 1, 1)) .. string.sub(weaponTable.weaponName, 2, string.len(weaponTable.weaponName))

    local text = "Level " .. weaponTable.newLevel
    if weaponTable.prevLevel < weaponTable.newLevel then
        text = "Level " .. weaponTable.prevLevel .. " -> " .. weaponTable.newLevel .. "!"
    end

    surface.SetFont("wmastery-titleFont")
    local textX, textY = surface.GetTextSize(weaponTable.weaponName)
    draw.SimpleText(weaponTable.weaponName, "wmastery-titleFont", x , y + h / 10, Color(255, 255, 255, backgroundAlpha), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

    local textX, textY = surface.GetTextSize(text)
    // align right
    draw.SimpleText(text, "wmastery-titleFont", x + w, y + h / 10, Color(255, 255, 255, backgroundAlpha), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)


    // draw a bar
    local barX, barY = x + x / 200, y + h / 10 * 4
    local barW, barH = w - w / 15, h / 7

    // draw bar with outline
    draw.RoundedBox(barW / 10, barX - 5, barY - 2.5, barW + 10, barH + 5, Color(83, 83, 83, backgroundAlpha))
    draw.RoundedBox(barW / 5, barX + barW / 120, barY + barH / 10, barW - barW / 60, barH - barH / 5, Color(255, 255, 255, backgroundAlpha))

    // draw bar with xp
    local oldXpPerecent = weaponTable.prevXP /  wmastery.CalcLevelRequirement(weaponTable.prevLevel) 
    local newXpPerecent = weaponTable.newXP /   wmastery.CalcLevelRequirement(weaponTable.newLevel) 

    if newXpPerecent > 1 then
        newXpPerecent = 1
    end

    if weaponTable.prevLevel < weaponTable.newLevel then
        oldXpPerecent = 0
    end

    local xpPercent = Lerp((SysTime() - wmastery.miniHudStart ) / 3, oldXpPerecent, newXpPerecent)

    draw.RoundedBox(barW / 5, barX + barW / 120, barY + barH / 10, (barW - barW / 60) * (xpPercent ), barH - barH / 5, Color(0, 255, 34, backgroundAlpha))


    

end

hook.Add("HUDPaint", "wmastery-hud", drawHud)