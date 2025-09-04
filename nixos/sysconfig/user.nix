{
  pkgs,
  ...
}:
{
  documentation.man.generateCaches = false; # from NixOS wiki on fish

  # When installing, remember to use 'nixos-install --no-root-passwd'
  # to use the initialPassword. However, post-installation always change
  # password
  users.users.krish = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "systemd-journal"
    ]; # Enable ‘sudo’ for the user.

    packages = with pkgs; [
      git
      vim
    ];
    initialPassword = "Shouvik@1234";
    shell = pkgs.bashInteractive;
  };
  programs.bash = {
    enable = true;
    completion = {
      enable = true;
    };
  };
}
