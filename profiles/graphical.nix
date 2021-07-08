{ config, pkgs, ... }:

{
  services.xserver = {
     enable = true;
     autorun = true;
     layout = "us";
     
     windowManager = {
        fluxbox.enable = true;
     };
     
     displayManager = {
        lightdm.enable = true;
        #defaultSession = "none+jwm";
     };

     libinput.enable = true;
  };

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      dejavu_fonts
      emojione
      fira-code
      font-awesome-ttf
      inconsolata
      proggyfonts
      powerline-fonts
      source-code-pro
      source-sans-pro
      source-serif-pro
      terminus_font
      ubuntu_font_family
      vistafonts
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
    dmenu
    feh
    scrot

    conky
    dunst
    firefox
    gimp
    xfontsel
    vimHugeX
    evince
  ];

  # Enable 3D acceleration for 32bit applications (e.g. wine)
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.enable = true;
}
