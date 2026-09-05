
{ ... }:
{

  disko.devices = {

    disk.main = {
      device = "/dev/vda";
      type = "disk";

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

          root = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "xfs";
              mountpoint = "/nix";
              mountOptions = [ "noatime" ];
              extraArgs = [ "-L" "nixos" ];
            };
          };

          # /persist is mounted using qemu shared folder

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
