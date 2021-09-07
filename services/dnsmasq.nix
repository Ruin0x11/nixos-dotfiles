
{ config, pkgs, ... }:

{
  services.dnsmasq = { 
    enable = true;
    resolveLocalQueries = true;
    extraConfig = ''
      domain-needed
      bogus-priv
      no-hosts
      #keep-in-foreground
      no-resolv
      expand-hosts
      log-dhcp
      log-queries
      interface=eno1
      listen-address=127.0.0.1
      listen-address=192.168.0.100
      server=8.8.4.4
      server=8.8.8.8
      address=/.nori.daikon/192.168.1.100
      rebind-domain-ok=/plex.direct/
    '';
  };
}
