{ inputs, config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cozy
    obsidian
    keepassxc
    pinta
    mpv
    strawberry
    xournalpp
    syncplay
    anki
    todoist-electron
    speedcrunch
    calibre
    onlyoffice-bin
    beancount
    xeyes
  ];

  programs.firefox = {
    enable = true;
  };

}
