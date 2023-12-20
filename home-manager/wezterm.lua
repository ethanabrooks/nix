-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Oceanic-Next'
config.font_size = 20
config.keys = {{
    key = 'Enter',
    mods = 'CMD',
    action = wezterm.action.SplitHorizontal {
        domain = 'CurrentPaneDomain'
    }
}, {
    key = 'Enter',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitVertical {
        domain = 'CurrentPaneDomain'
    }
}, {
    key = 'h',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection "Left"
}, {
    key = 'j',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection "Down"
}, {
    key = 'k',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection "Up"
}, {
    key = 'l',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection "Right"
}}

-- and finally, return the configuration to wezterm
return config
