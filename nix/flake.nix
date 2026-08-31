{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";


    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";

    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

  };

  outputs = { self, nixpkgs, home-manager, disko, plasma-manager, ... }@ inputs: {

    nixosConfigurations = {
      vmtest = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};

        modules = [
          disko.nixosModules.disko
          ./hosts/test-vm
          ./nixos
          ./users
          home-manager.nixosModules.home-manager
          ./home-manager
          ];
      };

      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};

        modules = [
          ./hosts/laptop
          ./nixos
          ./users
          ];
      };

    };

  };

}
