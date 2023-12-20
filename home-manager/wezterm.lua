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
config = {
    color_scheme = 'Oceanic-Next',
    font_size = 20,
    keys = {{
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
    }},
    ssh_domains = {{
        -- This name identifies the domain
        name = 'rldl17',
        -- The hostname or address to connect to. Will be used to match settings
        -- from your ssh config file
        remote_address = 'rldl17.eecs.umich.edu',
        -- The username to use on the remote host
        username = 'ethanbro',
        remote_wezterm_path = '/home/ethanbro/.nix-profile/bin/wezterm'
    }}

}

-- and finally, return the configuration to wezterm
return config
