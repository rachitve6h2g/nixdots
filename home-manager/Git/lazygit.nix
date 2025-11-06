# { lib, ... }:
{
  programs = {
    lazygit = {
      enable = true;
      shellWrapperName = "lg";
      settings = {
        gui = {
          nerdFontsVersion = 3;
        };

        git = {
          pagers = [
            # Use difftastic as the externalDiffCommand
            { externalDiffCommand = "difft --color=always"; }
            { useExternalDiffGitConfig = true; }
          ];
        };
      };
    };
  };
}
