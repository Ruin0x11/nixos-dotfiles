{ config, pkgs, ... }:

let secrets = import ../secrets.nix;
in
  {
    services.mpd = { 
      enable = true;
      user = "yuno";

      extraConfig = ''
       audio_buffer_size   "20480"
       buffer_before_play  "30%" 
       audio_output {
         type "pulse"
         name "Pulseaudio"
         server "127.0.0.1"
       }
      '';

      network.listenAddress = "any";
      musicDirectory = "/home/yuno/Music";
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
