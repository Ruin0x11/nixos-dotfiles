{ config, pkgs, ... }:

let secrets = import ../secrets.nix;
in
  {
    services.duplicity = { 
      enable = true;

      exclude = [ "**/*" ];
      include = [
        "/home/nori"
        "/etc"
        "/mnt/hibiki/config"
        "/mnt/hibiki/back"
        "/mnt/hibiki/picture/scrots"
        "/mnt/hibiki/elona"
        "/home/nori/build/script"
      ];

      targetUrl = "b2://${secrets.duplicity.account}:${secrets.duplicity.key}@${secrets.duplicity.bucket}/nori_all";
      frequency = "daily";
      fullIfOlderThan = "1M";
      cleanup.maxFull = 3;
      extraFlags = [ "--no-encryption" ];
    };
  }
