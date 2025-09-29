vim.opt.termguicolors = true

require("bufferline").setup({
  options = {
    diagnostics = "nvim_lsp",
    numbers = "both",
    indicator = {
      style = "underline",
    },
    diagnostics = "nvim_lsp",
    color_icons = true,
    separator_style = "slant",

    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " " or (e == "warning" and " " or " ")
        s = s .. n .. sym
      end
      return s
    end,
    offsets = {
      {
        filetype = "neo-tree",
        text = "File Explorer",
        highlight = "Directory",
        separator = true,
      },
    },
  },
})
