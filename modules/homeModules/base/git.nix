{
  flake.homeModules.shell =
    {
      ...
    }:
    {

      programs = {
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
