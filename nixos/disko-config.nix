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
              size = "512M";
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
                  extraArgs = ["-L" "nixos" "-f" ];
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
                      "/root-blank" = {
                        mountOptions = mountOpts ++ (["nodatacow"]);
                      };
                      "/home" = {
                        mountpoint = "/home";
                        mountOptions = mountOpts;
                      };
                      "/nix" = {
                        mountpoint = "/nix";
                        mountOptions = mountOpts;
                      };
                      "/persist" = {
                        mountpoint = "/persist";
                        mountOptions = mountOpts;
                      };
		      "/log" = {
		      	mountpoint = "/var/log";
			mountOptions = mountOpts;
		      };
		      "/lib" = {
		      	mountpoint = "/var/lib";
			mountOptions = mountOpts;
		      };
                      "/persist/swap" = {
                        mountpoint = "/persist/swap";
			mountOptions = [ "noatime" "nodatacow" "compress=no" ];
                        swap.swapfile.size = "18G";
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

  fileSystems = {
  	"/persist".neededForBoot = true;
	"/var/log".neededForBoot = true;
	"/var/lib".neededForBoot = true;
  };
}
