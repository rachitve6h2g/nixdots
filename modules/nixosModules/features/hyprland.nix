{
  flake.nixosModules.hyprland =
    {
      pkgs,
      ...
    }:
    {
      programs = {
        # Hyprland and ecosystem
        hyprland = {
          enable = true;
          withUWSM = true;
          xwayland.enable = true;
        };

      };

      environment.systemPackages = [ pkgs.kitty ];

      security = {
        # When using hyprlock from home-manager, must use this.
        # hyprlock package is not necessary.
        pam.services.hyprlock = { };
      };
    };
}
