{ config, pkgs, ... }:

{
  # systemd.services.noriServer = {
  #   wantedBy = [ "multi-user.target" ];
  #   description = "Run nori docker services at startup";
  #   after = [ "docker.service" "network-online.target" ];
  #   requires = [ "docker.service" "network-online.target" ];
  #   path = [ pkgs.docker pkgs.docker-compose ];

  #   serviceConfig = {
  #     WorkingDirectory = "/home/nori/build/server_config";
  #     Type = "oneshot";
  #     RemainAfterExit = "yes";

  #     ExecStartPre = ''${pkgs.docker-compose}/bin/docker-compose pull --quiet --parallel'';
  #     ExecStart = ''${pkgs.docker-compose}/bin/docker-compose up -d'';

  #     ExecStop = ''${pkgs.docker-compose}/bin/docker-compose down'';

  #     ExecReload = ''${pkgs.docker-compose}/bin/docker-compose pull --quiet --parallel; ${pkgs.docker-compose}/bin/docker-compose up -d'';
  #   };
  # };

  # systemd.services.szurubooru = {
  #   wantedBy = [ "multi-user.target" ];
  #   description = "Run szurubooru docker services at startup";
  #   after = [ "noriServer.service" "docker.service" "network-online.target" ];
  #   requires = [ "docker.service" "network-online.target" ];
  #   path = [ pkgs.docker pkgs.docker-compose ];

  #   serviceConfig = {
  #     WorkingDirectory = "/home/nori/build/server_config/szurubooru";
  #     Type = "oneshot";
  #     RemainAfterExit = "yes";

  #     ExecStartPre = ''${pkgs.docker-compose}/bin/docker-compose pull --quiet --parallel'';
  #     ExecStart = ''${pkgs.docker-compose}/bin/docker-compose up -d'';

  #     ExecStop = ''${pkgs.docker-compose}/bin/docker-compose down'';

  #     ExecReload = ''${pkgs.docker-compose}/bin/docker-compose pull --quiet --parallel; ${pkgs.docker-compose}/bin/docker-compose up -d'';
  #   };
  # };

  systemd = {
    timers.backup-write = {
      wantedBy = [ "timers.target" ];
      partOf = [ "backup-write.service" ];
      timerConfig.OnCalendar = "hourly";
    };
    services.backup-write = {
      serviceConfig.Type = "oneshot";
      path = [ pkgs.bash pkgs.git ];
      script = ''
        /mnt/hibiki/config/remotestorage/backup.sh
      '';
    };
  };
}
