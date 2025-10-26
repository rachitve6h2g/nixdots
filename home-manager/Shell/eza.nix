{
  programs.eza = {
    enable = true;

    git = true;
    icons = "auto";
    colors = "auto";

    enableBashIntegration = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
      "--git-repos"
      "--group"
    ];
  };
}
