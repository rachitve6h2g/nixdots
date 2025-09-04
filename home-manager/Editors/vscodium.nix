{ pkgs, ... }:
{
  home.packages = with pkgs; [
    clang-tools
    nixfmt-rfc-style
    nixd
  ];

  programs = {
    vscode = {
      enable = true;
      package = pkgs.vscodium;

      # Wheter VSCodium can update/install extensions manually.
      mutableExtensionsDir = false;

      profiles = {
        default = {
          enableExtensionUpdateCheck = true;
          enableUpdateCheck = true;

          extensions = with pkgs.vscode-extensions; [
            bierner.github-markdown-preview
            christian-kohler.path-intellisense
            foxundermoon.shell-format
            llvm-vs-code-extensions.vscode-clangd
            jnoortheen.nix-ide
            oderwat.indent-rainbow
            redhat.java
            tamasfe.even-better-toml
            timonwong.shellcheck
            vscodevim.vim
          ];

          userSettings = {
            "editor.lineNumbers" = "relative";
            "editor.formatOnSave" = true;
            "files.trimTrailingWhitespace" = true;
            "workbench.iconTheme" = "catppuccin-mocha";
            "redhat.telemetry.enabled" = true;
            "nix.enableLanguageServer" = true;
            "nix.serverPath" = "nixd";
            "nix.serverSettings" = {
              "nixd" = {
                "formatting" = {
                  "command" = [ "nixfmt" ];
                };

                "options" = {
                  "nixos" = {
                    "expr" = ''(builtins.getFlake "/home/krish/.dotfiles").nixosConfigurations.hppavilion.options'';
                  };
                };
              };
            };

            "nix.formatterPath" = "nixfmt";

            # Open git repo in parent folder (don't know what that means):
            "git.openRepositoryInParentFolders" = "always";
            "git.autofetch" = true;
            "git.confirmSync" = true;

            "path-intellisense.extensionOnImport" = true;
            "path-intellisense.showHiddenFiles" = true;

            # Vim mode keybindings
            "vim.easymotion" = true;
            "vim.incsearch" = true;
            "vim.useCtrlKeys" = true;
            "vim.insertModeKeyBindings" = [
              {
                "before" = [
                  "j"
                  "j"
                ];
                "after" = [ "<Esc>" ];
              }
            ];

            "vim.normalModeKeyBindingsNonRecursive" = [
              {
                "before" = [ "<Esc>" ];
                "commands" = [ ":nohl" ];
              }
            ];
            "vim.leader" = "<space>";
            "extension.experimental.affinity" = {
              "vscodevim.vim" = 1;
            };
          };
        };
      };
    };
  };
}
