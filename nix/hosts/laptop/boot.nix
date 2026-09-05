{ ... }:
{

  fileSystems."/nix".neededForBoot = true;
  fileSystems."/home/arch".neededForBoot = true;
  fileSystems."/persist".neededForBoot = true;
  fileSystems."/".neededForBoot = true;

  # secure boot
  boot.loader.limine.secureBoot = {
    enable = true;
    autoGenerateKeys = true;
  };

}
