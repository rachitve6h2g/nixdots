---@type vim.lsp.Config
return {
  cmd = {
    "nixd",
    "--inlay-hints=false",
    "--semantic-tokens=true", -- NEEDED, makes syntax highlighting much better
  },
}
