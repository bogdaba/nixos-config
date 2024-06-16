{ inputs, config, lib, pkgs, ... }:

{
  systemd.services.drive-mirroring = {
    description = "Drive sync";
    script = ''
      /home/bork/bin/brk-home-backup
    '';
    path = with pkgs; [ bash rsync ];
  };

  systemd.timers.drive-mirroring = {
    description = "Drive sync";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };
}
