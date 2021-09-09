{ config, pkgs, ... }:

{
  services.xserver = {
     enable = true;
     layout = "us";
     videoDrivers = [ "nvidia" ];

     libinput.enable = true;
  };

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      font-awesome-ttf
    ];
  };

  environment.systemPackages = with pkgs; [
    xorg.xrdb
    xorg.setxkbmap
    xorg.xlsclients
    xorg.xset
    xorg.xsetroot
    xorg.xinput
    xorg.xprop
    xorg.xauth
    xorg.xmodmap
    xorg.xbacklight
    xautolock
    xss-lock
    xtitle
    xclip

    imagemagick

    xterm
    xdg_utils

    rxvt-unicode
    mpv
  ];

  # Enable 3D acceleration for 32bit applications (e.g. wine)
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.enable = true;
}
