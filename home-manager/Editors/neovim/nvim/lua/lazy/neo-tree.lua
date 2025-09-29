return {
  {
    "neo-tree.nvim",
    lazy = false, -- neo-tree lazily loads itself
    keys = {
      {
        "<leader>e",
        "<CMD>Neotree toggle right<CR>",
        desc = "MiniFiles Toggle",
      },
    },
    before = function()
      require("lz.n").trigger_load("nui")
    end,
    after = function()
      require("neo-tree").setup({
        close_if_last_window = false,
        popup_border_style = "",
        enable_git_status = true,
        enable_diagnostics = true,
      })
    end,
  },
}
