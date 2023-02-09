// This Addon was created by:
// Neural Studios
//
// any questions, please contact Bob Bobington#2947
local hashs = util.JSONToTable(file.Read("weapon_mastery_hashes.json", "LUA") or file.Read("neuralstudio/hashs/weapon_mastery_hashs.json", "DATA") or "{}") -- read the hashes from the file to do check for corruption
local Enabled = true -- set to error checking on or off


local function LoadAllFiles(dir)
    local files, dirs = file.Find( dir .. "/*", "LUA" )
    for k, v in pairs( files ) do

        if SERVER and Enabled then 
            if not string.find(v, "_config.lua") or not string.find(v, "_autorun.lua")  then   -- ignore config files
                if string.find(v, "module") then continue end
                if string.find(v, "plugins") then continue  end
                local data = file.Read(dir .. "/" .. v, "LUA")
                local hash = util.SHA256(data)
                if hashs[dir .. "/" .. v] then
                    if hashs[dir .. "/" .. v] != hash then
                        MsgC(Color(255,0,0), "[{weapon_mastery}]: File (" .. dir .. "/" .. v .. ") has been modified, please reinstall Vital Files\n")
                    end
                end
            end
        end

        if string.find(dir, "/client") then
            if SERVER then AddCSLuaFile( dir .. "/" .. v ) end
            if CLIENT then include( dir .. "/" .. v ) end
            MsgC(Color(255,217,0), "[weapon_mastery]: Added " .. v .. "\n")
        elseif string.find(dir, "/server") then
            if SERVER then include( dir .. "/" .. v ) MsgC(Color(0,162,255), "[weapon_mastery]: Added " .. v .. "\n") end
        elseif string.find(dir, "/shared") then
            if SERVER then AddCSLuaFile( dir .. "/" .. v ) include( dir .. "/" .. v ) end
            if CLIENT then include( dir .. "/" .. v ) end
            MsgC(Color(195,0,255), "[weapon_mastery]: Added " .. v .. "\n")
        elseif string.find(dir, "weapon_mastery") then
            if SERVER then AddCSLuaFile( dir .. "/" .. v ) include( dir .. "/" .. v ) end
            if CLIENT then include( dir .. "/" .. v ) end
            MsgC(Color(195,0,255), "[weapon_mastery]: Added " .. v .. "\n")
        end
    end
    for k, v in pairs( dirs ) do
       if string.find(v, "module") then return end
       if string.find(v, "plugins") then return end
       LoadAllFiles( dir .. "/" .. v )
    end
    
end

LoadAllFiles("weapon_mastery")
