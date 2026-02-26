{ self, ... }:

{
  flake.nixosModules.users =
    {

      pkgs,
      lib,
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

        interactiveShellInit = ''
          if ! [ "$TERM" = "dumb" ] && [ -z "$BASH_EXECUTION_STRING" ]; then
            exec ${selfpkgs.nushell}/bin/nu
          fi
        '';

      };

      services.userborn.enable = true;

      # Link paths to /run/current-system/sw
      environment.pathsToLink = [
        "/share"
        "/share/sounds"
        "/"
      ];
      # TODO: Fix this lib.getExe
      # https://github.com/nitdn/nixos-machine/blob/012737eeff05f908de30d3d258007cfab255eb8c/modules/nushell/default.nix#L54
      environment.shells = [ (lib.getExe selfpkgs.nushell) ];
    };
}
