# nixos only need the esp and another partition to boot, it seems to merge the \boot and \efi partitions together, unified kernel image is not supported
# we will latter change this for the impermanance setup

# use 1 partition for both nix and persist on xfs
{ lib, ... }:
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

          # swap = {
          #   size = "16G";
          #   content = {
          #     type = "swap";
          #     resumeDevice = true;
          #     discardPolicy = "both";
          #   };
          # };


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

  fileSystems."/nix".neededForBoot = true;
  fileSystems."/home/arch".neededForBoot = true;
  fileSystems."/".neededForBoot = true;

}
