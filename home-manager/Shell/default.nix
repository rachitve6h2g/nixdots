{
  lib,
  pkgs,
  ...
}:
let
  userVars = {
    KITTY_ENABLE_WAYLAND = 1;
  };
in
{
  imports = [
    ./bat.nix
    ./eza.nix
    ./fzf.nix
    ./kitty.nix
    ./readline.nix
    ./starship
    ./vivid.nix
    ./ripgrep.nix
    ./zoxide.nix
  ];

  home = {
    shell = {
      enableBashIntegration = true;
    };

    packages = with pkgs; [ vivid ];
    sessionVariables = userVars;
  };

  programs = {
    eza.enableBashIntegration = true;
    fzf.enableBashIntegration = true;
    yazi.enableBashIntegration = true;
    zoxide.enableBashIntegration = true;
    starship.enableBashIntegration = true;
    television.enableBashIntegration = true;
    vivid.enableBashIntegration = true;
    kitty.shellIntegration.enableBashIntegration = true;

    bash = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = false;

      shellAliases = {
        vim = "nvim";
        vi = "nvim";
        ovim = "${pkgs.vim}/bin/vim";

        nixcon = "cd /etc/nixos";
        ".." = "cd ..";
        ns = "tv nix-search-tv";

        btop = "btop --force-utf";
        speedtest = "nix run nixpkgs#speedtest-cli -- --secure";
      };
      sessionVariables = userVars;

      bashrcExtra =
        let
          interactive_dangers = # bash
            ''
              rm() { command rm -i "''${@}"; }
              cp() { command cp -i "''${@}"; }
              mv() { command mv -i "''${@}"; }
              trash() { command trash -i "''${@}"; }
            '';

          lazygit_change_dir = # bash
            ''
              lg()
                {
                    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

                    lazygit "$@"

                    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
                            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
                            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
                    fi
                }
            '';
        in
        lib.mkMerge [
          interactive_dangers
          lazygit_change_dir
        ];
    };
  };
}
