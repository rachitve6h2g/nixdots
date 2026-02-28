{ self, ... }:
{
  flake.wrappers.nushell =
    {
      pkgs,
      wlib,
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
                        ${selfpkgs.yt-dlp}/bin/yt-dlp \
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
            ${selfpkgs.yt-dlp}/bin/yt-dlp \
              --ignore-errors \
              --continue \
              --no-overwrites \
              --download-archive progress.txt \
              "$@"
          '';
        })
      ];

      imports = [ wlib.wrapperModules.nushell ];
      filesToPatch = [
        "bin/nu"
      ];
      "config.nu".path = ./config.nu;
    };
}
