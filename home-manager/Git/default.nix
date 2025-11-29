{
  pkgs,
  ...
}:
{
  imports = [
    ./gh.nix
    ./gitui.nix
    ./gpg.nix
  ];

  programs = {
    difftastic = {
      enable = true;
      options = {
        color = "dark";
        sort-path = true;
        tab-width = 8;
      };
      git = {
        enable = true;
        diffToolMode = true;
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
      enableDefaultConfig = false; # The default values have been rmoved
      # and instead the config below has been used.
      matchBlocks = {
        "*" = {
          forwardAgent = false;
          addKeysToAgent = "no";
          compression = false;
          serverAliveInterval = 0;
          serverAliveCountMax = 3;
          hashKnownHosts = false;
          userKnownHostsFile = "~/.ssh/known_hosts";
          controlMaster = "no";
          controlPath = "~/.ssh/master-%r@%n:%p";
          controlPersist = "no";
        };

        # Works only when my phone's hotspot is connected
        # to my Laptop.
        myphone = {
          user = "u0_a347";
          port = 8022;
        };
      };
    };
  };
}
