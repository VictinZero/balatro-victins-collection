return {
    name = "The Loop",
    key = "loop", 
    pos = { x = 0, y = 4 },
    atlas = "blind_atlas",
    dollars = 5, 
    mult = 1.5, 
    vars = {}, 
    debuff = {},
    boss = {min = 4, max = 10},
    boss_colour = HEX('734C73'),
    discovered = true,
    loc_txt = {},

    disable = function(self)
        self.disabled = true
    end,
}
