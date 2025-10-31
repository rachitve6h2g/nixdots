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
      enableDefaultConfig = false; # The default values have been rmoved
      # and instead the config below has been used.
      matchBlocks."*" = {
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
    };
  };
}
