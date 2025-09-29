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
