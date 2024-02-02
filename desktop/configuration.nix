# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:
{
  imports = [
    # Import home-manager's NixOS module
    inputs.home-manager.nixosModules.home-manager

    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # My modules
    ../modules/env.nix
    ../modules/fonts.nix
    ../modules/programs.nix
    ../modules/shell.nix
    ../modules/nvidia.nix
    ../modules/python.nix
  ];
  

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      #outputs.overlays.additions
      #outputs.overlays.modifications
      #outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
      (final: prev: {
        obsidian-wayland = prev.obsidian.override {electron = final.electron_24;};
      })
    ];
  };
  # test
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      # Import your home-manager configuration
      bork = import ../home.nix;
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  #nix.gc.automatic = true;
  

  # Bootloader.
  #boot.kernelPackages = pkgs.linuxPackages_latest;

  # Due to issues with detecting bootable drives by mobo better not to touch this
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.grub.efiSupport = true;
  #boot.loader.grub.enable = true;
  #boot.loader.grub.device = "nodev";
  #boot.loader.grub.useOSProber = true;
  

  boot.supportedFilesystems = [ "ntfs" ];


  #fileSystems."/mnt/hdd" =
  #{ device = "/dev/sdb2/FE3425B034256CB9";
  #    fsType = "ntfs-3g"; 
  #    options = [ "rw" "uid=theUidOfYourUser"];
  #};

  networking.hostName = "desktop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";
  time.hardwareClockInLocalTime = true;

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

  # Graphics
  hardware.enableAllFirmware = true;
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;

  # Wayland
  #services.xserver.displayManager.gdm.wayland = false;
  #programs.xwayland.enable = true;
  #environment.sessionVariables.QT_QPA_PLATFORM = "wayland"; # for qt apps

  #environment.sessionVariables.NIXOS_OZONE_WL = "1"; # for electron apps
  #environment.sessionVariables.OBSIDIAN_USE_WAYLAND = "1";
  
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "pl";
    xkbVariant = "";
  };
  
  i18n = {
    inputMethod = {
      enabled = "fcitx5"; #or ibus
      #ibus.engines = with pkgs.ibus-engines; [ mozc ];
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
    };
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
  # services.xserver.libinput.enable = true;

  users.users.bork = {
    isNormalUser = true;
    description = "bork";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      krita
      # discord
      blender
      gimp-with-plugins
      godot_4
      brave
      onlyoffice-bin
      wtype
      libsForQt5.kdenlive
      # krusader stuff
      krusader
      findutils
      libsForQt5.kio-extras
      libsForQt5.kget
      kompare # or kdiff3
      krename
      thunderbird
      gnutar
      gzip
      bzip2
      xz
      zip
      unzip
      rar
      rpm
      dpkg
      arj
      lha
      p7zip
      libsForQt5.breeze-qt5 #hopefully this fixes icons
      libsForQt5.breeze-gtk
      libsForQt5.breeze-icons
      #
      strawberry
      #amarok # doesn't work
      #cozy # flatpak?
      jetbrains.pycharm-community
      palemoon-bin
      nomacs
      wacomtablet
      libwacom
      xf86_input_wacom
      ungoogled-chromium
    ];
  };

  programs.steam = {
  enable = true;
  };

  
  environment.systemPackages = with pkgs; [
    #davinci-resolve
    steam-run
    ffmpeg_5-full
    imagemagick
    xorg.xprop
    #chromium
    obsidian
    #tts
    safeeyes
    workrave
    stretchly
    emacs
    ripgrep
    coreutils
    fd
    clang
    handbrake
    nixfmt
    libvterm
    gnumake
    cmake
    libtool
  ];

  services.flatpak.enable = true;

  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;
   
  # Virtualisation
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  
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
    "electron-24.8.6"
    ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget

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
