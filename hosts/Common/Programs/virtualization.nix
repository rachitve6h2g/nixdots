{ pkgs, globalValues, ... }:
{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm = {
          enable = true;
        };
        vhostUserPackages = [ pkgs.virtiofsd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };

  users.users.${globalValues.username}.extraGroups = [ "libvirtd" ];

  # for file sharing
  services = {
    spice-webdavd.enable = true;
    davfs2 = {
      enable = true;
      settings = {
        globalSection = {
          ask_auth = 0;
        };
      };
    };
  };

  programs = {
    virt-manager = {
      enable = true;
    };
  };
}
