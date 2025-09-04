{ pkgs, ... }:
{
  security = {
    sudo = {
      enable = true;
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
