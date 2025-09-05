require("mini.files").setup()

vim.keymap.set("n", "\\", "<cmd>lua MiniFiles.open()<CR>")
