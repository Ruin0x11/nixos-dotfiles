{ config, pkgs, ... }:

{ 
   imports = [];

  networking.hostName = "hiro"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
}

