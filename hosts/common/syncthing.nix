{ config, lib, pkgs, ... }:

let
  secretsFile = ./syncthing-secrets.nix;
  secretsFileExists = builtins.pathExists secretsFile;
  secrets = if secretsFileExists then import secretsFile else {};

  # Debug output
  debugOutput = builtins.trace "Secrets file exists: ${builtins.toString secretsFileExists}"
                (builtins.trace "Secrets content: ${builtins.toJSON secrets}"
                (builtins.trace "Current directory: ${builtins.toString ./.}" ""));

  # Helper function to safely access nested attributes
  getAttrSafe = attrs: path:
    let
      helper = attrs: path:
        if path == [] then attrs
        else if builtins.isAttrs attrs && attrs ? ${builtins.head path}
          then helper attrs.${builtins.head path} (builtins.tail path)
          else null;
    in helper attrs path;

  # Get the desktop ID from secrets
  desktopId = getAttrSafe secrets ["devices" "desktop" "id"];
in
{
  # Use the debug output
  _module.args.debugOutput = debugOutput;

  services.syncthing = {
    enable = true;
    user = "bork";
    dataDir = "/home/bork/Sync";
    configDir = "/home/bork/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "desktop" = {
          id = if desktopId != null
               then desktopId
               else throw "Syncthing device ID for 'desktop' not found in secrets file. Please ensure it's properly configured.";
        };
      };
      folders = {
        "Documents" = {
          path = "/home/bork/Documents";
          devices = [ "desktop" ];
        };
      };
    };
  };
}
