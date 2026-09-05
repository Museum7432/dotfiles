{ ... }:
{
  boot.loader.limine.enable = true;

  fileSystems."/nix".neededForBoot = true;
  fileSystems."/home/arch".neededForBoot = true;
  fileSystems."/".neededForBoot = true;

  # secure boot
  boot.loader.limine.secureBoot = {
    enable = true;
    autoGenerateKeys = true;
  };

}
