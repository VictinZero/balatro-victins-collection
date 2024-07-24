local misc = NFS.load(SMODS.current_mod.path .. "/misc_functions.lua")()

return {
    name = "The Rouge Ribbon",
    key = "final_ribbon", 
    pos = { x = 0, y = 2 },
    atlas = "showdown_atlas",
    dollars = 8, 
    mult = 1.5, 
    vars = {}, 
    debuff = {},
    boss = {showdown = true, min = 1, max = 10},--showdown = true
    boss_colour = HEX('B29CB2'),--HEX('A91101'),
    discovered = true,
    loc_txt = {},

    vic_tooltip = function(blind_choice)
        local function tmp()
            return {{
                n=G.UIT.C,
                config={
                    align = "cm",
                    padding = 0.05,
                    colour = lighten(G.C.JOKER_GREY, 0.5),
                    r = 0.1,
                    emboss = 0.05
                },
                nodes = misc.create_UIBox_blind_popup_with_icon('bl_vic_loop', true),
            }}
        end

        misc.create_blind_tooltip(blind_choice, tmp) 
    end,

    disable = function(self)
        self.disabled = true
    end,
}
