{
  flake.homeModules.shell = {
    programs = {
      jujutsu = {
        enable = true;
        settings = {
          user = {
            name = "Rachit Kumar Verma";
            email = "rachitve6h2g@users.noreply.github.com";
          };
        };
      };

      jjui.enable = true;
    };
  };
}
