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
        ]; # Enable ‘sudo’ for the user.

        initialPassword = "1234";
      };
      programs.bash = {
        enable = true;
        completion = {
          enable = true;
        };
        /*
          interactiveShellInit = ''
                 if ! [ "$TERM" = "dumb" ] && [ -z "$BASH_EXECUTION_STRING" ]; then
                   exec nu
                 fi
               '';
        */
      };

      services.userborn.enable = true;

      # Link paths to /run/current-system/sw
      environment.pathsToLink = [
        "/share"
        "/share/sounds"
        "/"
      ];
      # environment.shells = [ selfpkgs.nushell ];
    };
}
