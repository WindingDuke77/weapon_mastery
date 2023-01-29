wmastery = wmastery or {}
wmastery.config = wmastery.config or {}
wmastery.upgrade = wmastery.upgrade or {}
local config = wmastery.config
local upgrade = wmastery.upgrade

function wmastery.CreateFonts()
    PIXEL.RegisterFont("PIXEL.Font.20", "Montserrat Bold", 20)
    PIXEL.RegisterFont("PIXEL.Font.15", "Montserrat Bold", 15)
    PIXEL.RegisterFont("PIXEL.Font.30", "Montserrat Bold", 30)
    PIXEL.RegisterFont("PIXEL.Font.29", "Montserrat Bold", 29)
end

if PIXEL then
    wmastery.CreateFonts()
else
    hook.Add("PIXEL.UI.FullyLoaded", "wmastery", function()
        wmastery.CreateFonts()
    end)
end
