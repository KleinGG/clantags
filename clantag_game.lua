if dopamine == nil then
    RunScript("dopamine.lua")
end

local timing_switch = 40

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
    [1] = function() return "gamesense" end,
    [2] = function() return "amesense " end,
    [3] = function() return "mesense  " end,
	[4] = function() return "esense   " end,
	[5] = function() return "sense    " end,
	[6] = function() return "ense     " end,
	[7] = function() return "nse      " end,
	[8] = function() return "se       " end,
	[9] = function() return "e        " end,
	[10] = function() return "         " end,
	[11] = function() return "        g" end,
	[12] = function() return "       ga" end,
	[13] = function() return "      gam" end,
	[14] = function() return "     game" end,
	[15] = function() return "    games" end,
	[16] = function() return "   gamese" end,
	[17] = function() return "  gamesen" end,
	[18] = function() return " gamesens" end,
	[19] = function() return "gamesense" end,
	[20] = function() return "gamesense" end,
	[21] = function() return "gamesense" end,
	[22] = function() return "gamesense" end,
	[23] = function() return "gamesense" end,
	[24] = function() return "gamesense" end,
	[25] = function() return "gamesense" end,
	[26] = function() return "gamesense" end,
	[27] = function() return "gamesense" end,
	[28] = function() return "gamesense" end
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