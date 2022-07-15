{ config, lib, pkgs, ... }:

{
  nixpkgs.config = import ./common/nixpkgs-config.nix;
  xdg.configFile."nixpkgs/config.nix".source = ./common/nixpkgs-config.nix;
}
