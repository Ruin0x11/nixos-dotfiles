{ config, pkgs, ... }:

{
   imports = [
      ./profiles/default.nix
      ./profiles/graphical-desktop.nix
      ./services/default.nix
   ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };

  # boot.initrd.kernelModules = [ "fbcon" ];
  # boot.kernelParams = [ "consoleblank=0" ];
  boot.cleanTmpDir = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  # hardware.pulseaudio.systemWide = true;
  hardware.pulseaudio.extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1";

  system.autoUpgrade.enable = true;

  services.logind.extraConfig = ''
     KillUserProcesses=no
  '';

  security.pam.services.sudo.nodelay = true;
  security.pam.services.su.nodelay = true;

  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "delete-older-than 30d";

  boot.kernel.sysctl = {
     "fs.inotify.max_user_watches" = 1048576;
     "fs.inotify.max_user_instances" = 1024;
     "fs.inotify.max_queued_events" = 32768;
     "vm.max_map_count" = 262144;
  };

  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];
}
