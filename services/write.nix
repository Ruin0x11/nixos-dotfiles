{ pkgs, ... }:

{
  systemd = {
    timers.backup-write = {
      wantedBy = [ "timers.target" ];
      partOf = [ "backup-write.service" ];
      timerConfig.OnCalendar = "hourly";
    };
    services.backup-write = {
      serviceConfig.Type = "oneshot";
      script = ''
        bash /mnt/hibiki/config/remotestorage/backup.sh
      '';
    };
  };
}
