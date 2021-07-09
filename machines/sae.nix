{ config, pkgs, ... }:

{ 
   imports = [];

  networking.hostName = "sae"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.wireless.interfaces = [ "wls3" ];
  networking.wireless.userControlled.enable = true;
  networking.nameservers = [ "8.8.8.8" ];

  networking.interfaces.ens2.useDHCP = true;
  networking.interfaces.wls3.useDHCP = true;

  boot.initrd.kernelModules = [ "e1000e" ];
}

