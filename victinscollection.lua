-- _RELEASE_MODE = false -- DEBUG MODE :: REMOVE IN RELEASE

-- SMODS optional features
SMODS.current_mod.optional_features = {
    retrigger_joker = true,
    quantum_enhancements = true
}

-- Colours
local tmp_init, tmp_error = SMODS.load_file("colours.lua") -- NFS.load(SMODS.current_mod.path .. "colours.lua")
if tmp_error then
    sendErrorMessage("VictinsCollection :: Failed to load colours with error " .. tmp_error)
else
    local tmp_data = tmp_init()
    sendDebugMessage("VictinsCollection :: Loaded : colours")
end

-- Hooks
local hook_list = {"misc_functions", "game", "card", "UI_definitions", "state_events", -- "button_callbacks",
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

-- Enable or disable additional jokers here
local joker_list = {"up_your_sleeve", "ouroboros", "moody", "the_one", "champion", "champions_belt", "lvl_death",
                    "gas_lamp", "the_one", "paradise_parrot", "skyscraper", "pippi_panini", "yurika_harako", "syzygy",
                    "stheno", "tower_into_space" -- alpha --
-- "royal_straight_joker", "growing_tree", "chimera", "wildheart", -- "h_size_boost", "terraforming",
-- "fortune_cookie", "chai_tea", "brazilian_miku", "copies_commons", "nadia_om", "mammon", "solomon_david", "jagganoth",
--                    "makes_black_holes", "quantum_joker", "cosmic_egg", "blue_dwarf", "gemini", "cancer" -- "guarantees_enhancements",
-- "tour_guide", "grappling_hook", "bone",
}

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
    G.VictinsCollection = {
        shared_sprites = {
            confused_extra = Sprite(0, 0, 1, 1, G.ASSET_ATLAS['vic_disenhancement_confused'], {
                x = 0,
                y = 0
            }),
            me_first_extra = Sprite(0, 0, 1, 1, G.ASSET_ATLAS['vic_disenhancement_me_first'], {
                x = 0,
                y = 0
            })
        }
    }
end

-- Enable or disable additional enhancements here
local enhancement_list = { -- "blood",
    -- "confused", "me_first" -- "morning",
}

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
local blind_list = {
    "worm",
    worm = true,
    "rock",
    rock = true,
    "bell",
    bell = true,
    "spin",
    spin = true,
    "bottle",
    bottle = true,
    "loop",
    loop = true,
    "chaos",
    chaos = false,
    "dagger",
    dagger = true,
    "eclipse",
    eclipse = false,
    "final_prion",
    final_prion = true,
    "final_gold",
    final_gold = true,
    "final_ribbon",
    final_ribbon = true,
    "final_patriarch",
    final_patriarch = true
}

for _, blind in ipairs(blind_list) do
    if blind_list[blind] then
        local blind_name = (" " .. blind:gsub("_", " ")):gsub("%W%l", string.upper):sub(2)
        local init, error = SMODS.load_file("modules/blinds/" .. blind .. ".lua") -- NFS.load(SMODS.current_mod.path .. "modules/blinds/" .. blind ..".lua")
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
end

-- from Bunco with permission

local ease_background_colour_blind_ref = ease_background_colour_blind

local function invert_color(color, invert_red, invert_green, invert_blue)
    local inverted_color = {1 - (color[1] or 0), 1 - (color[2] or 0), 1 - (color[3] or 0), color[4] or 1}

    if invert_red then
        inverted_color[1] = color[1] or 0
    end
    if invert_green then
        inverted_color[2] = color[2] or 0
    end
    if invert_blue then
        inverted_color[3] = color[3] or 0
    end

    return inverted_color
end

local function increase_saturation(color, value)
    -- Extract RGB components
    local r = color[1] or 0
    local g = color[2] or 0
    local b = color[3] or 0

    -- Convert RGB to HSL
    local max_val = math.max(r, g, b)
    local min_val = math.min(r, g, b)
    local delta = max_val - min_val

    local h, s, l = 0, 0, (max_val + min_val) / 2

    if delta ~= 0 then
        if l < 0.5 then
            s = delta / (max_val + min_val)
        else
            s = delta / (2 - max_val - min_val)
        end

        if r == max_val then
            h = (g - b) / delta
        elseif g == max_val then
            h = 2 + (b - r) / delta
        else
            h = 4 + (r - g) / delta
        end

        h = h * 60
        if h < 0 then
            h = h + 360
        end
    end

    -- Increase saturation
    s = math.min(s + value, 1)

    -- Convert back to RGB
    local c = (1 - math.abs(2 * l - 1)) * s
    local x = c * (1 - math.abs((h / 60) % 2 - 1))
    local m = l - c / 2

    local r_new, g_new, b_new = 0, 0, 0

    if h < 60 then
        r_new, g_new, b_new = c, x, 0
    elseif h < 120 then
        r_new, g_new, b_new = x, c, 0
    elseif h < 180 then
        r_new, g_new, b_new = 0, c, x
    elseif h < 240 then
        r_new, g_new, b_new = 0, x, c
    elseif h < 300 then
        r_new, g_new, b_new = x, 0, c
    else
        r_new, g_new, b_new = c, 0, x
    end

    -- Adjust RGB values
    r_new, g_new, b_new = (r_new + m), (g_new + m), (b_new + m)

    return {r_new, g_new, b_new, color[4] or 1}
end

function ease_background_colour_blind(state, blind_override)
    local blindname = ((blind_override or (G.GAME.blind and G.GAME.blind.name ~= '' and G.GAME.blind.name)) or
                          'Small Blind')
    local blindname = (blindname == '' and 'Small Blind' or blindname)

    for k, v in pairs(G.P_BLINDS) do
        if v.name == blindname then
            local boss_col = v.boss_colour
            if v.boss and v.boss.showdown then
                ease_background_colour {
                    new_colour = increase_saturation(mix_colours(boss_col, invert_color(boss_col), 0.3), 1),
                    special_colour = boss_col,
                    tertiary_colour = darken(increase_saturation(
                        mix_colours(boss_col, invert_color(boss_col, true, false, false), 0.3), 0.6), 0.4),
                    contrast = 1.7
                }
                return
            else
                ease_background_colour_blind_ref(state, blind_override)
            end
        end
    end
end

local draw_from_play_to_discard_ref = G.FUNCS.draw_from_play_to_discard

G.FUNCS.draw_from_play_to_discard = function(e)
    draw_from_play_to_discard_ref(e)

    if G.GAME.VictinsCollection.post_discard_draw then
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                local n = #G.GAME.VictinsCollection.post_discard_draw
                local it = 1
                for k, v in ipairs(G.GAME.VictinsCollection.post_discard_draw) do
                    if v and not v.removed then
                        draw_card(v.area, G.hand, it * 100 / n, 'up', true, v)
                        it = it + 1
                    end
                end
                G.GAME.VictinsCollection.post_discard_draw = false
                return true
            end
        }))
    end
