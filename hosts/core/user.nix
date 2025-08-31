{
  pkgs,
  inputs,
  ...
}:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.krish = {
    isNormalUser = true;
    createHome = true;
    home = "/home/krish";
    group = "users";
    description = "Rachit Kumar Verma";
    extraGroups = [
      "wheel"
      "input"
      "video"
      "audio"
      "systemd-journal"
    ];
    initialPassword = "Shouvik@1234";

    shell = pkgs.fish;
  };
  # environment.shells = [ pkgs.nushell ];
  # programs.zsh.enable = true;

  programs = {
    # According to https://wiki.nixos.org/wiki/Fish#section_Setting_fish_as_default_shell
    fish.enable = true;
    bash.interactiveShellInit =
      #bash
      ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
  };
  documentation.man.generateCaches = false; # from NixOS wiki on fish
}
