{
  programs = {
    gh = {
      enable = true;
      settings = {
        version = 1;
        git_protocol = "ssh";
        editor = "nvim";
      };

      hosts = {
        "github.com" = {
          git_protocol = "ssh";
          users = "rachitve6h2g";
          user = "rachitve6h2g";
        };
      };
    };
  };
}
