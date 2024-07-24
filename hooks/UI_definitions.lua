local misc = NFS.load(SMODS.current_mod.path .. "/misc_functions.lua")()

--- Credits

function sendNestedMessage(message, logger)
    -- Edited from: Discord message
    -- By: Kenny Stone
    -- Date: 2024-05-08
    if client then
        level = "INFO "
        logger = logger or "DefaultLogger"
        message = message or "Default log message"
        message = tableToString(message)
        -- naive way to separate the logs if the console receive multiple logs at the same time
        client:send(os.date('%Y-%m-%d %H:%M:%S') .. " :: " .. level .. " :: " .. logger .. " :: " .. message .. "ENDOFLOG")
    end
end

function tableToString(t, seen, depth)
    local depth = depth or 0
    if type(t) ~= "table" then
        return tostring(t)
    end
    
    seen = seen or {}
    if seen[t] then
        return "..."  -- Handle cyclic references
    end
    seen[t] = true

    local parts = {}
    for key, value in pairs(t) do
        local keyString = tostring(key)
        local valueString
        if type(value) == "table" then
            valueString = tableToString(value, seen, depth + 1)
        else
            valueString = tostring(value)
        end
        table.insert(parts, '\n'..string.rep(" ", 2*depth)..keyString .. "=" .. valueString)
    end
    return "{" .. table.concat(parts, ", ") .. '\n'..string.rep(" ", 2*depth).."}"
end

function G.UIDEF.vic_speech_bubble(text_key, loc_vars, extra)
    local text = {}
    local extra = extra or {}

    localize{type = 'quips', key = text_key, vars = loc_vars or {}, nodes = text}
    local row = {}
    for k, v in ipairs(text) do
        --v[1].config.colour = extra.text_colour or v[1].config.colour or G.C.JOKER_GREY
        row[#row+1] =  {n=G.UIT.R, config={align = extra.text_alignment or "cl"}, nodes=v}
    end
    local t = {n=G.UIT.ROOT, config = {align = "cm", minh = 1, r = 0.3, padding = 0.07, minw = 1, colour = extra.root_colour or G.C.JOKER_GREY, shadow = true}, nodes={
                  {n=G.UIT.C, config={align = "cm", minh = 1, r = 0.2, padding = 0.1, minw = 1, colour = extra.bg_colour or G.C.WHITE}, nodes={
                  {n=G.UIT.C, config={align = "cm", minh = 1, r = 0.2, padding = 0.03, minw = 1, colour = extra.bg_colour or G.C.WHITE}, nodes=row}}
                  }
                }}
    return t
end

local info_tip_from_rows_ref = info_tip_from_rows
function info_tip_from_rows(desc_nodes, name)
    if name == "cr_vic_credits" then
        local t = {}
        for k, v in ipairs(desc_nodes) do
          t[#t+1] = {n=G.UIT.R, config={align = "cm"}, nodes=v}
        end
        return {n=G.UIT.R, config={align = "cm", colour = darken(G.C.GREY, 0.15), r = 0.1}, nodes={
          {n=G.UIT.R, config={align = "tm", minh = 0.36, padding = 0.03}, nodes={{n=G.UIT.T, config={text = localize('k_vic_credits'), scale = 0.32, colour = G.C.UI.TEXT_LIGHT}}}},
          {n=G.UIT.R, config={align = "cm", minw = 1.5, minh = 0.4, r = 0.1, padding = 0.05, colour = lighten(G.C.GREY, 0.15), emboss = 0.05}, nodes={{n=G.UIT.R, config={align = "cm", padding = 0.03}, nodes=t}}}
        }}
    elseif name == "aux_vic_stheno" then
        return {
           n=G.UIT.R, -- or G.UIT.C
           config={
               align = "cm",
               --padding = 0.05,
               colour = G.C.CLEAR,--lighten(G.C.JOKER_GREY, 0.5),
               r = 0.1,
               --emboss = 0.05
           },
           nodes = misc.create_UIBox_blind_popup_with_icon('bl_vic_rock'),
        }
    else
        return info_tip_from_rows_ref(desc_nodes, name)
    end
end
