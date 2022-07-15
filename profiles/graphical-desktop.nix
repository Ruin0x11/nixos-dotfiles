{ config, pkgs, ... }:

{
  imports = [ 
    ./graphical.nix 
    # ../packages/firefox.nix
  ];

  services.xserver = {
     windowManager = {
        i3.enable = true;
     };
     
     displayManager = {
        autoLogin = { 
          enable = true; 
          user = "yuno"; 
        };
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
      kochi-substitute
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
    gimp
    xfontsel
    vimHugeX
    evince
  ];
}
