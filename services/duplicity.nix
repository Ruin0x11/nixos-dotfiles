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

      targetUrl = "b2://$B2_ACCOUNT:$B2_KEY@$B2_BUCKET/nori_all";
      frequency = "daily";
      fullIfOlderThan = "1M";
      cleanup.maxFull = 3;
      extraFlags = [ "--no-encryption" ];

      secretFile = "/etc/duplicity_secrets";
    };
    environment.etc."duplicity_secrets" = {
      mode = "0555";
      text = secrets.duplicitySecrets;
    };
  }
