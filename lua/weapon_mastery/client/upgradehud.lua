wmastery = wmastery or {}
wmastery.config = wmastery.config or {}
wmastery.upgrade = wmastery.upgrade or {}
wmastery.upgrademenu = wmastery.upgrademenu or {}

local config = wmastery.config
local upgrade = wmastery.upgrade
local upgrademenu = wmastery.upgrademenu

local w, h = PIXEL.Scale(1000), PIXEL.Scale(600)

function wmastery.openUpgrade(tbl, tbl2, tbl3, tbl4)
    upgrademenu.weaponObj = table.Copy(tbl)
    upgrademenu.weapon = LocalPlayer():GetWeapon(tbl.weapon)
    if not upgrademenu.weapon then return GAMEMODE:AddNotify("Error Getting Weapon Data", 1, 5) end
    local validUpgrades = wmastery.GetValidUpgrades(upgrademenu.weapon)
    if not validUpgrades or #validUpgrades <= 0 or validUpgrades == {} then return GAMEMODE:AddNotify("No Valid Upgrades for this Weapon", 1, 5) end

    upgrademenu.frame = vgui.Create("PIXEL.Frame")
    upgrademenu.frame:SetSize(w, h)
    upgrademenu.frame:Center()
    upgrademenu.frame:SetTitle((upgrademenu.weapon.PrintName or upgrademenu.weapon) .. " - Upgrades")
    upgrademenu.frame:MakePopup()
    function upgrademenu.frame:OnClose()
        upgrademenu.frame = nil
        if timer.Exists("upgraded-button") then
            timer.Remove("upgraded-button")
        end
    end
    function upgrademenu.frame:OnKeyCodeReleased( keyCode )
        if keyCode == config.openKey then  
            upgrademenu.frame:Close()
        end
    end
    

    // upgrades on the left

    upgrademenu.upgrades = vgui.Create("PIXEL.ScrollPanel", upgrademenu.frame)
    upgrademenu.upgrades:Dock(LEFT)
    upgrademenu.upgrades:SetWide(w * 0.6)
    upgrademenu.upgrades.Paint = function(self, w, h)
        PIXEL.DrawRoundedBox(0, 0, 0, w, h, Color(224, 224, 224, 0))
    end

    upgrademenu.details = vgui.Create("PIXEL.ScrollPanel", upgrademenu.frame)
    upgrademenu.details:Dock(FILL)
    upgrademenu.details.Paint = function(self, w, h)
        PIXEL.DrawRoundedBox(PIXEL.Scale(4), 0, 0, w, h, PIXEL.Colors.Header)
    end

    wmastery.loadUpgrades(validUpgrades, tbl2, tbl3)

    wmastery.setupWepDetails(tbl, tbl4)
end

net.Receive("wmastery.openUpgrade-reply", function()

    local dataLength = net.ReadInt(32)
    local tbl = net.ReadData(dataLength)
    tbl =  util.Decompress(tbl)
    tbl = util.JSONToTable(tbl)

    if upgrademenu.frame then
        upgrademenu.frame:Remove()
        upgrademenu.frame = nil
    end
    if timer.Exists("upgraded-button") then
        timer.Remove("upgraded-button")
    end

    wmastery.openUpgrade(tbl.wepMastery, tbl.wepUpgrades, tbl.upgrade, tbl.wepDetails)
end)
