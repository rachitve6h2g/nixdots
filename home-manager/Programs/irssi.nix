{
  programs = {
    irssi = {
      enable = true;

      aliases = {
        BYE = "quit";
        J = "join";
      };

      networks = {
        liberachat = {
          nick = "krish";
          server = {
            address = "irc.libera.chat";
            port = 6697;
            autoConnect = true;
          };
          channels = {
            nixos.autoJoin = true;
          };
        };
      };

    };
  };
}
