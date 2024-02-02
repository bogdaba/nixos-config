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

  home = {
    username = "bork";
    homeDirectory = "/home/bork";
   # shellAliases = {
   #   
   # };
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake /home/bork/nixos-config";
      test = "echo \"test\"";
    };
    history.size = 15000;
    history.path = "${config.xdg.dataHome}/.histfile";
  };

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

  #programs.bash.shellAliases = {
  #  nixsus = "sudo nixos-rebuild switch --flake /home/bork/nix-config#desktop";
  #};

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
