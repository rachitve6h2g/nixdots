{
  pkgs,
  ...
}:
{
  imports = [
    ./gh.nix
    ./lazygit.nix
  ];

  programs = {
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

    git = {
      enable = true;

      package = pkgs.git.override { withLibsecret = true; };

      settings = {
        push = {
          autoSetupRemote = true;
        };
        user = {
          name = "Rachit Kumar Verma";
          email = "rachitverma1122@gmail.com";
        };
        alias = {
          co = "checkout";
          s = "status";
          ss = "status --short --branch";
          ci = "commit";
        };
      };
    };

    ssh = {
      enable = true;
      enableDefaultConfig = true;
      # hashKnownHosts = true;
      # addKeysToAgent = "yes";
      extraConfig = ''
        Host myphone
          Hostname 10.177.48.57
          Port 8022
          User u0_a347
      '';
    };
  };
}
