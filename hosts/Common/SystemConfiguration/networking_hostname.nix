{ globalValues, ... }: {
  # Refer this https://mynixos.com/nixpkgs/option/networking.hostName
  # For properly setting your hostname
  networking.hostName = globalValues.hostname;
}
