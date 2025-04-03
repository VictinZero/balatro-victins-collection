-- Regenerate UI on key press and key release

SMODS.Keybind({
    key_pressed = "lalt",
    action = function(self)
        local selected = G and G.CONTROLLER and (G.CONTROLLER.focused.target or G.CONTROLLER.hovering.target)

        if not selected then
            return
        end

        if selected.hover and selected.stop_hover then
            selected:stop_hover()
            selected:hover()
        end
    end
})

SMODS.Keybind({
    key_pressed = "lalt",
    event = 'released',
    action = function(self)
        local selected = G and G.CONTROLLER and (G.CONTROLLER.focused.target or G.CONTROLLER.hovering.target)

        if not selected then
            return
        end

        if selected.hover and selected.stop_hover then
            selected:stop_hover()
            selected:hover()
        end
    end
})
