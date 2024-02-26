{
  description = "How it sounds when you lose your sanity (in NixOS: The Dotfiles Descent) https://youtu.be/hFcLyDb6niA";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, nixpkgs-stable, home-manager, ... }@inputs: {
    # Available through 'nixos-rebuild --flake .#your-hostname'

    nixosConfigurations = {

      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./desktop/configuration.nix
          ];
      };
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./laptop/configuration.nix
          ];
      };
    };
  };
}
