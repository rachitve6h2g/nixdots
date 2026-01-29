return {
  {
    "aerial.nvim",
    keys = {
      { "<leader>a", "<cmd>AerialToggle!<CR>", desc = "Aerial toggle" },
    },

    after = function()
      require("aerial").setup({
        on_attach = function(bufnr)
          vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
      })
    end,
  },
}
