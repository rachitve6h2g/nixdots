{
  programs = {
    irssi = {
      enable = true;

      aliases = {
        J = "join";
        BYE = "quit";
      };

      networks = {
        libera = {
          nick = "Krish";
          server = {
            address = "irc.libera.chat";
            port = 6697;
            autoConnect = true;

            ssl = {
              enable = true;
              verify = true;
            };
          };
          channels = {
            "#linux" = {
              autoJoin = true;
            };
            "#nixos" = {
              autoJoin = true;
            };
          };
        };
      };
      extraConfig = ''
        settings = {
          core = {
            settings_autosave = "no";
            timestamp_format = "%H:%M";
            scrollback_lines = "5000";
          };
        };
      '';
    };
  };
}
