{ inputs, outputs, lib, config, pkgs, ... }:

let
  pkgsUnstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config = {
      allowUnfree = true; 
      permittedInsecurePackages = [
        "electron-27.3.11"
        "python3.12-django-3.1.14"
        "python3.12-youtube-dl-2021.12.17"
      ];
    };
  };
in
# update --option eval-cache false
{
  imports = [
    # Import home-manager's NixOS module
    # inputs.home-manager.nixosModules.home-manager

    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # My modules
    ../common/env.nix
    ../common/fonts.nix
    ../common/nvidia.nix
    ../common/python.nix
    ../common/ollama.nix
    ../common/emacs.nix
    ../common/rust.nix
    ../common/input.nix
    ../common/terminal.nix
    ../common/misc.nix
    ../common/gnome.nix
    ../common/systemd-desktop.nix
    ../common/lutris.nix
    # ../common/syncthing.nix
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


  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Mounted filesystems
  fileSystems."/mnt/australia" = {
    device = "/dev/disk/by-uuid/c5b755c1-08ce-49de-b915-9784b2f1be2a";
    fsType = "ext4";
    options = ["nofail"];

  };

  networking.hostName = "desktop";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Warsaw";
  time.hardwareClockInLocalTime = true;

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

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "bork";
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # GTK applications
  programs.dconf.enable = true;
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

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
    "python3.11-django-3.1.14"
  ];

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  environment.systemPackages = with pkgs; [
    inputs.home-manager.packages.${pkgs.system}.default
    unstable.zed-editor
    vscodium
    gedit
    kate
    xorg.xeyes
    pkgsUnstable.vscode-fhs
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
    mpv
    pkgsUnstable.ffmpeg_7-full
    # tts
    python3
    poetry
    handbrake
    hledger
    # pass
    qbittorrent
    libreoffice-qt
    jumpapp
    pkgsUnstable.todoist-electron
    flameshot
    # fish
    libwebp
    # nnn
    rclone
    # mc
    # ranger
    cozy
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
    gmic-qt
    pkgsUnstable.discordchatexporter-cli
    gimp-with-plugins
    gimpPlugins.gmic
    pkgsUnstable.copyq
    # ranger
    # kitty
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
    archivebox
    pkgsUnstable.single-file-cli
    # passmark-performancetest
    libsForQt5.okular
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    # lf
    # pkgsUnstable.logseq
    sqlite
    qimgv
    qutebrowser
    brave
    floorp
    pandoc
    # chromium
    pkgsUnstable.backgroundremover
    ollama
    sxhkd
    xorg.xmodmap
    pkgsUnstable.gifski
    rclone
    cryptsetup
    tor-browser
    unstable.hydrus
    solaar
    piper
    logseq
    mindforger
    voicevox
  ];
  programs.adb.enable = true;
  services.flatpak.enable = true;
  services.locate.enable = true;
  programs.steam.enable = true;

  # services.mullvad-vpn.enable = true;
  # services.mullvad-vpn.package = pkgs.mullvad-vpn;
   
  # Virtualisation
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
