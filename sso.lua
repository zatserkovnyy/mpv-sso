-- =======================================================
-- Script: sso.lua
-- Author: Boris Zatserkovnyy
-- Version: 1.0.0
-- GitHub: https://github.com/zatserkovnyy/mpv-sso
-- =======================================================
local SCRIPT_VERSION = "1.0.0"

local custom_style = false

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
        if not custom_style then
            mp.set_property("sub-ass-override", "force")
            mp.set_property("sub-ass-force-style", "Bold=1,Fontsize=36")
            mp.set_property("sub-use-margins", "yes")
            mp.set_property("sub-pos", "98")
            mp.osd_message("ASS Override: on")
            custom_style = true
        else
            mp.set_property("sub-ass-override", "no")
            mp.set_property("sub-ass-force-style", "")
            mp.set_property("sub-use-margins", "yes")
            mp.set_property("sub-pos", "98")
            mp.osd_message("ASS Override: off")
            custom_style = false
        end
    else
        mp.osd_message([[¯\(ツ)/¯]])
    end
end

mp.add_key_binding("PGDWN", "toggle-sub-style", toggle_sub_style)
