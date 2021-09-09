{ config, pkgs, ... }:

{
   imports = [
      ./channels.nix
      ./profiles/default.nix
      ./profiles/graphical-mpv.nix
      ./services/default.nix
      ./users/nori.nix
   ];

  nixpkgs.config.allowUnfree = true;

  # boot.initrd.kernelModules = [ "fbcon" ];
  # boot.kernelParams = [ "consoleblank=0" ];
  boot.cleanTmpDir = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.eno2.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.systemWide = true;
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
