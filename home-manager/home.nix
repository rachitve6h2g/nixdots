{
  # inputs,
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
    ./Accounts
    ./Browsers
    ./Editors
    ./Git
    ./Media
    ./Niri
    ./Programs
    ./Shell

    ./keymap.nix
    ./nh.nix
    ./stylix.nix
    ./xdgsettings.nix
    # inputs.nvf.homeManagerModules.default
  ];
}
