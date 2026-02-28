{ self, ... }:
{
  flake.wrappers.yt-dlp =
    {
      wlib,
      lib,
      pkgs,
      config,
      ...
    }:
    let
      selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};

      inherit (lib) mkOption types;
      configAtom =
        with types;
        oneOf [
          bool
          int
          str
        ];

      renderSingleOption =
        name: value:
        if lib.isBool value then
          if value then "--${name}" else "--no-${name}"
        else
          "--${name} ${toString value}";

      renderSettings = lib.mapAttrsToList (
        name: value:
        if lib.isList value then
          lib.concatStringsSep "\n" (map (renderSingleOption name) value)
        else
          renderSingleOption name value
      );

      renderedSettings = pkgs.writeText "yt-dlp.conf" (
        lib.concatStringsSep "\n" (lib.remove "" (renderSettings config.settings)) + "\n"
      );
    in
    {
      imports = [ wlib.modules.default ];
      options = {
        settings = mkOption {
          type = with types; attrsOf (either configAtom (listOf configAtom));
          default = {
            downloader = "aria2c";
            downloader-args = "aria2c:'-c -j 3 -x8 -s8 -k1M'";
            format = "bestvideo+bestaudio/best";
            embed-thumbnail = true;
            embed-subs = true;
          };
          description = "Settings to wrap with the yt-dlp package";
        };
      };

      config = {
        package = pkgs.yt-dlp;
        extraPackages = [
          selfpkgs.aria2.out # FIXME: fix this binary wrapper problem

          (pkgs.writeShellScriptBin "ytmusic" ''
            yt-music() {
            	yt-dlp \
            		-x \
            		-f bestaudio \
            		"$@"
            }

          '')

          (pkgs.writeShellScriptBin "ytplaylist" ''
            yt-playlist() {
            	yt-dlp \
            		--ignore-errors \
            		--continue \
            		--no-overwrites \
            		--download-archive progress.txt \
            		"$@"
            }
          '')
        ];
        flags = {
          "--config-location" = renderedSettings;
        };
      };
    };
}
