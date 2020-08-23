
{ config, pkgs, ... }:

{
   imports = [
      ./channels.nix
      ./profiles/default.nix
      ./services/default.nix
      ./users/hiro.nix
   ];

  nixpkgs.config.allowUnfree = true;

  boot.initrd.kernelModules = [ "fbcon" ];
  boot.kernelParams = [ "consoleblank=0" ];
  boot.cleanTmpDir = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.ens3.useDHCP = true;

  networking.nameservers = [
      "192.168.1.100"
      "8.8.8.8"
      "4.4.4.4"
  ];

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.displayManager.startx.enable = true;
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  system.autoUpgrade.enable = true;

  services.logind.extraConfig = ''
     KillUserProcesses=no
  '';
 
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "delete-older-than 30d";

  boot.kernel.sysctl = {
     "fs.inotify.max_user_watches" = 1048576;
     "fs.inotify.max_user_instances" = 1024;
     "fs.inotify.max_queued_events" = 32768;
  };
}
