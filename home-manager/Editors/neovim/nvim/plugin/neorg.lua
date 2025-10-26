require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {},
    ["core.dirman"] = {
      config = {
        workspaces = {
          notes = "~/Documents/Notes",
        },
        default_workspace = "notes",
      },
    },
  },
})

vim.wo.foldlevel = 99
vim.wo.conceallevel = 2
