{
  flake.nixosModules.greeter =
    {
      pkgs,
      ...
    }:
    {
      services = {
        greetd = {
          enable = true;
          restart = true;

          # only use when using entirely text-based greeter.
          # Like TUI greet
          useTextGreeter = true;

          settings = {
            terminal = {
              vt = 1;
            };
            default_session =
              let
                tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
                # hyprland-session = "${pkgs.hyprland}/share/wayland-sessions";
                niri-session = "${pkgs.niri}/share/wayland-sessions";
              in
              {
                command = "${tuigreet} --time --remember --remember-session --sessions ${niri-session}";
                user = "greeter";
              };
          };
        };
      };

      environment.etc."greetd/environments".text = ''
	niri
        bash
        hyprland
      '';
    };
}
