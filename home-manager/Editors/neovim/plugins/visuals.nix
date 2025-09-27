{ lib, ... }:
let
  inherit (lib.generators) mkLuaInline;
  inherit (lib.nvim.dag) entryBefore entryAfter;
in
{
  vim = let ibl_highlight = [
                "RainbowRed"
                "RainbowYellow"
                "RainbowBlue"
                "RainbowOrange"
                "RainbowGreen"
                "RainbowViolet"
                "RainbowCyan"
]; in {
    luaConfigRC = {
      indent-blankline-pre =
        entryBefore [ "indent-blankline" ] # lua
          ''
            -- A precursor Lua module that defines Lua locals that can be accessed in
            -- ibl's setup function. All Lua locals defined here will be made available
            -- to the DAG node in which ibl's setup is handled.
            local highlight = {
                "RainbowRed",
                "RainbowYellow",
                "RainbowBlue",
                "RainbowOrange",
                "RainbowGreen",
                "RainbowViolet",
                "RainbowCyan",
            }
            -- This Lua chunk will be placed *after* ibl's setup is done.
            local ibl_hooks = require "ibl.hooks"

            -- create the highlight groups in the highlight setup hook, so they are reset
            -- every time the colorscheme changes
            ibl_hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
                vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
                vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
                vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
            end)
            vim.g.rainbow_delimiters = { highlight = highlight }
          '';

          indent-blankline-post = entryAfter [ "indent-blankline" ] #lua
          ''
            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
          '';
    };

    visuals = {
      nvim-cursorline = {
        enable = true;
        setupOpts = {
          cursorline = {
            enable = true;
            number = true;
            cursorword = {
              enable = true;
              hl.underline = true;
            };
          };
        };
      };

      indent-blankline = {
        enable = true;

        setupOpts = {
          indent = {
            char = "│";
          };
          scope.highlight = ibl_highlight;
        };
      };

      rainbow-delimiters = {
        enable = true;
      };

      nvim-web-devicons.enable = true;
      fidget-nvim.enable = true;
    };

    # for rainbow-delimiters integration with indent-blankline
    # vim.g.rainbow_delimiters option
    # globals = {
    #   rainbow_delimiters = ibl_highlight;
    # };
  };
}
