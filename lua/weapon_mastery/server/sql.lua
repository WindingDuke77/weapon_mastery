// This Addon was created by:
// Bob Bobington#2947
// 
// any questions, please contact me

wmastery = wmastery or {}
wmastery.config = wmastery.config or {}
wmastery.SQL = wmastery.SQL or {}
local SQL = wmastery.SQL
local config = wmastery.config
 
// Do not above this line.


-- local masteryTable_Example = {
--     steamID: "898090-921",
--     weapon: "weapon_ak47",
--     kills: 0,
--     npc_kills: 0,
--     XP: 0,
--     level: 1,
--     points: 0,
-- }


sql.Query("CREATE TABLE IF NOT EXISTS wmastery (steamID TEXT, weapon TEXT, kills INT, npc_kills INT, XP INT, level INT, points INT)")


