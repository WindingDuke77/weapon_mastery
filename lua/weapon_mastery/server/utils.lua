wmastery = wmastery or {}
wmastery.config = wmastery.config or {}
local config = wmastery.config

function wmastery.notify(ply, msgtype, len, msg)
    if not istable(ply) then
        if not IsValid(ply) then
            return
        end

        ply = {ply}
    end

    local rcf = RecipientFilter()
    for _, v in pairs(ply) do
        rcf:AddPlayer(v)
    end

    umsg.Start("wmastery_Notify", rcf)
        umsg.String(msg)
        umsg.Short(msgtype)
        umsg.Long(len)
    umsg.End()
end

util.AddNetworkString("wmastery.ChatSend")

function wmastery.SendToClient(ply, Msg)
    if not IsValid(ply) then
        return
    end

    net.Start("wmastery.ChatSend")
        net.WriteTable(Msg)
    net.Send(ply)
end
    
