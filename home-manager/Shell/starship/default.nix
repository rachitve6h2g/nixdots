{ lib, ... }:
{
  programs = {
    starship = {
      enable = true;
      settings = lib.mkForce (import ./gruvbox_rainbow.nix); # This is not managed by stylix.
      # settings = lib.mkAfter (import ./catppuccin_typecraft.nix { inherit lib; }); # This is managed by stylix.
    };
  };
}
