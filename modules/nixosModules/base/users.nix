{ self, ... }:
{
  flake.nixosModules.users =
    {
      pkgs,
      ...
    }:

    let
      selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      documentation.man.cache.enable = false; # from NixOS wiki on fish

      # When installing, remember to use 'nixos-install --no-root-passwd'
      # to use the initialPassword. However, post-installation always change
      # password
      users.users."krish" = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "systemd-journal"
          "video"
          "audio"
          "greeter"
          "networkmanager"
          "input"
          "ydotool"
        ]; # Enable ‘sudo’ for the user.

        initialPassword = "1234";
      };

      programs = {
        fzf = {
          fuzzyCompletion = true;
        };
        zoxide = {
          enable = true;
          enableFishIntegration = true;
          enableBashIntegration = true;
        };
        bash = {
          enable = true;
          completion = {
            enable = true;
          };

          interactiveShellInit = ''
            if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
            then
              shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
              exec ${selfpkgs.fishWrapped}/bin/fish $LOGIN_OPTION
            fi
          '';
        };
      };

      services.userborn.enable = true;

      # Link paths to /run/current-system/sw
      environment = {
        systemPackages = [
          pkgs._7zz-rar
        ];
        pathsToLink = [
          "/share"
          "/share/sounds"
          "/"
        ];
        shells = [
          selfpkgs.fishWrapped
        ];
      };
    };
}
