# Toggle ASS/SSA Subtitle Style Override (SSO) for mpv

A small **mpv** script that toggles forced subtitle styling (ASS Override) for ASS/SSA tracks with a single key press.

## What the script does

- Checks whether the currently selected subtitle track is in **ASS** or **SSA** format.
- If it is, pressing **Page Down** (`PGDWN`) toggles a forced style on/off:
  - **On**:  
    `sub-ass-override = force`  
    `sub-ass-force-style = Bold=1,Fontsize=36`  
    `sub-use-margins = yes`  
    `sub-pos = 98`
  - **Off**:  
    `sub-ass-override = no`  
    `sub-ass-force-style = ""`  
    (other properties remain unchanged)
- Shows an OSD message:  
  `ASS Override: on` / `ASS Override: off`
- If the current subtitles are **not** ASS/SSA, it simply displays `¯\(ツ)/¯` and does nothing.

The on/off state is stored in the `custom_style` variable and persists between presses.

## How it works

1. Retrieves the full track list (`track-list`).
2. Finds the currently selected subtitle track (`type == "sub"` and `selected`).
3. Reads its codec (`track.codec`).
4. If the codec is `ass` or `ssa`, it toggles the relevant mpv properties.
5. Otherwise, it only shows the OSD message.

The script uses the standard mpv Lua API (`mp.get_property_native`, `mp.set_property`, `mp.osd_message`, `mp.add_key_binding`).

## Installation

1. Copy `sso.lua` into your mpv scripts folder:
   - Linux / macOS: `~/.config/mpv/scripts/`
   - Windows: `%APPDATA%\mpv\scripts\`
2. Restart mpv (or open a new file).

## Hotkey

Default: **Page Down** (`PGDWN`).

To change it, find this line at the end of the file:

```lua
mp.add_key_binding("PGDWN", "toggle-sub-style", toggle_sub_style)
```

and replace `"PGDWN"` with the desired key (e.g. `"b"`, `"Ctrl+s"`, `"MOUSE_BTN3"`, etc.).

## What you can easily change

### 1. Forced style applied when override is enabled

Find this line:

```lua
mp.set_property("sub-ass-force-style", "Bold=1,Fontsize=36")
```

You can set any ASS style properties, separated by commas, for example:

```lua
"Bold=1,Fontsize=42,PrimaryColour=&H00FFFFFF,Outline=2,Shadow=1"
```

Common parameters:
- `Fontname=Arial`
- `Fontsize=40`
- `Bold=1` / `Italic=1`
- `PrimaryColour=&H00FFFFFF` (white)
- `OutlineColour=&H00000000`
- `BackColour=&H80000000`
- `Outline=2`
- `Shadow=1`
- `Alignment=2` (bottom center)
- `MarginV=40`, etc.

### 2. Subtitle position

Currently:

```lua
mp.set_property("sub-pos", "98")
```

Value ranges from `0` (top) to `100` (bottom). `98` places the subtitles near the very bottom.

### 3. Use of margins

Currently always set to `yes`. You can change it to `no` if you prefer:

```lua
mp.set_property("sub-use-margins", "no")
```

### 4. OSD messages

You can customize the texts:

```lua
mp.osd_message("ASS Override: on")
mp.osd_message("ASS Override: off")
mp.osd_message([[¯\(ツ)/¯]])
```

### 5. Behavior for non-ASS subtitles

Currently it just shows a shrug. You can change the message or make it do nothing.

## Example of a bolder style

```lua
mp.set_property("sub-ass-force-style", "Bold=1,Fontsize=40,Outline=3,Shadow=2,PrimaryColour=&H00FFFFFF,OutlineColour=&H00000000")
```

## Requirements

- mpv with Lua script support (available in almost all builds).
- Subtitles in ASS or SSA format (embedded or external `.ass`/`.ssa` files).

## Notes

- If you encounter any bugs, errors, or have ideas on how to improve the script, please let me know! You can open an **Issue** here on GitHub or submit a **Pull Request**. I will gladly find the time to review your feedback and fix any problems.

---

The script is minimal and requires no config files. All settings are edited directly in the code.

---

## Support

If you find this script useful, you can support my work with a voluntary donation. I truly love coffee but honestly can't afford to buy it right now, so any support would genuinely buy my next cup! ❤️
[**Support via DonationAlerts**](https://www.donationalerts.com/r/zatserkovnyy)
