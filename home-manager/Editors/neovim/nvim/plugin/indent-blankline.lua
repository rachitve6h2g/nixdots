local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}
local hooks = require("ibl.hooks")
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#ea6962" })
  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#d8a657" })
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#7daea3" })
  vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#e78a4e" })
  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#a9b665" })
  vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#d3869b" })
  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#89b482" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup({ scope = { highlight = highlight } })

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
