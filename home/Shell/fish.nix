{
  pkgs,
  ...
}:
{

  imports = [ ./eza.nix ];
  home = {
    shell.enableFishIntegration = true;
    packages = with pkgs; [ grc ];
  };

  programs = {
    zoxide.enableFishIntegration = true;
    yazi.enableFishIntegration = true;
    starship = {
      enableTransience = true;
      enableInteractive = true;
      enableFishIntegration = true;
    };
    nix-index.enableFishIntegration = true;
    kitty.shellIntegration.enableFishIntegration = true;
    fzf.enableFishIntegration = true;
    eza.enableFishIntegration = true;
    television.enableFishIntegration = true;

    fish = {
      enable = true;
      generateCompletions = true;

      interactiveShellInit = ''
        set fish_greeting
        set -g fish_key_bindings fish_vi_key_bindings
      '';

      functions = {
        __fish_command_not_found_handler = {
          body = "__fish_default_command_not_found_handler $argv[1]";
          onEvent = "fish_command_not_found";
        };
      };

      # preferAbbrs = true;
      shellAbbrs = {
        gco = "git checkout";
        npu = "nix-prefetch-url";
        lg = "lazygit";
        btop = "btop --force-utf";
        ffetch = "fastfetch";
        ns = "tv nix-search-tv";
      };

      plugins = [
        {
          name = "grc";
          src = pkgs.fishPlugins.grc.src;
        }
        {
          name = "z";
          src = pkgs.fishPlugins.z.src;
        }
      ];
    };
  };
}
