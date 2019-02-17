if dopamine == nil then
    RunScript("dopamine.lua")
end

local timing_switch = 22

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
    [1] = function() return "idi nahuy" end,
    [2] = function() return "di nahuy " end,
    [3] = function() return "i nahuy  " end,
	[4] = function() return " nahuy   " end,
	[5] = function() return "nahuy    " end,
	[6] = function() return "ahuy     " end,
	[7] = function() return "huy      " end,
	[8] = function() return "uy       " end,
	[9] = function() return "y        " end,
	[10] = function() return "         " end,
	[11] = function() return "        i" end,
	[12] = function() return "       id" end,
	[13] = function() return "      idi" end,
	[14] = function() return "     idi " end,
	[15] = function() return "    idi n" end,
	[16] = function() return "   idi na" end,
	[17] = function() return "  idi nah" end,
	[18] = function() return " idi nahu" end,
	[19] = function() return "idi nahuy" end,
	[20] = function() return "idi nahuy" end,
	[21] = function() return "idi nahuy" end,
	[22] = function() return "idi nahuy" end
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