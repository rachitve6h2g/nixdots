return {
  {
    "blink.cmp",
    event = "InsertEnter",
    after = function()
      cmp = require("blink.cmp")
      lsp_capabilities = cmp.get_lsp_capabilities()
      vim.lsp.config("*", {
        capabilities = lsp_capabilities,
      })

      require("lz.n").trigger_load("colorful-menu.nvim")
      local colorful_menu = require("colorful-menu")

      local default_providers = { "lazydev", "lsp", "path", "snippets", "omni" }

      require("blink.cmp").setup({
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = { preset = "default" },

        appearance = {
          -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
          -- Adjusts spacing to ensure icons are aligned
          nerd_font_variant = "mono",
        },

        -- (Default) Only show the documentation popup when manually triggered
        completion = {
          documentation = {
            auto_show = false,
          },
          ghost_text = { enabled = true },
          accept = {
            auto_brackets = {
              enabled = true,
            },
          },
          menu = {
            draw = {
              columns = { { "kind_icon" }, { "label", "label_description" } },
              components = {
                label = {
                  text = function(ctx)
                    return ctx.label
                  end,

                  highlight = colorful_menu.blink_components_highlight,
                },
              },
            },
          },
        },

        cmdline = {
          enabled = true,
          keymap = {
            preset = "none",
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback" },
          },

          completion = {
            -- In cmdline, we want to manually select something - and once it's
            -- selected, we can keep scrolling
            list = {
              selection = {
                preselect = false,
                auto_insert = true,
              },
            },

            menu = { auto_show = true },
          },
        },

        snippets = { preset = "luasnip" },

        signature = {
          enabled = true,

          window = { show_documentation = true },
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
          default = default_providers,

          providers = {
            -- autosnippets are automatically expanded, so showing the completion
            -- would be a waste of time
            snippets = { opts = { show_autosnippets = false } },

            -- Filtered version of `lsp` that only contains snippets. We do this so we
            -- can only see snippets when pressing Ctrl+s
            lsp_snippets = {
              name = "LSP Snippets",
              module = "blink.cmp.sources.lsp",
              transform_items = function(_, items)
                return vim.tbl_filter(function(item)
                  return item.kind == require("blink.cmp.types").CompletionItemKind.Snippet
                end, items)
              end,
            },

            -- Loading lazydev through blink leads to better completion in a few areas
            -- like require statements
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
            },
          },
        },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "prefer_rust_with_warning" },
      })
    end,
  },

  {
    "colorful-menu.nvim",
    after = function()
      require("colorful-menu").setup({
        ls = {
          lua_ls = {
            -- Maybe you want to dim arguments a bit.
            arguments_hl = "@comment",
          },
        },
      })
    end,
  },
}
