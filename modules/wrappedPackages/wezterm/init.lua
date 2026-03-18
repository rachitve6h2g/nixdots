local config = require("nix-info")
local wezterm = require("wezterm")

--[[ config.initial_cols = 120
config.initial_rows = 28 --]]
config.font = wezterm.font("Maple Mono NF")
config.font_size = 11
-- config.color_scheme = "Gruvbox Material (Gogh)"
config.color_scheme = "base16Wez"
config.window_background_opacity = 0.8

config.hide_tab_bar_if_only_one_tab = true
-- config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"

config.window_padding = {
  --[[ left = 0,
  right = -1,
  top = 0,
  bottom = -5, --]]
  left = 20,
  right = 20,
  top = 20,
  bottom = 20,
}

config.enable_kitty_keyboard = true -- Enable kitty's keyboard configuration

--- Keybindings ---
config.keys = {
  {
    key = 's',
    mods = 'ALT',
    -- This triggers the "Ace-window" style picker
    action = wezterm.action.PaneSelect {
      alphabet = 'arstgmneioqwfpbjluuy',
    },
  },
}

config.enable_wayland = true
config.warn_about_missing_glyphs = true

config.use_fancy_tab_bar = false
config.show_tabs_in_tab_bar = false
config.enable_tab_bar = false
return config
