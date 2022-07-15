{ config, pkgs, nixpkgs, ... }:

{
  # nixpkgs.config.packageOverrides = pkgs: {
  #   zfs = pkgs.zfs.override {
  #     enableMail = true;
  #   };
  # };

  boot.supportedFilesystems = [ "zfs" ];
  services.zfs.autoScrub.enable = true;

  services.zfs.zed.enableMail = true;
  services.zfs.zed.settings = {
    ZED_DEBUG_LOG = "/tmp/zed.debug.log";
    ZED_EMAIL_ADDR = [ "nonbirithm@fastmail.com" ];
    ZED_EMAIL_OPTS = "-s '@SUBJECT@' @ADDRESS@ -r nonbirithm@fastmail.com";
    ZED_NOTIFY_INTERVAL_SECS = 3600;
    ZED_NOTIFY_VERBOSE = true;
    ZED_USE_ENCLOSURE_LEDS = true;
    ZED_SCRUB_AFTER_RESILVER = false;
  };
}
