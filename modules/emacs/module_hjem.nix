{ self, ... }:
{
  flake.nixosModules.emacs =
    { config, pkgs, ... }:
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

        systemd.services.emacs = {
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
}
