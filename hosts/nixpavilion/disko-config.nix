{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                # disable settings.keyFile if you want to use interactive password entry
                #passwordFile = "/tmp/secret.key"; # Interactive
                settings = {
                  allowDiscards = true;
                  #keyFile = "/tmp/secret.key";
                };
                #additionalKeyFiles = [ "/tmp/additionalSecret.key" ];
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-L"
                    "nixos"
                    "-f"
                  ];
                  subvolumes =
                    let
                      mountOpts = [
                        "compress=zstd"
                        "ssd"
                        "space_cache=v2"
                        "noatime"
                        "discard=async"
                      ];
                    in
                    {
                      "/root" = {
                        mountpoint = "/";
                        mountOptions = mountOpts;
                      };
                      "/home" = {
                        mountpoint = "/home";
                        mountOptions = mountOpts;
                      };
                      "/nix" = {
                        mountpoint = "/nix";
                        mountOptions = mountOpts;
                      };
                      "/swap" = {
                        mountpoint = "/swap";
                        mountOptions = [
                          "noatime"
                          "nodatacow"
                          "compress=zstd"
                        ];
                        swap.swapfile.size = "4G";
                      };
                    };
                };
              };
            };
          };
        };
      };
    };
  };
}
