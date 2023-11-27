if dopamine == nil then
    RunScript("dopamine.lua")
end

local timing_switch = 100

local frametime = 0
local fps = 0
local cur_mode = 0
local timing = timing_switch

local function get_kd() -- """borrowed""" from Nexxed
    local kills = entities.GetPlayerResources():GetPropInt("m_iKills", entities.GetLocalPlayer():GetIndex())
    local deaths = entities.GetPlayerResources():GetPropInt("m_iDeaths", entities.GetLocalPlayer():GetIndex())

    if deaths == 0 then deaths = 1 end

    return (math.floor((kills / deaths) * (10^(2 or 0)) + 0.5) / (10^(2 or 0)))
end


local clantag_timing = {
    [1] = function() return "CSGOGeek" end,
    [2] = function() return "govnoware" end,
    [3] = function() return "iWebz" end,
	[4] = function() return "globemacy" end,
	[5] = function() return "samosval" end,
	[6] = function() return "jertva_BaCbKu" end,
	[7] = function() return "freehuyna" end,
	[8] = function() return "onedump" end,
	[9] = function() return "brutality.win" end,
	[10] = function() return "pphub" end,
	[11] = function() return "gaygang" end,
	[12] = function() return "govnocedia" end,
	[13] = function() return "happytality" end
}

local function hk_create_move(cmd)
    timing = timing + 1
end

local function hk_draw()
    -- also """borrowed""" from Nexxed :)
    frametime = 0.9 * frametime + (1.0 - 0.9) * globals.AbsoluteFrameTime()
    fps = math.floor((1.0 / frametime) + 0.5)

    if not dopamine.available() then
        return
    end
    
    if timing >= timing_switch then
        cur_mode = cur_mode + 1

        if cur_mode > #clantag_timing then
            cur_mode = 1
        end
        
        dopamine.set_clan_tag(clantag_timing[cur_mode]())
        timing = 0
    end
end

callbacks.Register("CreateMove", hk_create_move)
callbacks.Register("Draw", hk_draw)
