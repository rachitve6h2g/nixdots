{ inputs, ... }:
{
  flake.wrappers.helix =
    {
      wlib,
      pkgs,
      lib,
      ...
    }:
    let
      dprintWrapped = inputs.wrappers.lib.wrapPackage (
        { config, ... }:
        let
          dprintSettings = {
            markdown = {
              lineWidth = 500;
            };
            # HTML files
            markup = {
              indentWidth = 2;
            };
            # CSS files
            malva = {
              indentWidth = 2;
            };
            json = {
              indentWidth = 2;
              trailingCommas = "never";
            };
            excludes = [ ];
            # NOTE: Remember to update plugins on your own, or better still package them using nix
            plugins = [
              "https://plugins.dprint.dev/markdown-0.21.1.wasm" # For markdown
              "https://plugins.dprint.dev/toml-0.7.0.wasm" # For toml formatting
              "https://plugins.dprint.dev/g-plane/pretty_yaml-v0.6.0.wasm" # For yaml
              "https://plugins.dprint.dev/g-plane/malva-v0.15.2.wasm" # For css
              "https://plugins.dprint.dev/g-plane/markup_fmt-v0.26.0.wasm" # For HTML
              "https://plugins.dprint.dev/json-0.21.1.wasm" # For JSON/JSONC Formatting
            ];
          };
        in
        {
          inherit pkgs;

          package = pkgs.dprint;
          flags = {
            "--config" = "${placeholder "out"}/${config.binName}-config/dprint.json";
          };
          env = {
            DPRINT_MAX_THREADS = "4";
            DPRINT_EDITOR = "hx";
            DPRINT_CONFIG_DIR = "${placeholder "out"}/${config.binName}-config/";
          };
          binName = "dprint";
          drv = {
            dprintConfig = (pkgs.formats.json { }).generate "dprint.json" dprintSettings;
            passAsFile = [ "dprintConfig" ];
            buildPhase = ''
              runHook preBuild
              mkdir -p "$out/${config.binName}-config"
              cp "$(cat "$dprintConfigPath")" "$out/${config.binName}-config/dprint.json"
              runHook postBuild
            '';
          };
        }
      );
    in
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
          smart-tab = {
            enable = true;
            supersede-menu = true;
          };
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          auto-format = true;
          bufferline = "multiple";
          cursorline = true;
          line-number = "relative";
          end-of-line-diagnostics = "hint";
          # inline-diagnostics.cursor-line = "warning";
          indent-guides = {
            render = true;
            character = "⸽";
            skip-levels = 1;
          };
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

          # For ron file formats
          {
            name = "ron";
            injection-regex = "ron";
            language-servers = [ "ron-lsp" ];
          }

          # For fish
          {
            name = "fish";
            language-servers = [ "fish-lsp" ];
          }
          {
            name = "lua";
            auto-format = true;
          }

          # Dprint formatter for markdown
          {
            name = "markdown";
            soft-wrap = {
              enable = true;
              wrap-at-text-width = true;
            };
            auto-format = true;
            formatter = {
              command = lib.getExe dprintWrapped;
              args = [
                "fmt"
                "--stdin"
                "md"
              ];
            };
          }

          # For HTML and CSS
          {
            name = "html";
            auto-format = true;
            formatter = {
              command = lib.getExe dprintWrapped;
              args = [
                "fmt"
                "--stdin"
                "html"
              ];
            };
          }
          {
            name = "css";
            auto-format = true;
            formatter = {
              command = lib.getExe dprintWrapped;
              args = [
                "fmt"
                "--stdin"
                "css"
              ];
            };
          }

          # For JSON formatting
          {
            name = "json";
            formatter = {
              command = lib.getExe dprintWrapped;
              args = [
                "fmt"
                "--stdin"
                "json"
              ];
            };
          }

          # For fennel, used to set up xplr files
          {
            name = "fennel";
            auto-format = true;
            injection-regex = "fennel";
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
          ron-lsp = {
            command = lib.getExe pkgs.ron-lsp;
            # args = []
          };
        };
      };
      extraPackages = with pkgs; [
        lldb # Debug adapter for C/C++
        clang-tools # For clangd c/c++ language server
        marksman # For Markdown Language
        markdown-oxide # For markdown
        nil # For nix! yeah two is better than one
        nixd # For nix files
        bash-language-server # For bash language server
        fennel-ls # Used for configuring xplr in fennel and lua alternative files
        fnlfmt # Formatter for fennel files
        fish-lsp # For the fish shell
        lua-language-server # for lua
        stylua # For formatting lua
        vscode-langservers-extracted # For html, css, jSON, and ESLint
        superhtml # Language server for HTML
        systemd-lsp # For systemd service files
        dprintWrapped # for formatting various filetypes
        ron-lsp # For ron file formats
      ];
    };
}
