{ config, pkgs, ... }:

{
environment.systemPackages = with pkgs; [
  vim 
  wget
  (vscode-with-extensions.override {
    vscode = vscodium;
    vscodeExtensions = with vscode-extensions; [
      bbenoist.nix
      ms-python.python
      ms-azuretools.vscode-docker
      ms-vscode-remote.remote-ssh
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "remote-ssh-edit";
        publisher = "ms-vscode-remote";
        version = "0.47.2";
        sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
      }
    ];
  })
  calibre
  hledger
  qimgv
  anki
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
  ];
}