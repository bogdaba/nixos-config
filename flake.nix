{
  description = "How it sounds when you lose your sanity (in NixOS: The Dotfiles Descent) https://youtu.be/hFcLyDb6niA";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    in {
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
      overlays = import ./overlays {inherit inputs;};
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/desktop/configuration.nix
          ];
        };
      };
      homeConfigurations = {
        "bork@desktop" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home/bork/home.nix
          ];
        };
      };
    };
}




