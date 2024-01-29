{ config, pkgs, ... }:
  
{
  environment.homeBinInPath = true;
  environment.sessionVariables = {
    # MOZ_ENABLE_WAYLAND = "1"; # firefox
    # Obsidian has pane bug with electron on. Also need to disable xwayland
    # https://forum.obsidian.md/t/cannot-move-rearrange-panes-when-running-under-wayland/42377/55
    # NIXOS_OZONE_WL = "1"; # electron - enabling 
    LEDGER_FILE = "/home/bork/vault/areas/finances/2024.journal";
    OPENAI_API_KEY="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";
    # PATH = "/home/bork/scripts";
    # QT_QPA_PLATFORM = "wayland";
  };
}
