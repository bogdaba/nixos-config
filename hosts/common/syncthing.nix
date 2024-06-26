{ inputs, config, lib, pkgs, ... }:
let
  secretsFile = ./syncthing-secrets.nix;
  secretsFileExists = builtins.pathExists secretsFile;
  secrets = if secretsFileExists then import secretsFile else {};
in
{
  services.syncthing = {
    enable = true;
    user = "bork";
    dataDir = "/home/bork/Sync";
    configDir = "/home/bork/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    settings = lib.recursiveUpdate {
      folders = {
        "Documents" = {
          path = "/home/bork/Documents";
          devices = [ "desktop" ];
        };
      };
      devices = secrets.services.syncthing.settings.devices or {};
    } (secrets.services.syncthing.settings or {});
  };
}
