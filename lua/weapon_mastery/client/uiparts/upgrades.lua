wmastery = wmastery or {}
wmastery.config = wmastery.config or {}
wmastery.upgrade = wmastery.upgrade or {}
wmastery.upgrademenu = wmastery.upgrademenu or {}

local config = wmastery.config
local upgrade = wmastery.upgrade
local upgrademenu = wmastery.upgrademenu

function wmastery.loadUpgrades(validUpgrades, playerUpgrades, upgradeDetails)
    wmastery.upgrademenu.buttons = {}
    for k, v in pairs(validUpgrades) do
        wmastery.upgrademenu.buttons[v.name] = {}
        local upgrade = wmastery.upgrademenu.buttons[v.name] 
        upgrade.main = vgui.Create("DPanel")
        upgrade.main:Dock(TOP)
        upgrade.main:DockMargin(0, 0, 5, 5)
        upgrade.main:SetTall(60)

        local brackets = " ( " .. (playerUpgrades[v.name] or 0).. " / " .. v.maxLevel .. " )"

        upgrade.main.Paint = function(self, w, h)
            PIXEL.DrawRoundedBox(0, 0, 0, w, h, PIXEL.Colors.Header)
            PIXEL.DrawText(v.name .. brackets, "PIXEL.Font.20", 5, 5, Color(255, 255, 255))
            PIXEL.DrawText(v.desc, "PIXEL.Font.15", 5, 30, Color(105, 105, 105))
        end

        upgrade.button = vgui.Create("PIXEL.TextButton", upgrade.main)
        upgrade.button:Dock(RIGHT)
        upgrade.button:SetWide(120)
        upgrade.button:SetText("Upgrade")
        upgrade.button.DisabledCol = PIXEL.CopyColor(PIXEL.Colors.Negative)
        function upgrade.button:OnCursorEntered()
            if upgrade.button.override then return end
            upgrade.button:SetText(v.cost .. " points")
        end
        function upgrade.button:OnCursorExited()
            if upgrade.button.override then return end
            upgrade.button:SetText("Upgrade")
        end

        if playerUpgrades[v.name] and playerUpgrades[v.name] >= v.maxLevel then
            upgrade.button:SetEnabled(false)
            upgrade.button:SetText("Max Level")
            upgrade.button.override = true 
        end

        function upgrade.button:DoClick()
            net.Start("wmastery.upgrade")
                net.WriteString(upgrademenu.weaponObj.weapon)
                net.WriteString(v.catergory)
                net.WriteString(v.name)
            net.SendToServer()
        end

        upgrademenu.upgrades:AddItem(upgrade.main)
    end

    if upgradeDetails.reason then
        local button = wmastery.upgrademenu.buttons[upgradeDetails.upgrade]

        if not upgradeDetails.worked then 
            button.button.NormalCol = Color(165, 0, 0)
            button.button.HoverCol = PIXEL.OffsetColor(button.button.NormalCol, -30)
            button.button.override = true
            button.button:SetText(upgradeDetails.reason)
        else
            button.button:SetText("Upgraded")
            button.button.NormalCol = Color(0, 165, 0)
            button.button.HoverCol = PIXEL.OffsetColor(button.button.NormalCol, -30)
            button.button.override = true
        end

        button.button:SetFont("PIXEL.Font.15")

        timer.Create("upgraded-button", 3, 1, function()
            if not button.button:IsEnabled() then return button.button:SetText("Max Level") end
            button.button.override = false 
            button.button:SetText("Upgrade")
            button.button.NormalCol = PIXEL.CopyColor(PIXEL.Colors.Primary)
            button.button.HoverCol = PIXEL.OffsetColor(button.button.NormalCol, -15)  
            button.button:SetFont("UI.TextButton")
            
        end)

    end
end
