SMODS.Keybind({
    key_pressed = "f",
    held_keys = {"lshift"},
    action = function(self)
        local selected = G and G.CONTROLLER and (G.CONTROLLER.focused.target or G.CONTROLLER.hovering.target)

        if not selected then
            return
        end

        vic_create_focused_overlay(selected)
    end
})

vic_create_focused_overlay = function(card)
    if not card then
        return
    end

    G.related_area = CardArea(0, 0, G.CARD_W * 0.95, G.CARD_H, {
        card_limit = 1,
        type = 'title',
        highlight_limit = 0
    })
    local added_card = SMODS.create_card({
        key = card.config.center.key,
        no_edition = true,
        area = G.related_area
    })
    G.related_area:emplace(added_card)

    added_card.T.scale = 1.5 * added_card.T.scale

    local fake_info_queue = {}
    local loc_vars = added_card.config.center.loc_vars
    if type(loc_vars) == 'function' then
        local tmp = loc_vars(added_card, fake_info_queue, added_card)
        if type(tmp) == 'table' and tmp.vars then loc_vars = tmp.vars end
    end
    local loc_vars = loc_vars or {}

    local desc = {}
    local loc_vars = {
        background_colour = G.C.WHITE,
        text_colour = G.C.BLACK,
        scale = 1,
        vars = loc_vars
    }
    local name = localize {
        type = 'name',
        key = added_card.config.center.key,
        set = added_card.ability.set
    }
    localize {
        type = 'descriptions',
        key = added_card.config.center.key,
        set = added_card.ability.set,
        nodes = desc,
        vars = loc_vars.vars,
        scale = loc_vars.scale,
        text_colour = loc_vars.text_colour,
        shadow = loc_vars.shadow
    }

    desc = desc_from_rows(desc)

    local credits = {}

    for k, v in ipairs(fake_info_queue) do
        if v.key and v.key:sub(1, 7) == 'cr_vic_' then
            local ability_UIBox_table = added_card:generate_UIBox_ability_table()
            if ability_UIBox_table.info then
                for _, vv in ipairs(ability_UIBox_table.info) do
                    if vv.name and vv.name:sub(1, 7) == 'cr_vic_' then
                        credits = info_tip_from_rows(vv, vv.name)
                        break
                    end
                end
            end
        end
    end

    if not credits.config and #credits == 0 then
        credits = nil
    end

    G.FUNCS.overlay_menu({
        definition = create_UIBox_generic_options({
            back_colour = G.C.FILTER,
            contents = {{
                n = G.UIT.C,
                config = {
                    padding = 0.2
                },
                nodes = {{
                    n = G.UIT.R,
                    config = {
                        align = "cm",
                        r = 0.1,
                        padding = 1.2,
                        minh = 3,
                        minw = 4,
                        colour = G.C.BLACK
                    },
                    nodes = {{
                        n = G.UIT.O,
                        config = {
                            object = G.related_area
                        }
                    }}
                }, {
                    n = G.UIT.R,
                    config = {
                        align = "cm"
                    },
                    nodes = name
                }, desc, credits}
            }}
        })
    })
end
