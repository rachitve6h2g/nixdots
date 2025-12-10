{
  inputs,
  ...
}:
{
  home = rec {
    username = "krish";
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
    enableNixpkgsReleaseCheck = true;
  };
  programs = {
    home-manager.enable = true;
  };

  systemd.user.startServices = true;

  imports = [
    # ./Accounts # Manage emails and stuff in emacs not in external applications
    ./Browsers
    ./Editors
    ./Git
    ./Media

    ./Programs
    ./Shell
    ./WindowManager

    ./keymap.nix
    ./nh.nix
    ./stylix.nix
    ./xdgsettings.nix

    # ./modules # Don't use when using flake-parts
    inputs.self.homeModules.custom # Use when using flake-parts
  ];
}
