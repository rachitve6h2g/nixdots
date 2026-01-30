return {
  "gitlinker.nvim",
  after = function()
    require("gitlinker").setup({})
  end,
  cmd = { "GitLink" },
}
