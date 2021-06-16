{ config, pkgs, ... }:

{
  boot.supportedFilesystems = [ "zfs" ];
  services.zfs.autoScrub.enable = true;
}
