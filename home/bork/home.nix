{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
      # allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "bork";
    homeDirectory = "/home/bork";
    sessionPath = [
      "${config.home.homeDirectory}/.emacs.d/bin"
    ];
  };
  # Wezterm configuration
  xdg.configFile."wezterm/wezterm.lua".source = ../config/wezterm.lua;

  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  programs.home-manager.enable = true;
  programs.git.enable = true;
  services.syncthing.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
