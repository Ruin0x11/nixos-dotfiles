{ config, pkgs, ... }:

let
  cp = pkgs.lib.callPackageWith (pkgs // pkgs.xorg // pkgs.libsForQt5);
in
{
  imports = [ ./graphical.nix ../packages/desktop-managers/rxvt-unicode.nix ];

  environment.variables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };
  services.xserver = {
    dpi = 180;
    displayManager = {
      autoLogin = { 
        enable = true; 
        user = "nori"; 
      };
      sessionCommands = ''
        ${pkgs.xorg.xrdb}/bin/xrdb -merge <<EOF
URxvt.letterSpace: -1
URxvt.scrollBar:    false

URxvt.font: xft:Hack:pixelsize=36
URxvt.boldFont: xft:Hack:style=bold:pixelsize=36

*foreground: #D7D0C7
*background: #151515

!black
*color0:     #101010
*color8:     #404040
!red
*color1:     #E84F4F
*color9:     #D23D3D
!green
*color2:     #B8D68C
*color10:    #A0CF5D
!yellow
*color3:     #E1AA5D
*color11:    #F39D21
!blue
*color4:     #7DC1CF
*color12:    #4E9FB1
!magenta
*color5:     #9B64FB
*color13:    #8542FF
!cyan
*color6:     #6D878D
*color14:    #42717B
!white
*color7:     #dddddd
*color15:    #dddddd

URxvt*borderColor:        #151515
URxvt*colorBD:            #ffffff
URxvt*cursorColor:        #ff8939
URxvt*cursorColor2:       #151515
EOF
      '';
    };
    desktopManager = {
      rxvt-unicode = {
        enable = true;
        command = "${pkgs.zsh}/bin/zsh -c \"${pkgs.ranger}/bin/ranger /mnt/hibiki/TV\"";
      };
    };
    windowManager.dwm.enable = true;
  };

  hardware.pulseaudio.extraConfig = ''
    load-module module-alsa-sink device=hw:1,7
    load-module module-combine-sink sink_name=combined
    set-default-sink combined
  '';
}
