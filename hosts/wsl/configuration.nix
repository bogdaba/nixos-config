# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ inputs, outputs, lib, config, pkgs, ... }:

let
  pkgsUnstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-27.3.11"
        "python3.11-django-3.1.14"
      ];
    };
  };
in

{


  imports = [
../common/env.nix
../common/fonts.nix
../common/emacs.nix
../common/rust.nix
../common/input.nix
../common/terminal.nix
../common/misc.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  wsl.enable = true;
  wsl.defaultUser = "bork";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking.hostName = "wsl";
  networking.networkmanager.enable = true;
  environment.systemPackages = with pkgs; [
inputs.home-manager.packages.${pkgs.system}.default

git
];
nixpkgs.config.allowUnfree = true;
# Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}