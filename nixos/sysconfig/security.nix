{ pkgs, ... }:
{
  security = {
    sudo = {
      enable = true;
      execWheelOnly = true;
      package = pkgs.sudo.override {
        withInsults = true;
      };

      extraConfig =
        # bash
        ''
          Defaults pwfeedback
        '';
    };
  };
}
