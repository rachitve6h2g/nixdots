return {
  {
    "toggleterm-nvim",
    after = function()
      require("toggleterm").setup({
        direction = "horizontal",
        enable_winbar = true,
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        winbar = {
          enable = true,
          enabled = true,
          name_formatter = function(term)
            return term.name
          end,
        },
      })
      local terminal = require("toggleterm.terminal")
      local lazygit = terminal.Terminal:new({
        cmd = "/nix/store/vagzw1wlfdjqd9v61c74jzq0k6jdl30v-lazygit-0.55.1/bin/lazygit",
        direction = "float",
        hidden = true,
        on_open = function(term)
          vim.cmd("startinsert!")
        end,
      })

      vim.keymap.set("n", "<leader>gg", function()
        lazygit:toggle()
      end, { silent = true, noremap = true, desc = "Open lazygit [toggleterm]" })
    end,
    cmd = {
      "ToggleTerm",
      "ToggleTermSendCurrentLine",
      "ToggleTermSendVisualLines",
      "ToggleTermSendVisualSelection",
      "ToggleTermSetName",
      "ToggleTermToggleAll",
    },
    keys = {
      {
        "<c-t>",
        '<Cmd>execute v:count . "ToggleTerm"<CR>',
        desc = "Toggle terminal",
        expr = false,
        mode = "n",
        noremap = true,
        nowait = false,
        script = false,
        silent = true,
        unique = false,
      },
      {
        "<leader>gg",
        desc = "Open lazygit [toggleterm]",
        expr = false,
        mode = "n",
        noremap = true,
        nowait = false,
        script = false,
        silent = true,
        unique = false,
      },
    },
  },
}
