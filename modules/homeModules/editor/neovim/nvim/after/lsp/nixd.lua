---@type vim.lsp.Config
return {
  cmd = {
    "nixd",
    "--inlay-hints=true",
    "--semantic-tokens=true", -- NEEDED, makes syntax highlighting much better
  },
  filetypes = { "nix" },
  root_markers = { "flake.nix", ".git" },
}
