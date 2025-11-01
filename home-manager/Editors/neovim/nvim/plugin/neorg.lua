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
    ["core.integrations.telescope"] = {
      config = {
        insert_file_link = {
          show_title_preview = true,
        },
      },
    },
    ["core.integrations.treesitter"] = {},
  },
})

vim.wo.foldlevel = 99
vim.wo.conceallevel = 2
