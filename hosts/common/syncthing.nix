
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
        "Example" = {
          path = "/home/bork/Example";
          devices = [ "device1" ];
        };
      };
      # Default empty devices
      devices = {};
    } (secrets.services.syncthing.settings or {});
  };
}
