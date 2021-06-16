{ config, pkgs, ... }:

{ 
  imports = [];

  networking = {
    hostName = "nori";
    hostId = "95ec4474";
    nameservers = [ "192.168.1.100" ];
    firewall.interfaces.eno1 = {
      allowedUDPPorts = [ 53 ];
      allowedTCPPorts = [ 53 ];
    };
  };
}

