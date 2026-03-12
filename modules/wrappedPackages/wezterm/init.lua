local config = require("nix-info")
local wezterm = require("wezterm")

--[[ config.initial_cols = 120
config.initial_rows = 28 --]]

config.font = wezterm.font("Maple Mono NF")
config.font_size = 11
config.color_scheme = "Tokyo Night"
config.window_background_opacity = 0.8

config.hide_tab_bar_if_only_one_tab = true
-- config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"

config.window_padding = { left = 0, right = -1, top = 0, bottom = -5, }

config.enable_kitty_keyboard = true -- Enable kitty's keyboard configuration
config.keys = {}                    -- disable default keys

config.enable_wayland = true
config.warn_about_missing_glyphs = true

config.use_fancy_tab_bar = false
config.show_tabs_in_tab_bar = false
config.enable_tab_bar = false
return config
