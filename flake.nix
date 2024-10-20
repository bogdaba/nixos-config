{
  description = "How it sounds when you lose your sanity (in NixOS: The Dotfiles Descent) https://youtu.be/hFcLyDb6niA";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixos-wsl,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
      overlays = import ./overlays {inherit inputs;};
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs;};
          modules = [
            ./hosts/desktop/configuration.nix
          ];
        };
        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs;};
          modules = [
            ./hosts/laptop/configuration.nix
          ];
        };
        lenovo = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs;};
          modules = [
            ./hosts/lenovo/configuration.nix
          ];
        };
        wsl = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs;};
          modules = [
            nixos-wsl.nixosModules.wsl
            ./hosts/wsl/configuration.nix
          ];
        };
      };
      homeConfigurations = {
        "bork" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs;};
          modules = [
            ./home/bork/home.nix
          ];
        };
      };
      homeConfigurations = {
        "borkw" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs;};
          modules = [
            ./home/borkw/home.nix
          ];
        };
      };
    };
}




