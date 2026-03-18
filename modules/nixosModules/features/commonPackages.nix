{ self, ... }:
{
  flake.nixosModules.commonPackages =
    { pkgs, ... }:
    let
      selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      environment.sessionVariables = {
        EDITOR = "hx";
        VISUAL = "hx";
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
        ])
        ++
          # Packages wrapped by me
          (with selfpkgs; [
            aria2 # A better terminal downloader
            btop # Python based system monitor
            bottom # Rust based system monitor

            # Git tools
            git
            gitui # TODO: Do th wrapping and be done with it

            helix # TODO: move to neovim

            xplr # Refine the settings

            yt-dlp # youtube downloader
          ]);
    };
}
