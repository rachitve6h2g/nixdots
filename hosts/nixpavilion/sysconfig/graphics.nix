{ pkgs, ... }:
{
  hardware = {
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
}
