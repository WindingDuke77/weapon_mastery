wmastery = wmastery or {}
wmastery.config = wmastery.config or {}
wmastery.upgrade = wmastery.upgrade or {}
wmastery.upgrademenu = wmastery.upgrademenu or {}

local config = wmastery.config
local upgrade = wmastery.upgrade
local upgrademenu = wmastery.upgrademenu

local w, h = PIXEL.Scale(1000), PIXEL.Scale(600)

function wmastery.setupWepDetails(weaponMastery, weaponObj)
    local statsToDisplay = {
        ["Kills"] = {
            ["Player Kills"] = upgrademenu.weaponObj.kills or 0,
            ["NPC Kills"] = upgrademenu.weaponObj.npc_kills or 0,
        },
        ["Primary"] =   weaponObj[1],
        ["Secondary"] = weaponObj[2],
    }

    local order = {
        "Kills",
        "Primary",
        "Secondary",
    }
    
    local weaponName = vgui.Create("PIXEL.Label", upgrademenu.details)
    weaponName:Dock(TOP)
    weaponName:DockMargin(5, 0, 0, 5)
    weaponName:SetText(upgrademenu.weapon.PrintName or upgrademenu.weapon)
    weaponName:SetFont("PIXEL.Font.30")
    weaponName:SetTextColor(Color(255, 255, 255))
    local x, y = weaponName:CalculateSize()
    weaponName:SetTall(y)

    local infoLabel = vgui.Create("PIXEL.Label", upgrademenu.details)
    infoLabel:Dock(TOP)
    infoLabel:DockMargin(5, 0, 0, 15)
    infoLabel:SetText("Info")
    infoLabel:SetFont("PIXEL.Font.29")


    local weaponLevel_PointsBackGround = vgui.Create("DPanel", upgrademenu.details)
    weaponLevel_PointsBackGround:Dock(TOP)
    weaponLevel_PointsBackGround:DockMargin(10, 0, 0, 5)
    weaponLevel_PointsBackGround:SetTall(50)
    weaponLevel_PointsBackGround.Paint = function(self, w, h)
        PIXEL.DrawRoundedBox(0, 0, 0, w, h, Color(71, 71, 71, 0))
    end

    local weaponLevel = vgui.Create("PIXEL.Label", weaponLevel_PointsBackGround)
    weaponLevel:Dock(LEFT)
    weaponLevel:DockMargin(5, 0, 5, 0)
    weaponLevel:SetText("Level: " .. weaponMastery.level)
    weaponLevel:SetFont("PIXEL.Font.20")
    weaponLevel:SetTextColor(Color(255, 255, 255))
    local x, y = weaponLevel:CalculateSize()
    weaponLevel:SetWide(x + x / 2)

    local weaponPoints = vgui.Create("PIXEL.Label", weaponLevel_PointsBackGround)
    weaponPoints:Dock(LEFT)
    weaponPoints:DockMargin(15, 0, 0, 0)
    weaponPoints:SetText("Avaliable Points: " .. weaponMastery.points)
    weaponPoints:SetFont("PIXEL.Font.20")
    weaponPoints:SetTextColor(Color(255, 255, 255))
    local x, y = weaponPoints:CalculateSize()
    weaponPoints:SetWide(x)


    weaponLevel_PointsBackGround:SetTall(y)

    local weaponXP = vgui.Create("PIXEL.Label", upgrademenu.details)
    weaponXP:Dock(TOP)
    weaponXP:DockMargin(15, 0, 0, 5)
    weaponXP:SetText("XP: " .. weaponMastery.XP .. " / " .. wmastery.CalcLevelRequirement(weaponMastery.level))
    weaponXP:SetFont("PIXEL.Font.20")
    weaponXP:SetTextColor(Color(255, 255, 255))
    local x, y = weaponXP:CalculateSize()
    weaponXP:SetTall(y)

    local statsLabel = vgui.Create("PIXEL.Label", upgrademenu.details)
    statsLabel:Dock(TOP)
    statsLabel:DockMargin(5, 0, 0, 10)
    statsLabel:SetText("Stats")
    statsLabel:SetFont("PIXEL.Font.29")
    


    local stats = {}
    for k, v in ipairs(order) do
        local statsDetails = statsToDisplay[v]
        stats[v] = {}
        stats[v].Panel = vgui.Create("DPanel", upgrademenu.details)
        stats[v].Panel:Dock(TOP)
        stats[v].Panel:SetTall(50)
        stats[v].Panel:DockMargin(10, 0, 5, 5)
        
        stats[v].Panel.Paint = function(self, w, h)
            PIXEL.DrawRoundedBox(PIXEL.Scale(4), 0, 0, w, h,  PIXEL.Colors.Background)
        end

        stats[v].Label = vgui.Create("PIXEL.Label", stats[v].Panel)
        stats[v].Label:Dock(TOP)
        stats[v].Label:DockMargin(5, 0, 0, 5)
        stats[v].Label:SetText(v)
        stats[v].Label:SetFont("PIXEL.Font.29")
        stats[v].Label:SetTextColor(Color(255, 255, 255))
        local x, y = stats[v].Label:CalculateSize()
        stats[v].Label:SetTall(y)

        stats[v].Left = vgui.Create("DPanel", stats[v].Panel)
        stats[v].Left:Dock(LEFT)
        stats[v].Left:DockMargin(5, 0, 5, 0)
        stats[v].Left:SetWide(w * 0.6 * 0.28)
        stats[v].Left.Paint = function(self, w, h)
            PIXEL.DrawRoundedBox(0, 0, 0, w, h, Color(72, 255, 0, 0))
        end

        stats[v].Right = vgui.Create("DPanel", stats[v].Panel)
        stats[v].Right:Dock(FILL)
        stats[v].Right:DockMargin(5, 0, 5, 0)
        stats[v].Right.Paint = function(self, w, h)
            PIXEL.DrawRoundedBox(0, 0, 0, w, h, Color(72, 255, 0, 0))
        end

        local setTall = 5 + 5 + y + 5

        local i = 0

        for k2, v2 in pairs(statsDetails) do
            
            if  wmastery.validStat(k2, v2) == false then
                continue
            end

            local statLabel = nil 
            if i % 2 == 0 then
                statLabel = vgui.Create("PIXEL.Label", stats[v].Left)
            else
                statLabel = vgui.Create("PIXEL.Label", stats[v].Right)
            end

            statLabel:Dock(TOP)
            statLabel:DockMargin(5, 0, 0, 5)
            statLabel:SetText(k2 .. ": " .. tostring(v2))
            statLabel:SetFont("PIXEL.Font.20")
            statLabel:SetTextColor(Color(255, 255, 255))
            local x, y = statLabel:CalculateSize()
            statLabel:SetTall(y)

            if i % 2 == 0 then
                setTall = setTall + y + 5
            end
            i = i + 1
        end

        // get the children and check that it has more than one else delete it
        local children = #stats[v].Left:GetChildren() + #stats[v].Right:GetChildren()
        if children <= 1 then
            stats[v].Panel:Remove()
            stats[v] = nil
        else 
            stats[v].Panel:SetTall(setTall)
        end
    end

    local optionsLabel = vgui.Create("PIXEL.Label", upgrademenu.details)
    optionsLabel:Dock(TOP)
    optionsLabel:DockMargin(5, 0, 0, 15)
    optionsLabel:SetText("Options")
    optionsLabel:SetFont("PIXEL.Font.29")
    local x, y = optionsLabel:CalculateSize()
    optionsLabel:SetTall(y)

    local resetPointsButton = vgui.Create("PIXEL.TextButton", upgrademenu.details)

    resetPointsButton:Dock(TOP)
    resetPointsButton:DockMargin(15, 0, 15, 5)
    resetPointsButton:SetText("Reset Points")
    resetPointsButton:SetFont("PIXEL.Font.20")
    resetPointsButton:SizeToText()

    resetPointsButton.DoClick = function()
        net.Start("wmastery-reset-upgrades")
        net.WriteString(weaponMastery.weapon)
        net.SendToServer()
    end
end

function wmastery.validStat(key, value)
    if ( string.len ( tostring ( key ) ) >= 13 ) then               return false end
    if ( string.len ( tostring ( key ) ) < 2 ) then                 return false end
    if ( key == "Sound" ) then                                      return false end
    if ( string.StartWith ( string.lower(key), "use" ) ) then       return false end

    if ( string.len ( tostring ( value ) ) >= 10 ) then             return false end
    if ( type ( value ) == "table" ) then                           return false end
    if ( type ( value ) == "function" ) then                        return false end
    if ( type ( value ) == "Vector" ) then                          return false end
    if ( type ( value ) == "Angle" ) then                           return false end
    if ( type ( value ) == "Player" ) then                          return false end
    if ( type ( value ) == "Entity" ) then                          return false end
    if ( type ( value ) == "Weapon" ) then                          return false end
    if ( type ( value ) == "String" ) then                          return false end
    if ( value == "none" ) then                                     return false end
    if ( value == -1 ) then                                         return false end
    if ( value == "" ) then                                         return false end
    if ( string.len ( tostring ( value ) ) >= 10 ) then             return false end

    return true
end
