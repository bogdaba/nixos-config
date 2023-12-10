{ config, pkgs, ... }:
  
{
  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1"; # firefox
    NIXOS_OZONE_WL = "1"; # electron
    LEDGER_FILE = "/home/bork/Vault/Finances/2023.journal";
    # PATH = "/home/bork/scripts";
  };
}