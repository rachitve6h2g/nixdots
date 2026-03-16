{ self, ... }:
{
  flake.nixosModules.emacs =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {

      environment.systemPackages = [
        selfpkgs.emacsBundle
      ]
      ++
        # This makes extra binaries also available in the $PATH
        (import ./_extraBinaries.nix { inherit pkgs self; });

      environment.sessionVariables = lib.mkOverride 900 "emacseditor";
      hjem.users.krish = {
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
        files = {
          ".config/emacs/init.el".source = ./config/init.el;
          ".config/emacs/early-init.el".source = ./config/early-init.el;
        };
      };
    };
}
