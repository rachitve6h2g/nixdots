{
  flake.nixosModules.fonts =
    { pkgs, ... }:
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
            name = "JetBrainsMono Nerd Font";
            package = pkgs.nerd-fonts.jetbrains-mono;
          }
        ];
        extraOptions = "--term xterm-256color";
        extraConfig = "font-size=14";
        # Whether to use 3D hardware acceleration to render the console.
        hwRender = true;
        useXkbConfig = true;
      };

      fonts = {
        # Preferable to set to false, but maybe, I might try setting
        # it to true and see what happens
        enableDefaultPackages = false;
        fontDir.enable = true;
        packages = with pkgs; [
          # Google Noto Fonts for normal day to day tasks
          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-color-emoji

          # Nerd Fonts
          nerd-fonts.jetbrains-mono
          nerd-fonts.symbols-only

          # For document-like fonts
          inter
        ];

        fontconfig = {
          antialias = true;
          hinting = {
            enable = true;
            style = "slight";
          };
          subpixel = {
            rgba = "rgb";
          };

          defaultFonts = {
            serif = [
              "Noto Serif"
            ];
            sansSerif = [
              "Inter"
              "Noto Sans"
              "Noto Sans CJK"
            ];
            monospace = [
              "JetBrainsMono Nerd Font"
              "Noto Sans Mono"
            ];
            emoji = [ "Noto Color Emoji" ];
          };
        };
      };
    };
}
