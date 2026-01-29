{
  flakes.nixosModules.users =
    {
      pkgs,
      ...
    }:
    {
      documentation.man.generateCaches = false; # from NixOS wiki on fish

      # When installing, remember to use 'nixos-install --no-root-passwd'
      # to use the initialPassword. However, post-installation always change
      # password
      users.users."krish" = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "systemd-journal"
          "video"
          "greeter"
          "networkmanager"
        ]; # Enable ‘sudo’ for the user.

        initialPassword = "1234";
        shell = pkgs.bashInteractive;
      };
      programs.bash = {
        enable = true;
        completion = {
          enable = true;
        };
      };

      services.userborn.enable = true;

      # Link paths to /run/current-system/sw
      environment.pathsToLink = [
        "/share"
        "/share/sounds"
        "/"
      ];
    };
}
