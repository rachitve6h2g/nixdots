{ config, ... }:
{
  programs.password-store = {
    enable = true;
    settings = {
      # This environment variable must be set, otherwise it'll mess up.
      PASSWORD_STORE_DIR = "${config.xdg.dataHome}/password-store";
    };
  };
}
