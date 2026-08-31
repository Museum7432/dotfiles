{ inputs, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    sharedModules = [ inputs.plasma-manager.homeModules.plasma-manager ];

    extraSpecialArgs = { inherit inputs; };

    users = {
      arch = import ./arch;
    };
  };
}
