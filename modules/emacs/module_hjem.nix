{ self, ... }:
{
  flake.nixosModules.emacs =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      environment.systemPackages = [ selfpkgs.emacsBundle ];
      hjem.users.krish = {

        files = {
          ".config/emacs/init.el".source = ./_config/init.el;
          ".config/emacs/early-init.el".source = ./_config/early-init.el;
          ".config/emacs/themes/doom-gruvbox-material-theme.el".source =
            ./_config/themes/doom-gruvbox-material-theme.el;
        };

        systemd.services = {
          # Service for swayidle
          swayidle = {
            name = "swayidle";
            description = "Idle manager for wayland";
            documentation = [ "man:swayidle(1)" ];
            partOf = [ "graphical-session.target" ];
            after = [ "graphical-session.target" ];
            unitConfig = {
              ConditionEnvironment = "WAYLAND_DISPLAY";
            };

            serviceConfig = {
              Type = "simple";
              Restart = "always";
              ExecStart = lib.getExe selfpkgs.swayidle;
            };

            wantedBy = [ "graphical-session.target" ];
          };

          # Service for emacsclient
          emacs = {
            name = "emacs";
            serviceConfig = {
              Type = "notify";
              Restart = "always";
              ExecStart = "${pkgs.runtimeShell} -c 'source ${config.system.build.setEnvironment}; exec ${selfpkgs.emacsBundle}/bin/emacs --fg-daemon'";
              SuccessExitStatus = 15;
            };
            wantedBy = [ "default.target" ];
          };
        };
      };
    };
}
