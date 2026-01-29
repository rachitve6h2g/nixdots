{ self, ... }:
{
  flake.nixosModules.base =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.networking
        self.nixosModules.stylix
      ];

      # Tmp on ram
      boot = {
        tmp = {
          useTmpfs = true;
          tmpfsSize = "50%";
        };
      };

      # Sudo program
      security = {
        sudo = {
          enable = true;
          execWheelOnly = true;
          package = pkgs.sudo.override {
            withInsults = true;
          };

          extraConfig =
            # bash
            ''
              Defaults pwfeedback
            '';
        };
      };

      services = {
        btrfs = {
          autoScrub = {
            enable = true;
            interval = "weekly";
            fileSystems = [ "/" ];
          };
        };
      };

      zramSwap = {
        enable = true;
        algorithm = "zstd";
        memoryPercent = 50;
      };
    };
}
