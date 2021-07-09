{ config, pkgs, ... }:

let secrets = import ../secrets.nix;
in
  {
    services.mpd = { 
      enable = true;
      user = "nori";

      extraConfig = ''
       audio_output {
         type "pulse"
         name "Pulseaudio"
         server "127.0.0.1"
       }
      '';

      network.listenAddress = "any";
      musicDirectory = "/home/nori/Music";
    };

    services.mpdscribble = {
      enable = true;
      endpoints = {
        "last.fm" = {
          username = "IPickering";
          passwordFile = "/etc/lastfm_password";
        };
      };
    };

    environment.etc."lastfm_password" = {
      mode = "0555";
      text = secrets.mpdscribblePassword;
    };
  }
