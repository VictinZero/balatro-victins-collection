-- Talking cards
function Card:vic_add_speech_bubble(text_key, align, loc_vars, extra)
    if self.children.speech_bubble then
        self.children.speech_bubble:remove()
    end
    self.config.speech_bubble_align = {
        align = align or 'bm',
        offset = {
            x = 0,
            y = 0
        },
        parent = self
    }
    self.children.speech_bubble = UIBox {
        definition = G.UIDEF.vic_speech_bubble(text_key, loc_vars, extra),
        config = self.config.speech_bubble_align
    }
    self.children.speech_bubble:set_role{
        role_type = 'Minor',
        xy_bond = 'Weak',
        r_bond = 'Strong',
        major = self
    }
    self.children.speech_bubble.states.visible = false
end

function Card:vic_remove_speech_bubble()
    if self.children.speech_bubble then
        self.children.speech_bubble:remove();
        self.children.speech_bubble = nil
    end
end

function Card:vic_say_stuff(n, not_first)
    self.talking = true
    if not not_first then
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                if self.children.speech_bubble then
                    self.children.speech_bubble.states.visible = true
                end
                self:vic_say_stuff(n, true)
                return true
            end
        }))
    else
        if n <= 0 then
            self.talking = false;
            return
        end
        local new_said = math.random(1, 11)
        while new_said == self.last_said do
            new_said = math.random(1, 11)
        end
        self.last_said = new_said
        play_sound('voice' .. math.random(1, 11), G.SPEEDFACTOR * (math.random() * 0.2 + 1), 0.5)
        self:juice_up()
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            blockable = false,
            blocking = false,
            delay = 0.13,
            func = function()
                self:vic_say_stuff(n - 1, true)
                return true
            end
        }), 'tutorial')
    end
end

-- Chimera effect

local is_face_ref = Card.is_face
function Card.is_face(self, from_boss)
    if (not self.debuff or from_boss) and next(SMODS.find_card('j_vic_chimera')) and 1 <= #G.play.cards and
        #G.play.cards <= 3 and self.area == G.play then
        return true
    else
        return is_face_ref(self, from_boss)
    end
end

local is_suit_ref = Card.is_suit
function Card.is_suit(self, suit, bypass_debuff, flush_calc)
    if not flush_calc and next(SMODS.find_card('j_vic_chimera')) and 1 <= #G.play.cards and #G.play.cards <= 3 and
        self.area == G.play then
        return true
    else
        return is_suit_ref(self, suit, bypass_debuff, flush_calc)
    end
end

-- Track hovered card
--[[
local card_hover_ref = Card.hover
function Card:hover()
    if G.GAME.VictinsCollection then
        G.GAME.VictinsCollection.hovered_card = self
    end
    return card_hover_ref(self)
end

local card_stop_hover_ref = Card.stop_hover
function Card:stop_hover()
    if G.GAME.VictinsCollection then
        G.GAME.VictinsCollection.hovered_card = G.GAME.VictinsCollection.hovered_card ~= self and
                                                    G.GAME.VictinsCollection.hovered_card or nil
    end
    return card_stop_hover_ref(self)
end
]]
