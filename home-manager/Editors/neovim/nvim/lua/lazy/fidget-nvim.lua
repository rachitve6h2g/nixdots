return {
  {
    "fidget.nvim",
    after = function()
      require("fidget").setup({
        logger = {
          float_precision = 0.010000,
          level = vim.log.levels.WARN,
          max_size = 10000,
          path = string.format("%s/fidget.nvim.log", vim.fn.stdpath("cache")),
        },
        notification = {
          configs = { default = require("fidget.notification").default_config },
          filter = vim.log.levels.INFO,
          history_size = 128,
          override_vim_notify = false,
          poll_rate = 10,
          redirect = function(msg, level, opts)
            if opts and opts.on_open then
              return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
            end
          end,
          view = {
            group_separator = "---",
            group_separator_hl = "Comment",
            icon_separator = " ",
            render_message = function(msg, cnt)
              return cnt == 1 and msg or string.format("(%dx) %s", cnt, msg)
            end,
            stack_upwards = true,
          },
          window = {
            align = "bottom",
            border = "rounded",
            max_height = 0,
            max_width = 0,
            normal_hl = "Comment",
            relative = "editor",
            winblend = 100,
            x_padding = 1,
            y_padding = 0,
            zindex = 45,
          },
        },
        progress = {
          display = {
            done_icon = "✓",
            done_style = "Constant",
            done_ttl = 3,
            format_annote = function(msg)
              return msg.title
            end,
            format_group_name = function(group)
              return tostring(group)
            end,
            format_message = require("fidget.progress.display").default_format_message,
            group_style = "Title",
            icon_style = "Question",
            overrides = {},
            priority = 30,
            progress_icon = { pattern = "dots", period = 1 },
            progress_style = "WarningMsg",
            progress_ttl = 99999,
            render_limit = 16,
            skip_history = true,
          },
          ignore = {},
          ignore_done_already = false,
          ignore_empty_message = false,
          lsp = { log_handler = false, progress_ringbuf_size = 100 },
          notification_group = function(msg)
            return msg.lsp_client.name
          end,
          poll_rate = 0,
          suppress_on_insert = false,
        },
      })
    end,
    event = "LspAttach",
  },
}
