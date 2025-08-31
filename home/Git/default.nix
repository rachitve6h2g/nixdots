{
  pkgs,
  ...
}:
{
  imports = [
    ./lazygit.nix
  ];

  programs = {
    git = {
      enable = true;

      package = pkgs.git.override { withLibsecret = true; };

      userName = "Rachit Kumar Verma";
      userEmail = "rachitverma1122@gmail.com";

      delta = {
        enable = true;
        options = {
          navigate = true;
          dark = true;
          side-by-side = true;
          hyperlinks = true;
          line-numbers = true;
        };
      };

      aliases = {
        co = "checkout";
        s = "status";
        ss = "status --short --branch";
        ci = "commit";
      };
    };

    ssh = {
      enable = true;
      hashKnownHosts = true;
      addKeysToAgent = "yes";
    };
  };
}
