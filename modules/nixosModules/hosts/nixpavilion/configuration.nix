{
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations.nixpavilion = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.nixosModules.hostMain ];
  };

  flake.nixosModules.hostMain =
    { pkgs, ... }:
    {
      imports = [
        # desktop stuff
        self.nixosModules.desktop
        self.nixosModules.niri

        # All the base stuff
        self.nixosModules.base

        # User module
        # Must always be present
        self.nixosModules.users

        # disko
        inputs.disko.nixosModules.disko
        self.diskoConfigurations.hostMain
      ];

      programs = {
        git = {
          enable = true;
          package = (pkgs.git.override { withLibsecret = true; });
        };

        nano.enable = false;
        vim.enable = true;
      };
      # Don't frickin' change it!!!
      system.stateVersion = "26.05";

      documentation.man.generateCaches = false;

      # Enable touchpad support (enabled default in most desktopManager).
      services.libinput.enable = true;

      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };

        kernel.sysctl = {
          "vm.swappiness" = 10;
        };

        plymouth.enable = true;

        kernelParams = [
          "quiet"
          "splash"
          "i915.force_probe=!a7a0"
          "zswap.enabled=1" # enables zswap
          "zswap.compressor=zstd" # compression algorithm
          "zswap.max_pool_percent=20" # maximum percentage of RAM that zswap is allowed to use
          "zswap.shrinker_enabled=1" # whether to shrink the pool proactively on high memory pressure           
	"xe.force_probe=a7a0"
        ];
      };

      networking = {
        hostName = "nixpavilion";
        networkmanager.enable = true;
      };

      nix.settings = {
        cores = 8;
        max-jobs = 1;
      };

      hardware = {
        bluetooth.enable = true;
        enableRedistributableFirmware = true;
        intel-gpu-tools.enable = true;
        graphics = {
          enable = true;

          package = pkgs.mesa;
          extraPackages = with pkgs; [
            intel-media-driver
            intel-compute-runtime
            vpl-gpu-rt
            libvpl
          ];
        };
      };
      environment.sessionVariables = {
        ANV_VIDEO_DECODE = 1;
        LIBVA_DRIVER_NAME = "iHD";
        NIXOS_OZONE_WL = 1;
        ANV_DEBUG = "video-decode,video-encode";
        WLR_RENDERER = "vulkan"; # For wayland backend rendering.
      };
    };
}
