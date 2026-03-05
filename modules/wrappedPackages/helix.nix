{
  flake.wrappers.helix =
    {
      wlib,
      pkgs,
      lib,
      ...
    }:
    {
      imports = [ wlib.wrapperModules.helix ];
      settings = {
        theme = "tokyonight_transparent";
        keys.insert = {
          # Force learn modal editing
          # Disable arrow keys in insert mode
          up = "no_op";
          down = "no_op";
          left = "no_op";
          right = "no_op";
          pageup = "no_op";
          pagedown = "no_op";
          home = "no_op";
          end = "no_op";
        };
        editor = {
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          auto-format = true;
          bufferline = "multiple";
          cursorline = true;
          line-number = "relative";
        };
      };
      themes = {
        tokyonight_transparent = {
          "inherits" = "tokyonight";
          "ui.background" = { };
        };
      };
      languages = {
        language = [

          # For nix files
          {
            name = "nix";
            auto-format = true;
            formatter.command = lib.getExe pkgs.nixfmt;
          }

          # For scripts and stuff
          {
            name = "bash";
            auto-format = true;
            language-servers = [ "bash-language-server" ];
            formatter = {
              command = lib.getExe pkgs.shfmt;
              args = [
                "-i"
                "2"
                "-ci"
                "-sr"
                "-bn"
                "-kp"
              ];
            };
          }

          # For fish
          {
            name = "fish";
            language-servers = [ "fish-lsp" ];
          }
        ];
        language-server = {
          bash-language-server = {
            command = lib.getExe pkgs.bash-language-server;
            args = [ "start" ];
          };
          fish-lsp = {
            command = lib.getExe pkgs.fish-lsp;
            args = [ "start" ];
            environment = {
              "fish_lsp_show_client_popups" = "false";
            };
          };
        };
      };
      extraPackages = with pkgs; [
        lldb # Debug adapter for C/C++
        clang-tools # For clangd c/c++ language server
        marksman # For Markdown Language
        nixd # For nix files
        bash-language-server # For bash language server
        fish-lsp # For the fish shell
        lua-language-server # for lua
        stylua # For formatting lua
        vscode-json-languageserver # For JSON
        vscode-css-languageserver # For CSS
        systemd-lsp # For systemd service files
      ];
    };
}
