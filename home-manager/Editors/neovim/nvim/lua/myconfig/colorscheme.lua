vim.o.background = "dark"
-- values shown are defaults and will be used if not provided
-- local config = {
--   gruvbox_material_enable_italic = true,
--   gruvbox_material_background = "hard",
--   gruvbox_material_better_performance = 1,
--   gruvbox_material_foreground = "mix",
--   gruvbox_material_transparent_background = 1,
--   gruvbox_material_statusline_style = "mix",
-- }
--
-- for k, v in pairs(config) do
--   vim.g[k] = v
-- end
--
-- vim.cmd.colorscheme("gruvbox-material")

--  _  __
-- | |/ /__ _ _ __   __ _  __ _  __ ___      ____ _
-- | ' // _` | '_ \ / _` |/ _` |/ _` \ \ /\ / / _` |
-- | . \ (_| | | | | (_| | (_| | (_| |\ V  V / (_| |
-- |_|\_\__,_|_| |_|\__,_|\__, |\__,_| \_/\_/ \__,_|
--                        |___/

-- Default options:
require("kanagawa").setup({
  compile = false, -- enable compiling the colorscheme
  undercurl = true, -- enable undercurls
  commentStyle = { italic = false },
  functionStyle = { italic = true },
  keywordStyle = { italic = true },
  statementStyle = { bold = true },
  typeStyle = { bold = true },
  transparent = false, -- do not set background color
  dimInactive = false, -- dim inactive window `:h hl-NormalNC`
  terminalColors = true, -- define vim.g.terminal_color_{0,17}
  colors = { -- add/modify theme and palette colors
    palette = {},
    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
  },
  overrides = function(colors) -- add/modify highlights
    return {}
  end,
  theme = "wave", -- Load "wave" theme
  background = { -- map the value of 'background' option to a theme
    dark = "wave", -- try "dragon" !
    light = "lotus",
  },
})

-- setup must be called before loading
vim.cmd("colorscheme kanagawa")
