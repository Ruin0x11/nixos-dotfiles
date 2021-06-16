{ config, pkgs, ... }:

{
   imports = [
      ./sshd.nix
      ./mpd.nix
      ./docker.nix
      ./zfs.nix
      ./coredns.nix
      ./systemd.nix
   ];
}
