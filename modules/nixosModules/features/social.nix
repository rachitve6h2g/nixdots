{
  flake.nixosModules.social =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        (vesktop.override { withSystemVencord = true; })
        telegram-desktop
      ];
    };
}
