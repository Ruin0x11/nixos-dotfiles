{ config, pkgs, ... }:

{
   imports = [
      ./sshd.nix
      ./mpd.nix
      ./docker.nix
      ./zfs.nix
      ./dnsmasq.nix
      ./systemd.nix
   ];
}
