# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

let
  pkgsStable = inputs.nixpkgs-stable.legacyPackages.${pkgs.system};
in

{
  imports = [
    # Import home-manager's NixOS module
    inputs.home-manager.nixosModules.home-manager

    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # My modules
    ../modules/env.nix
    ../modules/fonts.nix
    # ../modules/shell.nix
    # ../modules/vscode.nix
  ];

  nixpkgs = {
    overlays = [
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      # Import your home-manager configuration
      bork = import ../home.nix;
    };
  };


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  boot.initrd.luks.devices."luks-5a3b4af0-d37b-41bb-80d0-8636b7cc2599".device = "/dev/disk/by-uuid/5a3b4af0-d37b-41bb-80d0-8636b7cc2599";

  networking.hostName = "laptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

   # Wayaland
  services.xserver.displayManager.gdm.wayland = true;
  programs.xwayland.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "pl2";

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

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bork = {
    isNormalUser = true;
    description = "bork";
    extraGroups = [ "networkmanager" "wheel" ];
    #shell = pkgs.zsh;
    #packages = with pkgs; [
    #];
  };
# test

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "bork";

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
    obsidian

    emacs
    ripgrep
    # optional dependencies
    coreutils
    fd
    clang
    findutils
    shellcheck
    multimarkdown
    nixfmt
    cmake
    libvterm
    libtool
    gnumake
    gcc

    krusader
    thunderbird
    krename
    kdiff3
    zip
    _7zz
    rar

    vim
    wget
    calibre
    hledger
    qimgv
    anki-bin # the other one is outdated
    libsForQt5.okular
    doublecmd
    syncplay
    mc
    git
    keepassxc
    # firefox
    #obsidian
    gnome.gnome-tweaks
    gnomeExtensions.vertical-workspaces # not sure if this does anything
    qbittorrent
    mpv
    neofetch
    libreoffice
    copyq
    yt-dlp
    speedcrunch
    qpdf
    onlyoffice-bin
    vscode-fhs
    doublecmd
  ];

  programs.firefox = {
    enable = true;
  };

  # nixpkgs.config.firefox.enablePlasmaBrowserIntegration = true;

  services.flatpak.enable = true;

#  environment.pathsToLink = [ "/share/zsh" ];
#  programs.zsh = {
#    enable = true;
#    enableCompletion = true;
#    autosuggestions.enable = true;
#  };

  services.locate.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
