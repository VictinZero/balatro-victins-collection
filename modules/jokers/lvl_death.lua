local misc = NFS.load(SMODS.current_mod.path .. "/misc_functions.lua")()

local _generate_main_end = function(card)
    local main_end = 0
    if not misc.is_in_your_collection(card) then
        local handname, _ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)

        local backwards = false
        for k, v in pairs(G.hand.highlighted) do
            if v.facing == 'back' then
                backwards = true
                break
            end
        end

        local active = false
        if handname and handname ~= 'NULL' then 
            local lvl = (G.GAME.hands and G.GAME.hands[handname] and G.GAME.hands[handname].level) or nil
            active = (not backwards) and (lvl and lvl % card.ability.extra.lvl_mod == 0)
        end

        local colour = (active and G.C.GREEN) or G.C.RED
        local txt = (active and localize('k_active')) or (backwards and "???") or localize('k_vic_inactive')
        main_end = {
                {n=G.UIT.C, config={align = "bm", padding = 0.02}, nodes={
                    {n=G.UIT.C, config={align = "m", colour = colour, r = 0.05, padding = 0.05}, nodes={
                        {n=G.UIT.T, config={text = ' '..txt..' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true}},
                    }}
                }}
            }
    else
        main_end = nil
    end
    return main_end
end

return {
    key = 'lvl_death',
    config = {extra={Xmult=3, lvl_mod=3}},
    rarity = 2,
    pos = { x = 0, y = 0 },
    atlas = 'joker_atlas',
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.joker_main and G.GAME.hands[context.scoring_name].level % card.ability.extra.lvl_mod == 0 then
            return {
                        message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
                        Xmult_mod = card.ability.extra.Xmult
                    }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult, card.ability.extra.lvl_mod}, main_end = _generate_main_end(card)}
    end,
}
