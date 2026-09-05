-- =======================================================
-- Script: sso.lua
-- Description: Toggle ASS/SSA Subtitle Style Override (SSO) for mpv
-- Author: Boris Zatserkovnyy
-- Version: 1.0.1
-- GitHub: https://github.com/zatserkovnyy/mpv-sso
-- =======================================================

function toggle_sub_style()
    local track_list = mp.get_property_native("track-list")
    local sub_format = ""

    for _, track in ipairs(track_list) do
        if track.type == "sub" and track.selected then
            sub_format = track.codec
            break
        end
    end

    if sub_format == "ass" or sub_format == "ssa" then
        local current_override = mp.get_property("sub-ass-override")

        if current_override ~= "force" then
            mp.set_property("sub-ass-override", "force")
            mp.set_property("sub-ass-force-style", "Bold=1,Fontsize=36")
            mp.set_property("sub-use-margins", "yes")
            mp.set_property("sub-pos", "98")
            mp.osd_message("ASS Override: on")
        else
            mp.set_property("sub-ass-override", "no")
            mp.set_property("sub-ass-force-style", "")
            mp.osd_message("ASS Override: off")
        end
    else
        mp.osd_message([[¯\_(ツ)_/¯]])
    end
end

mp.add_key_binding("PGDWN", "toggle-sub-style", toggle_sub_style)
