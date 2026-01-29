{
  flake.homeModules.shell =
    { ... }:
    {
      programs = {
        htop.enable = true;
        btop = {
          enable = true;

          settings = {
            theme_background = false;
            vim_keys = true;
            rounded_corners = true;
          };
        };
      };
    };
}
