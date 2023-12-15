{ config, pkgs, ... }:
  
{
  environment.sessionVariables = {
    # MOZ_ENABLE_WAYLAND = "1"; # firefox
    # Obsidian has pane bug with electron on. Also need to disable xwayland
    # https://forum.obsidian.md/t/cannot-move-rearrange-panes-when-running-under-wayland/42377/55
    # NIXOS_OZONE_WL = "1"; # electron - enabling 
    LEDGER_FILE = "/home/bork/Vault/Finances/2023.journal";
    # PATH = "/home/bork/scripts";
  };
}