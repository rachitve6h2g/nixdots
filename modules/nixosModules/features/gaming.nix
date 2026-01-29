{
  flake.nixosModules.gaming =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        (heroic.override {
          extraPkgs = pkgs: [ pkgs.gamescope ];
        })

        wineWow64Packages.stableFull
      ];

      programs = {
        gamemode.enable = true;
        gamescope.enable = true;
      };
    };
}
