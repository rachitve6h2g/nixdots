{ pkgs, ... }: {
  programs = {
    bat = {
      enable = true;

      config = {
        pager = "less -FR";
      };

      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        prettybat
      ];

      # See zsh shellAliases in Shell dir, for batdiff options
    };
  };
}
