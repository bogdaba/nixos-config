
local wezterm = require 'wezterm'
return {
    color_scheme = 'Dracula+',
    -- color_scheme = 'Doom One',
    enable_tab_bar = false,
    -- font_size = 14.0,
    font = wezterm.font('Fira Code'),
    cursor_blink_rate = 0,
    default_cursor_style = 'SteadyBlock',
    -- macos_window_background_blur = 40,
    -- macos_window_background_blur = 30,

    -- window_background_image = '/Users/omerhamerman/Downloads/3840x1080-Wallpaper-041.jpg',
    -- window_background_image_hsb = {
    -- 	brightness = 0.01,
    -- 	hue = 1.0,
    -- 	saturation = 0.5,
    -- },
    -- window_background_opacity = 0.92,
    window_background_opacity = 1.0,
    -- window_background_opacity = 0.78,
    -- window_background_opacity = 0.20,
    window_decorations = 'RESIZE',
    keys = {
        {
            key = 'f',
            mods = 'CTRL',
            action = wezterm.action.ToggleFullScreen,
        },
        {
            key = 'h',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.ActivatePaneDirection 'Left',
        },
        {
            key = 'l',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.ActivatePaneDirection 'Right',
        },
        {
            key = 'k',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.ActivatePaneDirection 'Up',
        },
        {
            key = 'j',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.ActivatePaneDirection 'Down',
        },
        {
        key = 'w',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.CloseCurrentPane { confirm = true },
        },

    },
    mouse_bindings = {
        -- Ctrl-click will open the link under the mouse cursor
        {
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'CTRL',
        action = wezterm.action.OpenLinkAtMouseCursor,
        },
    },
}
