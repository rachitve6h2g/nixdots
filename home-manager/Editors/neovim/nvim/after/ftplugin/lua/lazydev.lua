require("lazydev").setup({
  enabled = function(root_dir)
    return not vim.uv.fs_stat(root_dir .. "./.luarc.json")
  end,
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
  integrations = {
    cmp = false,
    coq = false,
  },
})
vim.g.lazydev_enabled = true
