{
  description = "Minimal nix config for Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/d479580285ed54b392f718c23a2d0cbfd303b62b";
    home-manager.url = "github:nix-community/home-manager/b3acf1dc78b38a2fe03b287fead44d7ad25ac7c5";
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
