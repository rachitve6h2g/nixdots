return {
  {
    "markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    keys = {
      {
        "<leader>cp",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    after = function()
      vim.cmd([[do FileType]])
    end,
  },

  {
    "render-markdown.nvim",
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
    after = function()
      require("render-markdown").setup({
        code = {
          sign = false,
          width = "block",
          right_pad = 1,
        },
        heading = {
          sign = false,
          icons = {},
        },
        checkbox = {
          enabled = false,
        },
      })
    end,
  },
}
