wmastery = wmastery or {}
wmastery.config = wmastery.config or {}
local config = wmastery.config

-- Do not touch above this line

local notificationSound = "buttons/lightswitch2.wav"
local function DisplayNotify(msg)
    local txt = msg:ReadString()
    GAMEMODE:AddNotify(txt, msg:ReadShort(), msg:ReadLong())
    surface.PlaySound(notificationSound)
end
usermessage.Hook("wmastery_Notify", DisplayNotify)


net.Receive("wmastery.ChatSend", function(len)
    local msg = net.ReadTable()

    chat.AddText( unpack(msg) )
end)
