{ inputs, outputs, lib, config, pkgs, ... }:

#let
#  pkgsStable = inputs.nixpkgs-stable.legacyPackages.${pkgs.system};
#in

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
    # ../modules/programs.nix
    # ../modules/shell.nix
    ../common/nvidia.nix
    ../common/python.nix
    ../common/ollama.nix
    ../common/emacs.nix
    ../common/rust.nix
    ../common/input.nix
    ../common/terminal.nix
  ];
  
  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
  };

  # home-manager = {
  #   extraSpecialArgs = { inherit inputs outputs; };
  #   users = {
  #     bork = import ../../home/bork/home.nix;
  #   };
  # };

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


  # services.xserver.enable = true;
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.wayland = false;
  # programs.xwayland.enable = true;
  # hardware.nvidia.forceFullCompositionPipeline = true;

  # GTK applications
  # programs.dconf.enable = true;
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
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
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
    #shell = pkgs.zsh;
    packages = with pkgs; [
    ];
  };

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "bork";
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
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
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  environment.systemPackages = with pkgs; [
    inputs.home-manager.packages.${pkgs.system}.default
    vim
    wget
    kate
    # firefox
    gnomeExtensions.appindicator
    gnomeExtensions.tiling-assistant
    gnome.gnome-tweaks
    gnomeExtensions.ddterm
    gnomeExtensions.vertical-workspaces
    gnomeExtensions.kimpanel
    gnomeExtensions.paperwm
    gnomeExtensions.just-perfection
    xorg.xeyes
    # emacs29
    # optional dependencies
    # coreutils
    # fd
    # clang
    # findutils
    # shellcheck
    # multimarkdown
    # nixfmt-classic
    # nixfmt-rfc-style
    # cmake
    # libvterm
    # libtool
    # gnumake
    # gcc

    keepassxc
    git
    obsidian
    pkgsUnstable.vscode-fhs
    syncplay
    davinci-resolve
    pkgsUnstable.krita
    pkgsUnstable.krita-plugin-gmic
    gmic-qt
    blender
    pkgsUnstable.godot_4

    krusader
    thunderbird
    krename
    kdiff3
    zip
    _7zz
    rar
    curl
    pkgsUnstable.anki
    mpv
    pkgsUnstable.ffmpeg_7-full
    # tts
    python3
    poetry
    handbrake
    hledger
    # pass
    speedcrunch
    qbittorrent
    pkgsUnstable.yt-dlp
    qpdf
    doublecmd
    calibre
    libreoffice-qt
    onlyoffice-bin
    jumpapp
    pkgsUnstable.todoist-electron
    flameshot
    # fish
    libwebp
    neovim
    nnn
    rclone
    mc
    # ranger
    pkgsUnstable.cozy
    deja-dup
    pkgsUnstable.mullvad-vpn
    pkgsUnstable.mullvad-browser
    pdfcrack
    john
    johnny
    hashcat
    # cudaPackages.cuda_cudart
    conky
    lm_sensors
    netdata
    htop
    gmic-qt
    pkgsUnstable.discordchatexporter-cli
    gimp-with-plugins
    gimpPlugins.gmic
    pkgsUnstable.copyq
    # ranger
    kitty
    pkgsUnstable.digikam
    zotero
    #mpd
    #ncmpcpp
    #rhythmbox
    strawberry
    #rcs
    #mangohud
    #brave

    # vesktop
    beancount
    fava
    # wrapGAppsHook # doesn't do anything on its own
    # android-tools
    aseprite
    neofetch
    gnumeric
    pkgsUnstable.sc-im
    pkgsUnstable.archivebox
    pkgsUnstable.single-file-cli
    # passmark-performancetest

    pkgsUnstable.planify
    libsForQt5.okular
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    # lf
    pkgsUnstable.logseq
    sqlite
    pkgsUnstable.qutebrowser
    brave
    floorp
    pandoc
    chromium
    pkgsUnstable.backgroundremover
    pkgsUnstable.ollama
    sxhkd
    xorg.xmodmap
    pkgsUnstable.gifski
    rclone
    cryptsetup
    tor-browser
    pkgsUnstable.hydrus
    ueberzug
    # zed-editor
    # helix
  ];

  programs.firefox = {
    enable = true;
  };
  programs.tmux.enable= true;

  programs.zsh.enable = true;

  programs.neovim = {
    enable = true;
  };

  programs.adb.enable = true;


  programs.fish.enable = true;
  programs.starship.enable = true;

  # nixpkgs.config.firefox.enablePlasmaBrowserIntegration = true;

  services.flatpak.enable = true;

  # services.monit.enable = true;

  # services.mpd.enable = true;

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
