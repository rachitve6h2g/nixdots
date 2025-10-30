require("lualine").setup({
  options = {
    always_divide_middle = true,
    component_separators = { left = "", right = "" },
    globalstatus = true,
    icons_enabled = true,
    theme = "auto",
    component_separators = "",
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = {
      { "mode", separator = { left = "" }, right_padding = 2 },
    },
    lualine_b = { "filename", { "branch", icon = " •" } },
    lualine_c = {
      "%=", --[[ add your center components here in place of this comment ]]
      {
        "diff",
        colored = false,
        diff_color = {
          -- Same color values as the general color option can be used here.
          added = "DiffAdd", -- Changes the diff's added color
          modified = "DiffChange", -- Changes the diff's modified color
          removed = "DiffDelete", -- Changes the diff's removed color you
        },
        symbols = { added = "+", modified = "~", removed = "-" }, -- Changes the diff symbols
        separator = { right = "" },
      },
    },
    lualine_x = {
      {
        -- Lsp server name
        function()
          local buf_ft = vim.bo.filetype
          local excluded_buf_ft = { toggleterm = true, NvimTree = true, ["neo-tree"] = true, TelescopePrompt = true }

          if excluded_buf_ft[buf_ft] then
            return ""
          end

          local bufnr = vim.api.nvim_get_current_buf()
          local clients = vim.lsp.get_clients({ bufnr = bufnr })

          if vim.tbl_isempty(clients) then
            return "No Active LSP"
          end

          local active_clients = {}
          for _, client in ipairs(clients) do
            table.insert(active_clients, client.name)
          end

          return table.concat(active_clients, ", ")
        end,
        icon = " ",
        separator = { left = "" },
      },
      {
        "diagnostics",
        sources = { "nvim_lsp", "nvim_diagnostic", "nvim_diagnostic", "vim_lsp", "coc" },
        symbols = { error = "󰅙  ", warn = "  ", info = "  ", hint = "󰌵 " },
        colored = true,
        update_in_insert = false,
        always_visible = false,
        diagnostics_color = {
          color_error = { fg = "red" },
          color_warn = { fg = "yellow" },
          color_info = { fg = "cyan" },
        },
      },
    },
    lualine_y = { "filetype", "progress" },
    lualine_z = {
      { "location", separator = { right = "" }, left_padding = 2 },
      {
        "fileformat",
        color = { fg = "black" },
        symbols = {
          unix = "", -- e712
          dos = "", -- e70f
          mac = "", -- e711
        },
        separator = { right = "" },
      },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})
