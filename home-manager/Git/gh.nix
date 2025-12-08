{
  programs = {
    gh = {
      enable = true;
      gitCredentialHelper = {
        enable = true;
        hosts = [
          "https://github.com"
          "https://gist.github.com"
        ];
      };
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
