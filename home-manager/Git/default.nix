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

      # signing = {
      #   key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEL6Z8uvB3G6fKauDN0t5UeoO6OpdLscviTJes0udjQ1";
      #   signByDefault = true;
      # };
      extraConfig = {
        # gpg = {
        #   format = "ssh";
        # };
        push = {
          autoSetupRemote = true;
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
