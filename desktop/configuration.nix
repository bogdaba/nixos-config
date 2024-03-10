# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

#let
#  pkgsStable = inputs.nixpkgs-stable.legacyPackages.${pkgs.system};
#in

let
  pkgsStable = import inputs.nixpkgs-stable {
    system = pkgs.system;
    config = { allowUnfree = true; };
  };
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
    # ../modules/programs.nix
    # ../modules/shell.nix
    ../modules/nvidia.nix
    ../modules/python.nix
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
  nix.settings.auto-optimise-store = true;


  # Bootloader.
  #boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "desktop"; # Define your hostname.
  networking.networkmanager.enable = true;

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

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # GTK applications
  programs.dconf.enable = true;
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };
  
  # Configure console keymap
  console.keyMap = "pl2";

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
    #shell = pkgs.zsh;
    packages = with pkgs; [
    ];
  };

  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "bork";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  systemd.services.drive-mirroring = {
    description = "Drive sync";
    script = ''
      /home/bork/bin/brk-home-backup
    '';
    path = with pkgs; [ bash rsync ];
  };

  systemd.timers.drive-mirroring = {
    description = "Drive sync";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };

  # environment.homeBinInPath = true;
  # environment.sessionVariables = {
  #   # MOZ_ENABLE_WAYLAND = "1"; # firefox
  #   # Obsidian has pane bug with electron on. Also need to disable xwayland
  #   # https://forum.obsidian.md/t/cannot-move-rearrange-panes-when-running-under-wayland/42377/55
  #   # NIXOS_OZONE_WL = "1"; # electron - enabling
  #   LEDGER_FILE = "/home/bork/vault/areas/finances/2024.journal";
  #   # PATH = "/home/bork/scripts";
  #   # QT_QPA_PLATFORM = "wayland";
  # };

  environment.systemPackages = with pkgs; [
    vim
    wget
    kate
    # firefox

    emacs29
    ripgrep
    # optional dependencies
    emacsPackages.vterm
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

    keepassxc
    git
    obsidian
    vscode-fhs
    syncplay
    davinci-resolve
    krita
    pkgsStable.blender
    godot_4

    krusader
    thunderbird
    krename
    kdiff3
    zip
    _7zz
    rar
    curl
    anki
    mpv
    ffmpeg
    pkgsStable.tts
    python3
    poetry
    handbrake
    hledger
    # pass
    speedcrunch
    qbittorrent
    yt-dlp
    qpdf
    pkgsStable.doublecmd
    calibre
    libreoffice-qt
    onlyoffice-bin
    jumpapp
    todoist-electron
    flameshot
    fish
    libwebp
    neovim
    # vesktop
    # wrapGAppsHook # doesn't do anything on its own
  ];

  programs.firefox = {
    enable = true;
  };

  # nixpkgs.config.firefox.enablePlasmaBrowserIntegration = true;

  services.flatpak.enable = true;

  #environment.pathsToLink = [ "/share/zsh" ];
  #programs.zsh = {
  #  enable = true;
  #  enableCompletion = true;
  #  autosuggestions.enable = true;
  #};

  services.locate.enable = true;

  programs.steam.enable = true;

  # services.mullvad-vpn.enable = true;
  # services.mullvad-vpn.package = pkgs.mullvad-vpn;
   
  # Virtualisation
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  

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
