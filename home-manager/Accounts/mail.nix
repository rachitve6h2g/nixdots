{ lib, ... }:
{
  accounts.email = {
    maildirBasePath = "Mail";
    accounts.gmail = rec {
      primary = true; # must have one primary account. Only one.
      address = "rachitverma1122@gmail.com";
      realName = "Rachit Kumar Verma";

      userName = address;
      passwordCommand = "pass show gmail-app-password";

      imap.host = "imap.gmail.com";
      smtp.host = "smtp.gmail.com";

      folders = {
        inbox = "Inbox";
        drafts = "[Gmail]/Drafts";
        sent = "[Gmail]/Sent Mail";
        trash = "[Gmail]/Bin";
      };

      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
        patterns = [ "*" ];
        extraConfig = {
          account = {
            # IPv4Only = "yes";
            Timeout = 120;
          };
          channel = {
            Far = ":gmail-remote:";
            Near = ":gmail-local:";
          };
        };
      };
      msmtp.enable = true;

      # Local maildir
      maildir.path = "INBOX";
    };
  };

  programs = {
    mbsync.enable = true;
    msmtp = {
      enable = true;
      configContent = lib.mkAfter /* ini */ ''
        logfile ~/.msmtp.log
      '';
    };
  };

  services = {
    mbsync = {
      enable = true;
    };
  };
}
