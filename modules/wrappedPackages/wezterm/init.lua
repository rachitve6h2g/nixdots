local config = require("nix-info")
-- Pull in the wezterm API
local wezterm = require("wezterm")
-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font = wezterm.font("Iosevka Nerd Font")
config.font_size = 12
config.color_scheme = "Tokyo Night"
config.window_background_opacity = 0.8

config.hide_tab_bar_if_only_one_tab = true
config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"

config.window_padding = {left = 0, right = -1, top = 0, bottom = -5, }

-- Finally, return the configuration to wezterm:
return config
