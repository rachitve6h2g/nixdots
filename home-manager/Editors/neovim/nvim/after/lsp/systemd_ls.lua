---@type vim.lsp.Config
return {
  cmd = { "systemd-language-server" },
  filetypes = { "systemd" },
  root_markers = { ".git" },
}
