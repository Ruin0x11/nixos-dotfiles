{ config, pkgs, ... }:

let secrets = import ../secrets.nix;
in
  {
    services.duplicity = { 
      enable = true;

      exclude = [ "/**" ];
      include = [
        "/home/nori/Documents"
        "/etc"
        "/mnt/hibiki/config/szurubooru"
        "/mnt/hibiki/config/szurupull"
        "/mnt/hibiki/config/niacademy"
        "/mnt/hibiki/config/shaarli"
        "/mnt/hibiki/config/scribl"
        "/mnt/hibiki/config/remotestorage"
        "/mnt/hibiki/picture/scrots"
        "/mnt/hibiki/elona"
        "/home/nori/build/script"
      ];

      targetUrl = "b2://${secrets.duplicity.account}:${secrets.duplicity.key}@${secrets.duplicity.bucket}/nori_all";
      frequency = "weekly";
      fullIfOlderThan = "1M";
      cleanup.maxFull = 3;
      extraFlags = [ "--no-encryption" ];
    };
  }
