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
    # Import home-manager's NixOS module
    # inputs.home-manager.nixosModules.home-manager

    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # My modules
    ../common/env.nix
    ../common/fonts.nix
    # ../common/nvidia.nix
    # ../common/python.nix
    # ../common/ollama.nix
    ../common/emacs.nix
    ../common/rust.nix
    ../common/input.nix
    ../common/terminal.nix
    ../common/misc.nix
    ../common/gnome.nix
    # ../common/systemd-desktop.nix
    # ../modules/programs.nix
    # ../modules/shell.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
  };

  # home-manager = {
  #   extraSpecialArgs = { inherit inputs; };
  #   users = {
  #     # Import your home-manager configuration
  #     bork = import ../home.nix;
  #   };
  # };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 14d";
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  boot.initrd.luks.devices."luks-5a3b4af0-d37b-41bb-80d0-8636b7cc2599".device = "/dev/disk/by-uuid/5a3b4af0-d37b-41bb-80d0-8636b7cc2599";

  networking.hostName = "laptop";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  services.xserver = {
    enable = true;
    displayManager = {
      gdm = {
        enable = true;
        wayland = false;
      };
    };
    desktopManager.gnome.enable = true;
  };
  programs.xwayland.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bork = {
    isNormalUser = true;
    description = "bork";
    extraGroups = [ "networkmanager" "wheel" ];
    #shell = pkgs.zsh;
    #packages = with pkgs; [
    #];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "bork";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
    ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    inputs.home-manager.packages.${pkgs.system}.default
    krusader
    thunderbird
    krename
    kdiff3
    zip
    _7zz
    rar
    hledger
    qimgv
    libsForQt5.okular
    # firefox
    #obsidian
    qbittorrent
    python3
    neofetch
    copyq
    jumpapp
    libwebp
    sqlite
    usbimager
  ];

  services.flatpak.enable = true;

  services.locate.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
