return {
  {
    "neo-tree.nvim",
    -- lazy = false, -- neo-tree lazily loads itself
    keys = {
      {
        "<leader>e",
        "<CMD>Neotree toggle right<CR>",
        desc = "Neotree toggle",
      },
    },
    after = function()
      require("neo-tree").setup({
        close_if_last_window = false,
        popup_border_style = "",
        enable_git_status = true,
        enable_diagnostics = true,
        source_selector = {
          winbar = true,
          truncation_character = "...",
        },
        window = {
          mappings = {
            ["P"] = {
              "toggle_preview",
              config = {
                use_float = true,
                use_image_nvim = true,
                use_snacks_image = false,
              },
            },
          },
        },
      })
    end,
  },
  {
    "nvim-lsp-file-operations",
    after = function()
      require("lsp-file-operations").setup()
    end,
  },
  {
    "image.nvim",
    lazy = false,
    after = function()
      require("image").setup()
    end,
  },
  {
    "nvim-window-picker",
    after = function()
      require("window-picker").setup({
        filter_rules = {
          include_current_win = false,
          autoselect_one = true,
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { "neo-tree", "neo-tree-popup", "notify" },
            -- if the buffer type is one of following, the window will be ignored
            buftype = { "terminal", "quickfix" },
          },
        },
      })
    end,
  },
}
