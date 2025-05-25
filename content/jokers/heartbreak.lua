local sprite_data = { {}, {}, {} }
for i = 0, 2 do
    for j = 0, 2 do
        local data = { anchor = { x = 0, y = 0 }, displacement = { x = 0, y = 0 }, speed = { x = 0, y = 0 }, acceleration = { x = 0, y = 0 } }
        sprite_data[i + 1][j + 1] = data
    end
end

return {
    key = 'heartbreak',
    config = {
        extra = {
            mult = 0,
            mult_mod = 8,
            sprite_data = sprite_data
        }
    },
    rarity = 1,
    pos = {
        x = 3,
        y = 3
    },
    atlas = 'vic_heartbreak',
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    display_size = {
        w = 71,
        h = 77
    },
    soul_pos = {
        x = 0,
        y = 0,
        draw = function(card, scale_mod, rotate_mod)
            local shader = 'dissolve'

            if card:should_draw_base_shader() then
                for i = 0, 2 do
                    for j = 0, 2 do
                        local sprite = card.children["vic_heartbreak_" .. tostring(i) .. tostring(j)]
                        if sprite then
                            sprite:draw_shader(shader, nil, nil, nil, card.children.center,
                                scale_mod, rotate_mod, card.ability.extra.sprite_data[i + 1][j + 1].displacement.x,
                                card.ability.extra.sprite_data[i + 1][j + 1].displacement.y)
                        end
                    end
                end
            end

            if card.edition and not card.delay_edition then
                for k, v in pairs(G.P_CENTER_POOLS.Edition) do
                    if card.edition[v.key:sub(3)] and v.shader then
                        --[[if type(v.draw) == 'function' then
                            v:draw(self, layer)
                        else
                            card.children.center:draw_shader(v.shader, nil, self.ARGS.send_to_shader)
                            if card.children.front and card.ability.effect ~= 'Stone Card' and not card.config.center.replace_base_card then
                                card.children.front:draw_shader(v.shader, nil, card.ARGS.send_to_shader)
                            end
                        end]]
                        shader = v.shader
                        break
                    end
                end
            end

            for i = 0, 2 do
                for j = 0, 2 do
                    local sprite = card.children["vic_heartbreak_" .. tostring(i) .. tostring(j)]
                    if sprite then
                        sprite:draw_shader(shader, nil, nil, nil, card.children.center,
                            scale_mod, rotate_mod, card.ability.extra.sprite_data[i + 1][j + 1].displacement.x,
                            card.ability.extra.sprite_data[i + 1][j + 1].displacement.y)
                        if (card.edition and card.edition.negative) then
                            sprite:draw_shader('negative_shine', nil, nil, nil, card.children.center,
                            scale_mod, rotate_mod, card.ability.extra.sprite_data[i + 1][j + 1].displacement.x,
                            card.ability.extra.sprite_data[i + 1][j + 1].displacement.y)
                        end
                    end
                end
            end
        end
    },

    update = function(self, card, dt)
        local timestep = G.real_dt or dt

        local system = card.ability.extra.sprite_data

        local cursor_pos = { G.CURSOR.T.x, G.CURSOR.T.y }
        local card_center_pos = { (card.VT.x + (card.VT.w / 2) + G.ROOM.T.x), (card.VT.y + (card.VT.h / 2) + G.ROOM.T.y) }
        local vec = { cursor_pos[1] - card_center_pos[1], cursor_pos[2] - card_center_pos[2] }

        local is_cursor_nearby = (math.abs(vec[1]) < 2. * card.VT.w) and (math.abs(vec[2]) < 2. * card.VT.h)

        for i = 0, 2 do
            for j = 0, 2 do
                system[i + 1][j + 1].anchor.x = card.VT.x + (0.25 + 0.25 * i) * card.VT.w + G.ROOM.T.x
                system[i + 1][j + 1].anchor.y = card.VT.y + (0.25 + 0.25 * j) * card.VT.h + G.ROOM.T.y
            end
        end

        -- ACCELERATION
        for i = 0, 2 do
            for j = 0, 2 do
                -- SPRING to ANCHOR COMPONENT
                system[i + 1][j + 1].acceleration.x = -150. * (system[i + 1][j + 1].displacement.x)
                system[i + 1][j + 1].acceleration.y = -150. * (system[i + 1][j + 1].displacement.y)

                system[i + 1][j + 1].acceleration.x = system[i + 1][j + 1].acceleration.x -
                    100. * (system[i + 1][j + 1].speed.x)
                system[i + 1][j + 1].acceleration.y = system[i + 1][j + 1].acceleration.y -
                    100. * (system[i + 1][j + 1].speed.y)

                -- SPRING TO NEIGHBOUR COMPONENT
                -- for i2 = 0, 2 do
                --     for j2 = 0, 2 do
                --         if ((i ~= i2) or (j ~= j2)) and (math.abs(i - i2) + math.abs(j - j2) <= 1) then --and (math.abs(j - j2) <= 1) and then
                --             local dist = { (system[i2 + 1][j2 + 1].anchor.x - system[i + 1][j + 1].anchor.x + system[i + 1][j + 1].displacement.x) - (system[i2 + 1][j2 + 1].displacement.x), (system[i2 + 1][j2 + 1].anchor.y - system[i + 1][j + 1].anchor.y + system[i + 1][j + 1].displacement.y) - (system[i2 + 1][j2 + 1].displacement.y) }

                --             -- local current_length = math.sqrt(current_arrow[1] * current_arrow[1] +
                --             --     current_arrow[2] * current_arrow[2])

                --             -- local rest_arrow = { system[i2 + 1][j2 + 1].anchor.x - (system[i + 1][j + 1].anchor.x),
                --             --     system[i2 + 1][j2 + 1].anchor.y - (system[i + 1][j + 1].anchor.y) }

                --             -- local rest_length = math.sqrt(rest_arrow[1] * rest_arrow[1] + rest_arrow[2] * rest_arrow[2])

                --             system[i + 1][j + 1].acceleration.x = system[i + 1][j + 1].acceleration.x -
                --                 50. * dist[1]
                --             system[i + 1][j + 1].acceleration.y = system[i + 1][j + 1].acceleration.y - 50. * dist[2]
                --         end
                --     end
                -- end

                -- CURSOR COMPONENT
                if is_cursor_nearby then
                    local dist = { cursor_pos[1] - (system[i + 1][j + 1].anchor.x + system[i + 1][j + 1].displacement.x),
                        cursor_pos[2] - (system[i + 1][j + 1].anchor.y + system[i + 1][j + 1].displacement.y) }
                    local length = math.max(math.sqrt(dist[1] * dist[1] + dist[2] * dist[2]), 0.2)

                    -- Power exponent decreased from 3 to 2.5 to decrease decay over distance
                    system[i + 1][j + 1].acceleration.x = system[i + 1][j + 1].acceleration.x -
                        10. * (dist[1] / math.pow(length, 2.5))
                    system[i + 1][j + 1].acceleration.y = system[i + 1][j + 1].acceleration.y -
                        10. * (dist[2] / math.pow(length, 2.5))
                end
            end
        end

        -- SPEED
        for i = 0, 2 do
            for j = 0, 2 do
                system[i + 1][j + 1].speed.x = system[i + 1][j + 1].speed.x +
                    system[i + 1][j + 1].acceleration.x * timestep
                system[i + 1][j + 1].speed.y = system[i + 1][j + 1].speed.y +
                    system[i + 1][j + 1].acceleration.y * timestep
            end
        end

        -- DISPLACEMENT
        for i = 0, 2 do
            for j = 0, 2 do
                system[i + 1][j + 1].displacement.x = math.min(math.max(system[i + 1][j + 1].displacement.x +
                    system[i + 1][j + 1].speed.x * timestep, -1.0), 1.0)
                system[i + 1][j + 1].displacement.y = math.min(math.max(system[i + 1][j + 1].displacement.y +
                    system[i + 1][j + 1].speed.y * timestep, -1.0), 1.0)
            end
        end
    end,

    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            local count = 0
            for _, v in ipairs(context.removed) do
                if v:is_suit('Hearts') then
                    count = count + 1
                end
            end
            if count > 0 then
                card.ability.extra.mult = card.ability.extra.mult + count * card.ability.extra.mult_mod
                return {
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    colour = G.C.RED
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,

    set_sprites = function(self, card, front)
        if self.discovered or card.bypass_discovery_center then
            -- card.ignore_base_shader = card.ignore_base_shader or {}
            -- card.ignore_base_shader.vic_ = true

            local sprites = { {}, {}, {} }
            for i = 0, 2 do
                for j = 0, 2 do
                    sprites[i + 1][j + 1] = Sprite(card.T.x, card.T.y, card.T.w, card.T.h,
                        G.ASSET_ATLAS[card.config.center.atlas], {
                            x = i,
                            y = j
                        })
                    sprites[i + 1][j + 1].role.draw_major = card
                    sprites[i + 1][j + 1].states.hover.can = false
                    sprites[i + 1][j + 1].states.click.can = false

                    card.children["vic_heartbreak_" .. tostring(i) .. tostring(j)] = sprites[i + 1][j + 1]
                end
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.mult_mod, card.ability.extra.mult },
        }
    end
}
