{ config, pkgs, ... }:

{
  imports = [ ./graphical.nix ];

  services.xserver = {
     windowManager = {
        i3.enable = true;
        i3.package = pkgs.i3-gaps;
     };
     
     displayManager = {
        startx.enable = true;
     };
  };

  fonts = {
    fonts = with pkgs; [
      dejavu_fonts
      emojione
      fira-code
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
    imagemagick

    dmenu
    feh
    i3blocks
    scrot

    dunst
    wireshark
    firefox
    gimp
    xfontsel
    vimHugeX
    evince
  ];
}
