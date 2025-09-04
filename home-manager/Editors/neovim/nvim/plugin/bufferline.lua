-- vim.opt.termguicolors = true
local bufferline = require("bufferline")

bufferline.setup({
  -- rest of config ...

  --- count is an integer representing total count of errors
  --- level is a string "error" | "warning"
  --- diagnostics_dict is a dictionary from error level ("error", "warning" or "info")to number of errors for each level.
  --- this should return a string
  --- Don't get too fancy as this function will be executed a lot
  options = {
    separator_style = "slant",
    style_preset = {
      bufferline.style_preset.no_italic,
      bufferline.style_preset.no_bold,
    },

    offsets = {
      {
        filetype = "Neotree",
        text = function()
          return vim.fn.getcwd()
        end,
        text_align = "right",
        highlight = "Directory",
        separator = true,
      },
    },
    color_icons = true,
    indicator = { style = "icon" },
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
  },

  -- highlights = {
  --   fill = {
  --     bg = "#1d2021",
  --   },
  --   tab_separator = { bg = "#1d2021" },
  --   tab_separator_selected = { bg = "#1d2021" },
  --   -- separator = { bg = "#1d2021" },
  -- },
})
