_RELEASE_MODE = false -- DEBUG MODE :: REMOVE IN RELEASE

VIC_ALPHA_RELEASE = false

function VIC_tcat(t1, t2)
    for i = 1, #t2 do
        t1[#t1 + 1] = t2[i]
    end
    return t1
end

function VIC_process_data_by_version(t1, t2)
    if not VIC_ALPHA_RELEASE then
        VIC_tcat(t1, t2)
    end
    return t1
end

G.VictinsCollection = {}

-- SMODS optional features
SMODS.current_mod.optional_features = {
    cardareas = {
        deck = true,
        unscored = true
    },
    quantum_enhancements = true,
    retrigger_joker = true
}

-- Lib
local lib_list = {"colours", "keybinds", "ui", "background_colours"}

local lib_list_dev = {"focus"}

VIC_process_data_by_version(lib_list, lib_list_dev)

for _, lib in ipairs(lib_list) do
    local init, error = SMODS.load_file("lib/" .. lib .. ".lua")
    if error then
        sendErrorMessage("VictinsCollection :: Failed to load lib " .. lib .. " with error " .. error)
    else
        local data = init()
        sendDebugMessage("VictinsCollection :: Loaded lib: " .. lib)
    end
end

-- Hooks
local hook_list = {"misc_functions", "game", "card", "UI_definitions", -- "button_callbacks",
"cardarea", "blind", "common_events"}

for _, hook in ipairs(hook_list) do
    local init, error = SMODS.load_file("hooks/" .. hook .. ".lua") -- NFS.load(SMODS.current_mod.path .. "hooks/" .. hook ..".lua")
    if error then
        sendErrorMessage("VictinsCollection :: Failed to load " .. hook .. " with error " .. error)
    else
        local data = init()
        sendDebugMessage("VictinsCollection :: Loaded hook: " .. hook)
    end
end
-- NFS.load(SMODS.current_mod.path .. "/hooks/common_events.lua")()

-- Jokers

-- Registers the atlas
SMODS.Atlas {
    key = 'joker_atlas',
    px = 71,
    py = 95,
    path = 'vic_joker_atlas.png'
}
SMODS.Atlas {
    key = 'joker_soul_atlas',
    px = 71,
    py = 95,
    path = 'vic_joker_soul_atlas.png'
}
SMODS.Atlas {
    key = 'champions_belt',
    px = 87,
    py = 95,
    path = 'vic_champions_belt.png'
}
SMODS.Atlas {
    key = 'collared',
    px = 101,
    py = 95,
    path = 'vic_collared.png'
}
SMODS.Atlas {
    key = 'red_hand',
    px = 71,
    py = 95,
    path = 'vic_red_hand.png'
}
SMODS.Atlas {
    key = 'test',
    px = 71,
    py = 95,
    path = 'vic_test.png'
}
SMODS.Atlas {
    key = 'eye_test',
    px = 71,
    py = 95,
    path = 'vic_eye_test.png'
}

-- Enable or disable additional jokers here
local joker_list = {"up_your_sleeve", "ouroboros", "moody", "trapezist", "dog", "hamster", "flush_spades",
                    "flush_hearts", "flush_clubs", "flush_diamonds", "the_one", "champion", "champions_belt",
                    "lvl_death", "gas_lamp", "paradise_parrot", "skyscraper", "pippi_panini", "yurika_harako",
                    "wrapped_candy", "slingshot", "royal_straight_joker", "chimera", "double_negative", "jar_of_teeth",
                    "broken_arm", "syzygy", "stheno", "tower_into_space", "binary_star"}

local joker_list_dev = {"growing_tree", "charon", "terraforming", "red_hand", "starfish", "goldfish", "clownfish",
                        "event_horizon", -- "wildheart", -- "h_size_boost",
"fortune_cookie", "chai_tea", "brazilian_miku", "collared", --[["test", "eye_test",]] --[["kill_consume_multiply_joker",]]
                        "joker_devouring_its_son", "butcher_vanity", "copies_commons", "nadia_om", "mammon",
                        "solomon_david", "jagganoth", "quantum_joker", "cosmic_egg", "blue_dwarf",
                        "aries", "taurus", "gemini", "cancer", "leo", "virgo", "libra", "scorpio", "sagittarius",
                        "capricorn", "aquarius", "pisces" -- "guarantees_enhancements",
-- "tour_guide", "grappling_hook", "bone",
}

VIC_process_data_by_version(joker_list, joker_list_dev)

for _, joker in ipairs(joker_list) do
    local joker_name = (" " .. joker:gsub("_", " ")):gsub("%W%l", string.upper):sub(2)
    local init, error = SMODS.load_file("modules/jokers/" .. joker .. ".lua")
    if error then
        sendErrorMessage("VictinsCollection :: Failed to load " .. joker_name .. " with error " .. error)
    else
        local data = init()
        SMODS.Joker(data)
        sendDebugMessage("VictinsCollection :: Loaded joker: " .. joker_name)
    end
end

-- Enhancements

-- Registers the atlas
--[[SMODS.Atlas {
    key = 'enhancement_atlas',
    px = 71,
    py = 95,
    path = 'vic_enhancement_atlas.png'
}

SMODS.Atlas {
    key = 'enhancement_morning',
    px = 71,
    py = 95,
    path = 'vic_3_in_the_morning.png'
}

SMODS.Atlas {
    key = 'disenhancement_confused',
    px = 41,
    py = 49,
    path = 'vic_confused_extra.png'
}

SMODS.Atlas {
    key = 'disenhancement_me_first',
    px = 21,
    py = 44,
    path = 'vic_me_first_extra.png'
}

local injectitems_ref = SMODS.injectItems

SMODS.injectItems = function()
    injectitems_ref()
    G.VictinsCollection.shared_sprites = G.VictinsCollection.shared_sprites or {
        confused_extra = Sprite(0, 0, 1, 1, G.ASSET_ATLAS['vic_disenhancement_confused'], {
            x = 0,
            y = 0
        }),
        me_first_extra = Sprite(0, 0, 1, 1, G.ASSET_ATLAS['vic_disenhancement_me_first'], {
            x = 0,
            y = 0
        })
    }
end

-- Enable or disable additional enhancements here
local enhancement_list = {}

local enhancement_list_dev = { -- "blood",
"flesh", "burning", "paralyzed", "confused", "me_first" -- "morning",
}

VIC_process_data_by_version(enhancement_list, enhancement_list_dev)

for _, enhancement in ipairs(enhancement_list) do
    local enhancement_name = (" " .. enhancement:gsub("_", " ")):gsub("%W%l", string.upper):sub(2)
    local init, error = SMODS.load_file("modules/enhancements/" .. enhancement .. ".lua")
    if error then
        sendErrorMessage("VictinsCollection :: Failed to load " .. enhancement_name .. " with error " .. error)
    else
        local data = init()
        SMODS.Enhancement(data)
        sendDebugMessage("VictinsCollection :: Loaded enhancement: " .. enhancement_name)
    end
end]]

-- Blinds

-- Registers the atlas
SMODS.Atlas({
    key = "blind_atlas",
    atlas_table = "ANIMATION_ATLAS",
    path = "vic_blind_atlas.png",
    px = 34,
    py = 34,
    frames = 21
})

SMODS.Atlas({
    key = "showdown_atlas",
    atlas_table = "ANIMATION_ATLAS",
    path = "vic_showdown_atlas.png",
    px = 34,
    py = 34,
    frames = 21
})

-- Enable or disable additional blinds here
local blind_list = {"worm", "rock", "bell", "spin", "bottle", "loop", "chaos", "dagger", "trash", "wind", "final_prion",
                    "final_gold", "final_loop", "final_debuff", "final_patriarch", "final_dragon", "final_king"}

local blind_list_dev = { --[["eclipse"]] }

VIC_process_data_by_version(blind_list, blind_list_dev)

for _, blind in ipairs(blind_list) do
    local blind_name = (" " .. blind:gsub("_", " ")):gsub("%W%l", string.upper):sub(2)
    local init, error = SMODS.load_file("modules/blinds/" .. blind .. ".lua")
    if error then
        sendErrorMessage("VictinsCollection :: Failed to load " .. blind_name .. " with error " .. error)
    else
        local data = init()
        local blind_obj = SMODS.Blind(data)

        for k_, v_ in pairs(data) do
            if type(v_) == 'function' then
                blind_obj[k_] = data[k_]
            end
        end

        sendDebugMessage("VictinsCollection :: Loaded blind: " .. blind_name)
    end
end

-- Consumables
-- Zodiac

if not VIC_ALPHA_RELEASE then
    SMODS.Rarity {
        key = 'auxiliary',
        default_weight = 0,
        pools = {
            ['Joker'] = true
        }
    }

    SMODS.ConsumableType({
        key = 'Zodiac',
        collection_rows = {6, 6},
        primary_colour = G.C.VictinsCollection.OTHERS.Ophiucus, -- HEX('009cfd'),
        secondary_colour = G.C.VictinsCollection.OTHERS.Zodiac, -- HEX("81cefd"),
        loc_txt = {},
        shop_rate = 2
    })

    local zodiac_list = {"aries", "taurus", "gemini", "cancer", "leo", "virgo", "libra", "scorpio", "sagittarius",
                         "capricorn", "aquarius", "pisces", "ophiucus"}

    for _, zodiac in ipairs(zodiac_list) do
        local zodiac_name = (" " .. zodiac:gsub("_", " ")):gsub("%W%l", string.upper):sub(2)
        local init, error = SMODS.load_file("modules/zodiac/" .. zodiac .. ".lua")
        if error then
            sendErrorMessage("VictinsCollection :: Failed to load " .. zodiac_name .. " with error " .. error)
        else
            local data = init()
            SMODS.Consumable(data)
            sendDebugMessage("VictinsCollection :: Loaded zodiac: " .. zodiac_name)
        end
    end
end

-- Tokens
SMODS.ConsumableType({
    key = 'Token',
    primary_colour = HEX('e083b0'), -- HEX('009cfd'),
    secondary_colour = HEX('8755bf'), -- HEX("81cefd"),
    loc_txt = {},
    shop_rate = 0
})

local consumable_list = {"short_rest"}

local consumable_list_dev = {}

VIC_process_data_by_version(consumable_list, consumable_list_dev)

for _, consumable in ipairs(consumable_list) do
    local consumable_name = (" " .. consumable:gsub("_", " ")):gsub("%W%l", string.upper):sub(2)
    local init, error = SMODS.load_file("modules/consumables/" .. consumable .. ".lua")
    if error then
        sendErrorMessage("VictinsCollection :: Failed to load " .. consumable_name .. " with error " .. error)
    else
        local data = init()
        SMODS.Consumable(data)
        sendDebugMessage("VictinsCollection :: Loaded consumable: " .. consumable_name)
    end

end

local set_cost_ref = Card.set_cost
function Card.set_cost(self)
    set_cost_ref(self)
    if self.ability.set == "Token" then
        self.sell_cost = (self.ability.extra_value or 0)
    end -- math.max(0, (self.edition and math.floor(G.P_CENTERS[self.edition.key].extra_cost/2)) or 0) + (self.ability.extra_value or 0) end
end

-- Badge colors
local badge_colors = {
    vic_token = HEX('009cfd'),
    vic_temporary = HEX('009dff')
}

local get_badge_colour_ref = get_badge_colour
function get_badge_colour(key)
    return badge_colors[key] or get_badge_colour_ref(key)
end

SMODS.Blind:take_ownership('pillar', {
    recalc_debuff = function(self, card, from_blind)
        if (card.debuff or (card.ability.played_this_ante and card.area ~= G.play)) then
            return true
        end
        return false
    end
})

if not VIC_ALPHA_RELEASE then

    -- SMODS.Shader {
    --     key = 'test',
    --     path = 'test.fs',
    -- }
    -- SMODS.Edition {
    --     key = "test",
    --     shader = "test",
    -- }

    -- SMODS.Shader {
    --     key = 'experiment',
    --     path = 'experiment.fs',
    -- }
    -- SMODS.Edition {
    --     key = "experiment",
    --     shader = "experiment",
    -- }

    SMODS.Shader {
        key = 'chowder',
        path = 'chowder.fs',
        --[[
        Additional variable passed to the shader, as defined in the main code.
        This scales the rendered texture size to approximate a regular Joker's size,
        which can depend on the game window size.
        Unsure if the passed variable is correct, as I couldn't find the exact scale used.
    --]]
        send_vars = function(sprite, card)
            return {
                card_scale = card and (0.95 * G.TILESCALE) / 1.5 or 1.0
            }
        end
    }
    SMODS.Edition {
        key = "chowder",
        shader = "chowder",
        disable_base_shader = true
    }

    SMODS.Shader {
        key = 'gold',
        path = 'gold.fs',
        -- card can be nil if sprite.role.major is not Card
        send_vars = function(sprite, card)
            return {
                lines_offset = card and card.edition.example_gold_seed or 0
            }
        end
    }
    SMODS.Shader {
        key = 'antigold',
        path = 'antigold.fs',
        -- card can be nil if sprite.role.major is not Card
        send_vars = function(sprite, card)
            return {
                lines_offset = card and card.edition.example_gold_seed or 0
            }
        end
    }
    SMODS.Edition {
        key = "golden",
        shader = "gold",
        on_apply = function(card)
            -- Randomize offset to -1..1
            -- Save in card.edition table so it persists after game restart.
            card.edition.example_gold_seed = pseudorandom('e_example_gold') * 2 - 1
        end
    }

    SMODS.Edition {
        key = "shiny",
        shader = false,
        config = {
            extra = {
                repetitions = 1
            }
        },
        calculate = function(self, card, context)
            if context.other_card == card and
                ((context.repetition and context.cardarea == G.play) or
                    (context.retrigger_joker_check and not context.retrigger_joker)) then
                return {
                    message = localize("k_again_ex"),
                    repetitions = self.config.extra.repetitions,
                    card = card
                }
            end
        end,
        loc_vars = function(self, info_queue, center)
            return {
                vars = {center and center.edition and center.edition.extra.repetitions or self.config.extra.repetitions}
            }
        end
    }
end

-- Stickers

-- Registers the atlas
SMODS.Atlas({
    key = "sticker_atlas",
    path = "vic_sticker_atlas.png",
    px = 71,
    py = 95
})

SMODS.Sticker {
    key = "temporary",
    atlas = "sticker_atlas",
    pos = {
        x = 0,
        y = 0
    },
    badge_colour = HEX('81CEFD'),
    default_compat = true,
    sets = {
        Consumeable = true,
        Default = true,
        Enhanced = true,
        Joker = true
    },
    rate = 0.,

    calculate = function(self, card, context)
        if (context.end_of_round and not context.repetition and not context.individual) or context.vic_prepare_cleanup then
            card.ability.vic_destroy_this = true
            print(card.ability.set)
        end
    end
}

-- Tags

-- Registers the atlas
SMODS.Atlas({
    key = "tag_atlas",
    path = "vic_tag_atlas.png",
    px = 34,
    py = 34
})

function juice_tag_until(tag, eval_func, first, delay)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = delay or 0.1,
        blocking = false,
        blockable = false,
        timer = 'REAL',
        func = (function()
            if eval_func(tag) then
                if not first or first then
                    tag:juice_up(0.1, 0.1)
                end
                juice_card_until(tag, eval_func, nil, 0.8)
            end
            return true
        end)
    }))
