{ self, ... }:
{
  flake.nixosModules.commonPackages =
    { pkgs, ... }:
    let
      selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
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

          # Music player
          moc

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
            kew # Music player (for trial)
            taskwarrior # Terminal to-do list manager

            # Git tools
            git
            gitui

            helix # TODO: move to neovim

            yt-dlp # youtube downloader
            xplr # terminal filemanager
          ]);
    };
}
