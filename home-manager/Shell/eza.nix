{
  programs.eza = {
    enable = true;

    git = true;
    icons = "auto";
    colors = "auto";

    extraOptions = [
      "--group-directories-first"
      "--header"
      "--git-repos"
      "--group"
    ];
  };
}
