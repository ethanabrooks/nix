{
  description = "Minimal nix config for Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: {
    homeConfigurations = {
      linux = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [./home-manager/linux.nix];
      };
    };
  };
}
