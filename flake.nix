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
      macbook = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-darwin;
        modules = [./home-manager/macbook.nix];
      };
      gcloud = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [./home-manager/gcloud.nix];
      };
      rldl = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [./home-manager/rldl.nix];
      };
    };
  };
}
