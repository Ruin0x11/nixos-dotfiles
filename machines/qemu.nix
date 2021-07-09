{ config, pkgs, ... }:

{ 
   imports = [
      ../profiles/graphical.nix
   ];

  networking.hostName = "qemu"; # Define your hostname.
}

