-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:

-- or, changing the font size and color scheme.
config.font_size = 10
config.font = wezterm.font 'FiraCode Nerd Font'
config.color_scheme = 'Gruvbox Dark (Gogh)'

config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = .80


-- Finally, return the configuration to wezterm:
return config
