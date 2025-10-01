-- No, that's not a typo, the string has setup in it
require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
    disable = { "latex" }, -- Vimtex promises better highlighting
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
  auto_install = false,
  ensure_installed = {},
})

vim.treesitter.language.register("nix", "nix")

require("treesitter-context").setup({
  line_numbers = true,
  max_lines = 0,
  min_window_height = 0,
  mode = "cursor",
  multiline_threshold = 20,
  separator = "-",
  trim_scope = "outer",
  zindex = 20,
})
