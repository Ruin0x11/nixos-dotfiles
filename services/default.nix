{ config, pkgs, ... }:

{
   imports = [
      ./sshd.nix
      ./smartd.nix
   ];
}
