-- values shown are defaults and will be used if not provided
require("gruvbox-material").setup({
  italics = true, -- enable italics in general
  contrast = "hard", -- set contrast, can be any of "hard", "medium", "soft"
  comments = {
    italics = false, -- enable italic comments
  },
  background = {
    transparent = true, -- set the background to be opaque
  },
  float = {
    force_background = false, -- set to true to force backgrounds on floats even when
    -- background.transparent is set
    background_color = nil, -- set color for float backgrounds. If nil, uses the default color set
    -- by the color scheme
  },
  signs = {
    force_background = false, -- set to true to force backgrounds on signs even when
    -- background.transparent is set
    background_color = nil, -- set color for sign backgrounds. If nil, uses the default color set
    -- by the color scheme
  },
  customize = nil, -- customize the theme in any way you desire, see below what this
  -- configuration accepts
})
