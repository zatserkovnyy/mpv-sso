-- =======================================================
-- Script: sso.lua
-- Description: Toggle ASS/SSA Subtitle Style Override (SSO) for mpv
-- Author: Boris Zatserkovnyy
-- Version: 1.0.2
-- GitHub: https://github.com/zatserkovnyy/mpv-sso
-- =======================================================

local function get_active_sub_format()
    for _, track in ipairs(mp.get_property_native("track-list") or {}) do
        if track.type == "sub" and track.selected then
            return track.codec
        end
    end
    return nil
end

function toggle_sub_style()
    local sub_format = get_active_sub_format()

    if sub_format ~= "ass" and sub_format ~= "ssa" then
        mp.osd_message([[¯\_(ツ)_/¯]])
        return
    end

    local is_override_active = mp.get_property("sub-ass-override") == "force"

    if is_override_active then
        mp.set_property("sub-ass-override", "no")
        mp.set_property("sub-ass-force-style", "")
        mp.osd_message("ASS Override: off")
    else
        mp.set_property("sub-ass-override", "force")
        mp.set_property("sub-ass-force-style", "Bold=1,Fontsize=36")
        mp.set_property("sub-use-margins", "yes")
        mp.set_property("sub-pos", "98")
        mp.osd_message("ASS Override: on")
    end
end

mp.add_key_binding("PGDWN", "toggle-sub-style", toggle_sub_style)
