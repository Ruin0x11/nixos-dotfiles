{ config, pkgs, ... }:

{
  services.mpd = { 
     enable = true;

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
}