end

-- Consumables
-- Zodiac
--[[
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

local zodiac_list = { -- "aries",
-- "taurus",
"gemini", "cancer", -- "leo",
-- "virgo",
--  "libra",
--  "scorpio",
--  "sagittarius",
--  "capricorn",
--  "aquarius",
--  "pisces",
"ophiucus"}

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
]]

-- Tokens
SMODS.ConsumableType({
    key = 'Token',
    primary_colour = HEX('e083b0'), -- HEX('009cfd'),
    secondary_colour = HEX('8755bf'), -- HEX("81cefd"),
    loc_txt = {},
    shop_rate = 0
})

local consumable_list = {
    "short_rest",
    short_rest = true
}

for _, consumable in ipairs(consumable_list) do
    if consumable_list[consumable] then
        local consumable_name = (" " .. consumable:gsub("_", " ")):gsub("%W%l", string.upper):sub(2)
        local init, error = SMODS.load_file("modules/consumables/" .. consumable .. ".lua") -- NFS.load(SMODS.current_mod.path .. "modules/consumables/" .. consumable ..".lua")
        if error then
            sendErrorMessage("VictinsCollection :: Failed to load " .. consumable_name .. " with error " .. error)
        else
            local data = init()
            SMODS.Consumable(data)
            sendDebugMessage("VictinsCollection :: Loaded consumable: " .. consumable_name)
        end
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

-- SMODS.Shader {
--     key = 'test',
--     path = 'test.fs',
-- }
-- SMODS.Edition {
--     key = "test",
--     shader = "test",
-- }

--[[SMODS.Shader {
    key = 'chowder',
    path = 'chowder.fs',
    --[[
        Additional variable passed to the shader, as defined in the main code.
        This scales the rendered texture size to approximate a regular Joker's size,
        which can depend on the game window size.
        Unsure if the passed variable is correct, as I couldn't find the exact scale used.
    --]]
--[[    send_vars = function(sprite, card)
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
}]]

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
