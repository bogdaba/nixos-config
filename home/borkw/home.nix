
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
    file = {
      ".bash_profile".source = ../config/bash/.bash_profile;
    };
  };

  xdg.configFile."wezterm/wezterm.lua".source = ../config/wezterm/wezterm.lua;
  xdg.configFile."fish/config.fish".source = ../config/fish/config.fish;
  xdg.configFile."yazi/keymap.toml".source = ../config/yazi/keymap.toml;
  xdg.configFile."yazi/theme.toml".source = ../config/yazi/theme.toml;
  xdg.configFile."yazi/yazi.toml".source = ../config/yazi/yazi.toml;
  xdg.configFile."mpv/input.conf".source = ../config/mpv/input.conf;
  xdg.configFile."mpv/mpv.conf".source = ../config/mpv/mpv.conf;
  xdg.configFile."gtk-4.0/gtk.css".source = ../config/gtk/gtk.css;
xdg.desktopEntries.true-emacs = {
  name = "True Emacs";
  genericName = "Text Editor";
  comment = "Edit text";
  mimeType = [
    "text/english"
    "text/plain"
    "text/x-makefile"
    "text/x-c++hdr"
    "text/x-c++src"
    "text/x-chdr"
    "text/x-csrc"
    "text/x-java"
    "text/x-moc"
    "text/x-pascal"
    "text/x-tcl"
    "text/x-tex"
    "application/x-shellscript"
    "text/x-c"
    "text/x-c++"
  ];
  exec = "emacsclient -cn";
  icon = "emacs";
  type = "Application";
  terminal = false;
  categories = [ "Development" "TextEditor" "Utility" ];
  # startupWMClass = "emacs";
};

xresources.properties = {
  "emacs.inputStyle" = "callback";
};

# dconf.enable = true;
# dconf.settings = {
#     "org/gnome/mutter" = {
#       experimental-features = [ "variable-refresh-rate" ];
#     };
#   };

  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  programs.home-manager.enable = true;
  programs.git.enable = true;
  services.syncthing = {
    enable = true;
    extraOptions = [
      "--home=/home/bork/.config/syncthing"
    ];
  };



  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
