if dopamine == nil then
    RunScript("dopamine.lua")
end

local timing_switch = 33

local cur_mode = 0
local timing = timing_switch


local clantag_timing = {
    [1] = function() return "supremacy beta" end,
    [2] = function() return "upremacy beta " end,
    [3] = function() return "premacy beta s" end,
	[4] = function() return "remacy beta su" end,
	[5] = function() return "emacy beta sup" end,
	[6] = function() return "macy beta supr" end,
	[7] = function() return "acy beta supre" end,
	[8] = function() return "cy beta suprem" end,
	[9] = function() return "y beta suprema" end,
	[10] = function() return " beta supremac" end,
	[11] = function() return "beta supremacy" end,
	[12] = function() return "eta supremacy " end,
	[13] = function() return "ta supremacy b" end,
	[14] = function() return "a supremacy be" end,
	[15] = function() return " supremacy bet" end,
	[16] = function() return "supremacy beta" end
}

local function hk_create_move(cmd)
    timing = timing + 1
end

local function hk_draw()

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