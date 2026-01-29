{
  flake.nixosModules.kmscon =
    { config, ... }:
    {
      # https://wiki.archlinux.org/title/KMSCON
      services.kmscon = {
        # Use kmscon as the virtual console instead of gettys.
        # kmscon is a kms/dri-based userspace virtual terminal implementation.
        # It supports a richer feature set than the standard linux console VT,
        # including full unicode support, and when the video card supports drm should be much faster.
        enable = true;
        fonts = [
          {
            name = "${config.stylix.fonts.monospace.name}";
            package = "${config.stylix.fonts.monospace.package}";
          }
        ];
        extraOptions = "--term xterm-256color";
        extraConfig = "font-size=14";
        # Whether to use 3D hardware acceleration to render the console.
        hwRender = true;
        useXkbConfig = true;
      };
    };
}
