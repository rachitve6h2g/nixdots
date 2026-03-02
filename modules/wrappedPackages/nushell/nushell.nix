{ self, ... }:
{
  flake.wrappers.nushell =
    {
      pkgs,
      wlib,
      lib,
      ...
    }:
    let
      selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      extraPackages = [
        selfpkgs.btop
        selfpkgs.cava
        selfpkgs.git
        selfpkgs.yt-dlp

        (pkgs.writeShellApplication {
          name = "yt-music";
          text = ''
                        ${lib.getExe selfpkgs.yt-dlp} \
                          -x \
                          -f "bestaudio/best" \
            	      --audio-format "flac" \
                          -o "$HOME/Music/%(title)s.%(ext)s" \
                          "$@"
          '';
        })

        (pkgs.writeShellApplication {
          name = "yt-playlist";
          text = ''
            ${lib.getExe selfpkgs.yt-dlp} \
              --ignore-errors \
              --continue \
              --no-overwrites \
              --download-archive progress.txt \
              "$@"
          '';
        })
      ];

      imports = [ wlib.wrapperModules.nushell ];

      "config.nu".path = ./config.nu;
    };
}
