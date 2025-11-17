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
-- require("kanagawa").setup({
--   compile = false, -- enable compiling the colorscheme
--   undercurl = true, -- enable undercurls
--   commentStyle = { italic = true },
--   functionStyle = { italic = true },
--   keywordStyle = { italic = true },
--   statementStyle = { bold = true },
--   typeStyle = { bold = true },
--   transparent = false, -- do not set background color
--   dimInactive = false, -- dim inactive window `:h hl-NormalNC`
--   terminalColors = true, -- define vim.g.terminal_color_{0,17}
--   colors = { -- add/modify theme and palette colors
--     palette = {},
--     theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
--   },
--   overrides = function(colors) -- add/modify highlights
--     return {}
--   end,
--   theme = "wave", -- Load "wave" theme
--   background = { -- map the value of 'background' option to a theme
--     dark = "wave", -- try "dragon" !
--     light = "lotus",
--   },
-- })
--
-- -- setup must be called before loading
-- vim.cmd("colorscheme kanagawa")

--            _
--   ___ __ _| |_ _ __  _ __   ___ ___ _   _
--  / __/ _` | __| '_ \| '_ \ / __/ __| | | |
-- | (_| (_| | |_| |_) | |_) | (_| (__| |_| |
--  \___\__,_|\__| .__/| .__/ \___\___|\__, |
--               |_|   |_|             |___/
--
require("catppuccin").setup({
  flavour = "auto", -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = "latte",
    dark = "mocha",
  },
  transparent_background = false, -- disables setting the background color.
  float = {
    transparent = false, -- enable transparent floating windows
    solid = false, -- use solid styling for floating windows, see |winborder|
  },
  show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
  term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
  dim_inactive = {
    enabled = false, -- dims the background color of inactive window
    shade = "dark",
    percentage = 0.15, -- percentage of the shade to apply to the inactive window
  },
  no_italic = false, -- Force no italic
  no_bold = false, -- Force no bold
  no_underline = false, -- Force no underline
  styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
    comments = { "italic" }, -- Change the style of comments
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
    -- miscs = {}, -- Uncomment to turn off hard-coded styles
  },
  lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
    virtual_text = {
      errors = { "italic" },
      hints = { "italic" },
      warnings = { "italic" },
      information = { "italic" },
      ok = { "italic" },
    },
    underlines = {
      errors = { "underline" },
      hints = { "underline" },
      warnings = { "underline" },
      information = { "underline" },
      ok = { "underline" },
    },
    inlay_hints = {
      background = true,
    },
  },
  color_overrides = {},
  custom_highlights = {},
  default_integrations = true,
  auto_integrations = true,
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    notify = true,
    mini = {
      enabled = true,
      indentscope_color = "",
    },
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
})

-- setup must be called before loading
vim.cmd.colorscheme("catppuccin")
