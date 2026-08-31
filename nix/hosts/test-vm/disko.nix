# nixos only need the esp and another partition to boot, it seems to merge the \boot and \efi partitions together, unified kernel image is not supported
# we will latter change this for the impermanance setup

{ ... }:
{
  disko.devices.disk.main = {
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
            type = "btrfs";
            extraArgs = [ "-f" ];
            subvolumes = {
              "/" = {
                mountpoint = "/";
                # mountOptions = [ "compress=zstd" "noatime" ];
              };
              # "/persist" = {
              #   mountpoint = "/persist";
              #   mountOptions = [ "compress=zstd" ];
              # };
            };
          };
        };
      };
    };
  };
}
