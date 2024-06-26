{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...

}:
let
  secretsFile = ./syncthing-secrets.nix;
  secretsFileExists = builtins.pathExists secretsFile;
  secrets = if secretsFileExists then import secretsFile else {};
in
{
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

  xdg.configFile."wezterm/wezterm.lua".source = ../config/wezterm/wezterm.lua;
  xdg.configFile."fish/config.fish".source = ../config/fish/config.fish;
  xdg.configFile."yazi/keymap.toml".source = ../config/yazi/keymap.toml;
  xdg.configFile."yazi/theme.toml".source = ../config/yazi/theme.toml;
  xdg.configFile."yazi/yazi.toml".source = ../config/yazi/yazi.toml;
  xdg.configFile."mpv/input.conf".source = ../config/mpv/input.conf;
  xdg.configFile."mpv/mpv.conf".source = ../config/mpv/mpv.conf;

  programs.bash = {
    enable = true;
    profileExtra = ''
      if [ -t 1 ]; then
        exec fish
      fi
    '';
  };

  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  programs.home-manager.enable = true;
  programs.git.enable = true;



  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
