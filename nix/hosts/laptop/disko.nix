{ ... }:
{

  disko.devices = {

    disk.main = {
      device = "/dev/nvme0n1";
      type = "disk";

      content = {
        type = "gpt";

        partitions = {
          ESP = {
            size = "2G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };

          };

          swap = {
            size = "32G";
            content = {
              type = "swap";
              resumeDevice = true;
              discardPolicy = "both";
            };
          };

          root = {
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [
                "-f"
                "-L" "nixos"
              ];
              subvolumes = {
                "/nix" = {
                  mountpoint = "/nix";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };

                "/persist" = {
                  mountpoint = "/persist";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
              };
            };
          };
        };
      };
    };

    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [ "size=25%" "defaults" "mode=755" ];
    };

    nodev."/home/arch" = {
      fsType = "tmpfs";
      mountOptions = [ "size=25%" "defaults" "mode=777" ];
    };
  };
}
