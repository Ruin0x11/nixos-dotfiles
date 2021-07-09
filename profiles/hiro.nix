{ config, pkgs, nixpkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    dhall
    dhall-json
    docker
    docker-compose
    duplicity
    backblaze-b2
    megatools
    gdrive
  ];
}