end

SMODS.Tag {
    key = 'rebate_tag',
    -- config = {},
    atlas = 'tag_atlas',
    pos = {
        x = 1,
        y = 0
    },
    discovered = true,

    apply = function(self, tag, context)
        if context.type == 'vic_buying_card' then
            local area = context.card.area
            if area == G.consumeables then
                tag:yep('+', G.C.FILTER, function()
                    if (#area.cards + G.GAME.consumeable_buffer < area.config.card_limit) or
                        (context.card.edition and context.card.edition.negative) then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer +
                                                        ((context.card.edition and context.card.edition.negative and 0) or
                                                            1)

                        local card_ = copy_card(context.card)
                        card_:start_materialize()
                        card_:add_to_deck()
                        G.consumeables:emplace(card_)

                        G.E_MANAGER:add_event(Event({
                            trigger = 'immediate',
                            delay = 0.0,
                            func = (function()
                                G.GAME.consumeable_buffer = 0
                                return true
                            end)
                        }))
                    end
                    return true
                end)

                tag.triggered = true
            end
        end
    end
}


SMODS.Tag {
    key = 'liquidation_tag',
    config = {vic_active = false},
    atlas = 'tag_atlas',
    pos = {
        x = 2,
        y = 0
    },
    discovered = true,

    apply = function(self, tag, context)
        if context.type == 'shop_start' then
            tag.vic_active = true
            G.E_MANAGER:add_event(Event({
                delay = 0.4,
                trigger = 'after',
                func = (function()
                    attention_text({
                        text = '+',
                        colour = G.C.WHITE,
                        scale = 1,
                        hold = 0.3 / G.SETTINGS.GAMESPEED,
                        cover = tag.HUD_tag,
                        cover_colour = G.C.FILTER,
                        align = 'cm'
                    })
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))

            juice_tag_until(tag, function(tag)
                return tag and not tag.triggered
            end, true, 0.1)
        elseif context.type == 'vic_buying_card' and tag.vic_active then
            local area = context.card.area
            if area == G.jokers or area == G.consumeables then
                local buffer = area == G.jokers and G.GAME.joker_buffer or G.GAME.consumeable_buffer
                if #area.cards + buffer < area.config.card_limit then
                    if area == G.jokers then
                        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    else
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    end
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = (function()
                            SMODS.add_card {
                                set = context.card.ability.set
                            }
                            if area == G.jokers then
                                G.GAME.joker_buffer = 0
                            else
                                G.GAME.consumeable_buffer = 0
                            end
                            return true
                        end)
                    }))
                end
            elseif area == G.deck then
                local _card = create_playing_card({
                    center = G.P_CENTERS[(G.GAME.used_vouchers["v_illusion"] and
                        pseudorandom(pseudoseed('vic_hb_ill_enh_cha')) > 0.6) and SMODS.poll_enhancement {
                        key = 'vic_hb_ill_enh_poll',
                        guaranteed = true
                    } or 'c_base']
                }, G.deck, true, true, nil)
                if G.GAME.used_vouchers["v_illusion"] and pseudorandom(pseudoseed('vic_hb_ill_edi_cha')) > 0.8 then
                    local edition = poll_edition('vic_hb_ill_edi_poll', 1, true, true, nil)
                    _card:set_edition(edition, true, true)
                end
                playing_card_joker_effects({_card})
            end
        elseif context.type == 'new_blind_choice' and tag.vic_active then
            stop_use()

            G.E_MANAGER:add_event(Event({
                func = (function()
                    tag.HUD_tag.states.visible = false
                    return true
                end)
            }))

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.7,
                func = (function()
                    tag:remove()
                    return true
                end)
            }))

            tag.triggered = true
        end
    end
}
