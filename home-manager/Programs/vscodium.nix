{ pkgs, ... }:
{
  home.packages = [ pkgs.clang-tools ];
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

          extensions =
            with pkgs.vscode-extensions;
            [
              vscodevim.vim
              mvllow.rose-pine
              llvm-vs-code-extensions.vscode-clangd
            ];

          userSettings = {
            "editor.lineNumbers" = "relative";
            "workbench.iconTheme" = "rose-pine-icons";
            # "workbench.colorTheme" = "Rosé Pine Moon";
            "vim.easymotion" = true;
            "vim.incsearch" = true;
            "vim.useSystemClipboard" = true;
            "vim.hlsearch" = true;
            "vim.insertModeKeyBindings" = [
              {
                "before" = [
                  "j"
                  "j"
                ];
                "after" = [ "Esc" ];
              }
            ];
            "vim.normalModeKeyBindings" = [
              {
                "before" = [ "<Esc>" ];
                "after" = [ ":nohlsearch" ];
              }

              {
                "before" = [ "n" ];
                "after" = [ "nzz" ];
              }

              {
                "before" = [ "N" ];
                "after" = [ "Nzz" ];
              }

            ];
            "redhat.telemetry.enabled" = true;
          };
        };
      };
    };
  };
}
