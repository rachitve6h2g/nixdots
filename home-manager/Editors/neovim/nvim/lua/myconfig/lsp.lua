vim.lsp.inlay_hint.enable(true)

vim.diagnostic.config({
  severity_sort = true,
  float = {
    border = "rounded",
  },
})
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local buffer = args.buf
    if client then
      client.server_capabilities.semanticTokensProvider = nil
      if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, buffer)
      end
    end
    Lib.wk.add({
      buffer = buffer,
      { "<leader>l", group = "LSP" },
      { "<leader>la", vim.lsp.buf.code_action, desc = "Code actions" },
      { "<leader>lr", vim.lsp.buf.rename, desc = "Rename symbol" },
      { "<leader>ld", vim.lsp.buf.definition, desc = "Go to definition" },
      { "<leader>lD", vim.lsp.buf.declaration, desc = "Go to declaration" },
      { "<leader>lt", vim.lsp.buf.type_definition, desc = "Go to type definition" },
    })
  end,
})

-- Replace mode is stupid, and nobody sane would ever use it. If neovim can
-- change K, I can change R.
vim.keymap.del("n", "grn")
nnoremap("R", vim.lsp.buf.rename, { desc = "Rename symbol" })

-- This is just ascii stuff by default - useless to me!
vim.keymap.del({ "n", "x" }, "gra")
vim.keymap.set({ "n", "x" }, "ga", vim.lsp.buf.code_action, { desc = "Code action" })
