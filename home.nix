{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
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
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  programs.bash.enable = true;

  home.packages = with pkgs; [
    # Add other packages you want to install here
  ];

  home = {
    username = "bork";
    homeDirectory = "/home/bork";
    sessionPath = [
      "${config.home.homeDirectory}/.config/emacs/bin"
    ];
  #   file."bin/brk-rsync-home" = {
  #   executable = true;
  #   text = ''
  #     #!/usr/bin/env bash

  #     # Define source and destination
  #     SOURCE="/home/bork"
  #     DEST="/mnt/hdd/backups/home-nixos"

  #     # Define directories to exclude
  #     EXCLUDE_DIRS=(".local/share/Steam" ".cache")
  #     EXCLUDES=()

  #     for dir in "\${EXCLUDE_DIRS[@]}"; do
  #       EXCLUDES+=("--exclude=$dir")
  #     done

  #     # Run rsync to copy files
  #     rsync -ahAE --progress --delete "${EXCLUDES[@]}" --stats $SOURCE $DEST 2>&1 | tee "$HOME/log/drive-mirroring.log"
  #   '';
  # };

   # shellAliases = {
   #   
   # };
  };

#  programs.zsh = {
#    enable = true;
#    shellAliases = {
#      ll = "ls -l";
#      update = "sudo nixos-rebuild switch --flake /home/bork/nixos-config";
#      test = "echo \"test\"";
#    };
#    history = {
#      size = 15000;
#      path = "${config.xdg.dataHome}/.histfile";
#      share = true;
#    };
#
#  };

  # xdg.userDirs = {
  # enable = true;
  # desktop      = "${config.home.homeDirectory}/desktop";
  # documents    = "${config.home.homeDirectory}/documents";
  # download     = "${config.home.homeDirectory}/downloads";
  # music        = "${config.home.homeDirectory}/music";
  # pictures     = "${config.home.homeDirectory}/pictures";
  # publicShare  = "${config.home.homeDirectory}/public";
  # templates    = "${config.home.homeDirectory}/templates";
  # videos       = "${config.home.homeDirectory}/videos";
  # };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName  = "bogdaba";
    userEmail = "bogdaba@github.com";
  };

  services.syncthing.enable = true;

  #services.mpd = {
  #  enable = true;
  #  musicDirectory = "/home/bork/Music";
  #  extraConfig = ''
  #    user "bork"
  #    bind_to_address "127.0.0.1"
  #    port "6600"
  #    playlist_directory "/home/bork/.config/mpd/playlists"
  #    db_file "/home/bork/.config/mpd/mpd.db"
  #    log_file "/home/bork/.config/mpd/mpd.log"
  #    pid_file "/home/bork/.config/mpd/mpd.pid"
  #    state_file "/home/bork/.config/mpd/mpdstate"
  #    restore_paused "yes"
  #    max_playlist_length "400000"
  #
  #    audio_output {
  #            type            "pipewire"
  #            name            "PipeWire Sound Server"
  #      }
#
  #      audio_output {
  #          type                    "fifo"
  #          name                    "FIFO"
  #          path                    "/tmp/mpd.fifo"
  #          format                  "44100:16:2"
  #      }
  #    auto_update "yes"
  #  '';
  #};
#
  #programs.ncmpcpp = {
  #  enable = true;
  #  mpdMusicDir = "/home/bork/Music";
  #  settings = {
  #    mpd_host = "127.0.0.1";
  #    mpd_port = 6600;
  #  };
  #};
  
  #programs.bash.shellAliases = {
  #  nixsus = "sudo nixos-rebuild switch --flake /home/bork/nix-config#desktop";
  #};

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
