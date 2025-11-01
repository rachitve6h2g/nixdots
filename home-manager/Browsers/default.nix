{
  imports = [
    # ./chromium.nix
    ./firefox.nix
    ./qutebrowser.nix
  ];

  # Set the default browser
  xdg.mimeApps.defaultApplications =
    let
      defaultBrowser = "firefox.desktop";
    in
    {
      "text/html" = defaultBrowser;
      "x-scheme-handler/http" = defaultBrowser;
      "x-scheme-handler/https" = defaultBrowser;
      "x-scheme-handler/about" = defaultBrowser;
      "x-scheme-handler/unknown" = defaultBrowser;
    };
}
