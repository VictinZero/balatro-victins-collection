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
