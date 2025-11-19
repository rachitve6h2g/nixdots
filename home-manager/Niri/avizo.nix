{ lib, ... }:
{
  services.avizo = {
    enable = true;
    settings = lib.mkAfter {
      default = {
        image-opacity = lib.mkForce 0.5;
        time = 2.0;
        fade-in = 0.2;
        fade-out = 0.5;
      };
    };
  };
}
