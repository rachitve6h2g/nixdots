{
  flake.homeModules.shell =
    { config, pkgs, ... }:
    let
      aria2Daemon = pkgs.writeText "aria2.daemon" /* ini */ ''
        continue
        daemon=true
        dir=/home/aria2/Downloads
        file-allocation=falloc
        log-level=warn
        max-connection-per-server=4
        max-concurrent-downloads=3
        max-overall-download-limit=0
        min-split-size=5M
        enable-http-pipelining=true

        enable-rpc=true
        rpc-listen-all=true
        rpc-secret=secret
      '';
    in
    {
      programs.aria2 = {
        enable = true;
        settings = {
          continue = true;
          dir = "${config.xdg.userDirs.download}";

          # Give a list of tab separated download links to use aria2.
          input-file = "${config.xdg.userDirs.download}/aria2_downloads.conf";
          file-allocation = "none";
          log-level = "warn";
          max-connection-per-server = 4;
          min-split-size = "5M";
          on-download-complete = "exit";
        };
      };

      # Enable aria2 as a systemd user unit
      systemd.user.services.aria2cd = {
        Unit.Description = "aria2 Daemon";
        Service.ExecStart = [ "${pkgs.aria2}/bin/aria2c --conf-path=${aria2Daemon}" ];
        Install.WantedBy = [ "default.target" ];
      };
    };
}
