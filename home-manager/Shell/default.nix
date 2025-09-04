{ lib, pkgs, ... }:
{
  imports = [
    ./bat.nix
    ./eza.nix
    ./fzf.nix
    ./kitty.nix
    ./readline.nix
    ./starship
    ./ripgrep.nix
    ./zoxide.nix
  ];

  home = {
    shell = {
      enableBashIntegration = true;
    };

    packages = with pkgs; [ vivid ];
  };

  programs = {
    eza.enableBashIntegration = true;
    fzf.enableBashIntegration = true;
    yazi.enableBashIntegration = true;
    zoxide.enableBashIntegration = true;
    starship.enableBashIntegration = true;
    nix-index.enableBashIntegration = true;
    television.enableBashIntegration = true;
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
      };
      sessionVariables = {
        EDITOR = "nvim";
      };

      bashrcExtra =
        let
          vivid_setup = # bash
            ''
              export LS_COLORS="$(vivid generate gruvbox-dark-hard)"
            '';
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
          vivid_setup
          interactive_dangers
          lazygit_change_dir
        ];
    };
  };
}
