{ inputs, config, pkgs, ... }:

{
  imports = [
    ./vscode.nix
  ];

environment.systemPackages = with pkgs; [
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
  firefox
  obsidian
  gnome.gnome-tweaks
  gnomeExtensions.vertical-workspaces # not sure if this does anything
  p7zip
  unzip
  qbittorrent
  celluloid
  mpv
  neofetch
  mullvad-browser
  libreoffice
  copyq
  yt-dlp
  ];
}