{
  flake.homeModules.shell =
    {
      pkgs,
      ...
    }:
    {

      programs = {
        git = {
          enable = true;
          package = pkgs.git.override { withLibsecret = true; };

          # Set files that should be ignored globally
          ignores = [
            # Ignore emacs backup files
            "*~"
            "\#*\#"
            ".\#*"

            # Ignore vim backup files
            "*.swp"
          ];

          settings = {
            remote = {
              pushDefault = "origin";
            };

            user = {
              name = "Rachit Kumar Verma";
              email = "rachitve6h2g@users.noreply.github.com";
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
              addKeysToAgent = "yes";
              compression = false;
              serverAliveInterval = 0;
              serverAliveCountMax = 3;
              hashKnownHosts = true;
              userKnownHostsFile = "~/.ssh/known_hosts";
              controlMaster = "no";
              controlPath = "~/.ssh/master-%r@%n:%p";
              controlPersist = "no";
            };

            "github.com" = {
              hostname = "github.com";
            };
          };
        };
      };
    };
}
