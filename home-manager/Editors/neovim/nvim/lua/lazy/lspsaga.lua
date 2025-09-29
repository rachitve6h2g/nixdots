return {
  {
    "lspsaga.nvim",
    after = function()
      require("lspsaga").setup({ border_style = "rounded" })
    end,
    event = "LspAttach",
  },
}
