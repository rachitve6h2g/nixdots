vim.lsp.inlay_hint.enable(true)
vim.lsp.config("*", {
  root_markers = { ".git" },
})

vim.lsp.enable({ "lua_ls", "nixd", "clangd", "qmlls", "bashls", "marksman", "mutt_ls", "taplo", "systemd_ls" })

vim.diagnostic.config({
  severity_sort = true,
  float = {
    border = "rounded",
  },
})

-- -- Replace mode is stupid, and nobody sane would ever use it. If neovim can
-- -- change K, I can change R.
-- vim.keymap.del("n", "grn")
-- nnoremap("R", vim.lsp.buf.rename, { desc = "Rename symbol" })
--
-- -- This is just ascii stuff by default - useless to me!
-- vim.keymap.del({ "n", "x" }, "gra")
-- vim.keymap.set({ "n", "x" }, "ga", vim.lsp.buf.code_action, { desc = "Code action" })
