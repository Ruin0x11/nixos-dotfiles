{ config, pkgs, ... }:

{
   imports = [
      ./mpd.nix
      ./docker.nix
      ./zfs.nix
      ./dnsmasq.nix
      ./systemd.nix
      ./duplicity.nix
   ];
}
