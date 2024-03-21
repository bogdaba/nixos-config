{ config, pkgs, ... }:
  
{
  environment.homeBinInPath = true;
  environment.sessionVariables = {
    # MOZ_ENABLE_WAYLAND = "1"; # firefox
    # Obsidian has pane bug with electron on. Also need to disable xwayland
    # https://forum.obsidian.md/t/cannot-move-rearrange-panes-when-running-under-wayland/42377/55
    # NIXOS_OZONE_WL = "1"; # electron - enabling
    LEDGER_FILE = "/home/bork/vault/codex/finances/2024.journal";
    # PATH = "/home/bork/scripts";
  };
  environment.shellAliases = {
    update = "sudo nixos-rebuild switch --flake /home/bork/nixos-config#";
  };
  environment.variables = {
    # QT_QPA_PLATFORM = "wayland";
  };
}
