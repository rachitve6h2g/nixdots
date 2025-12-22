{ pkgs, ... }:
{
  services.ollama = {
    enable = true;
    # Don't need it
    # acceleration = "vulkan";
  };
}
