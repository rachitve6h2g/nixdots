{ pkgs, ... }:
{
  home.packages = with pkgs; [ trash-cli ];

  systemd.user = {
    timers = {
      trash-empty = {
        Unit = {
          Description = "Run trash-empty daily";
        };
        Timer = {
          OnCalendar = "daily";
          Persistent = true;
        };
        Install = {
          WantedBy = [ "timers.target" ];
        };
      };
    };

    services = {
      trash-empty = {
        Unit.Description = "Empty trash older than 30 days";
        Service = {
          Type = "oneshot";
          ExecStart = "${pkgs.trash-cli}/bin/trash-empty 30";
        };
      };
    };
  };
}
