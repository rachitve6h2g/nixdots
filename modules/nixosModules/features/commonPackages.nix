{ self, ... }:
{
  flake.nixosModules.commonPackages =
    { pkgs, ... }:
    let
      selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      environment.sessionVariables = {
        EDITOR = "emacseditor";
        VISUAL = "emacseditor";
      };

      environment.systemPackages =
        # Directly from nixpkgs
        (with pkgs; [
          (vesktop.override { withSystemVencord = true; })
          telegram-desktop
          # Common environment packages
          gdu # disk usage analyzer
          gophertube # Watch youtube in terminal
          # Github-cli
          gh
          gh-dash
          # Nix Fetchers
          nix-prefetch
          nix-prefetch-github
          # Get where a package is from
          nix-tree
          nix-output-monitor # May conflict with the nom RSS feed reader
        ])
        ++
          # Packages wrapped by me
          (with selfpkgs; [
            aria2 # A better terminal downloader
            btop # Python based system monitor
            bottom # Rust based system monitor
            # Git tools
            git
            yt-dlp # youtube downloader
          ]);
    };
}
