{ nur, pkgs, config, lib, stdenv, nix-doom-emacs, ... }:

let username = "yuno";
    homeDirectory = "/home/${username}";
in
{
  imports = [
    nix-doom-emacs.hmModule

    ./common.nix
    ./yuno/programs/firefox.nix
  ];

  home = {
    packages = with pkgs; [
      dotnetCorePackages.runtime_6_0
      dotnet-sdk_6
      msbuild
      jetbrains.rider
      autocutsel
    ];
    pointerCursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      x11.enable = true;
    };
  };

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    oh-my-zsh.enable = true;
    oh-my-zsh.plugins = [ "git" ];
    oh-my-zsh.theme = "frisk";
    enableSyntaxHighlighting = true;
    history = {
      extended = true;
    };

    initExtra = ''
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killedbindkey -v
setopt INC_APPEND_HISTORY
unsetopt HIST_VERIFY
setopt AUTO_MENU           # Show completion menu on a succesive tab press.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH    # If completed parameter is a directory, add a trailing slash.
unsetopt MENU_COMPLETE     # Do not autoselect the first completion entry.
unsetopt LIST_AMBIGUOUS
unsetopt NOMATCH
setopt HIST_IGNORE_SPACE
setopt RM_STAR_WAIT

setopt AUTO_PUSHD                  # pushes the old directory onto the stack
setopt PUSHD_MINUS                 # exchange the meanings of '+' and '-'
setopt CDABLE_VARS                 # expand the expression (allows 'cd -2/tmp')

source "${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh"

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
      '';

    shellAliases = {
      pf = "nix search nixpkgs";
      pi = "nix-shell -p";
      pq = "nix-build '<nixpkgs>' --no-build-output -A";
      pF = "nix-env -f '<nixpkgs>' -qaP";
      nr = "sudo nixos-rebuild switch --flake /etc/nixos/#${username}";
      ns = "nix-shell";
      hmr = "home-manager switch --flake /etc/nixos/#${username}";
      sv = "sudo vim";
      ta = "tmux a";
      s = "sudo $(fc -ln -1)";
      df = "df -h";
      rga = "rg --no-ignore --hidden --follow";
      fda = "fd --no-ignore --no-ignore-vcs --hidden";
      git = "hub";
      sy = "sudo systemctl";
      usy = "systemctl --user";
      sjc = "sudo journalctl";

      # This allows testing home/doom.d without needing to do a full rebuild every time
      # config.el is changed.
      doom-emacs = "DOOMDIR=/etc/nixos/home/${username}/doom.d emacs --debug-init";
    };
  };

  xresources.properties = {
    "*foreground" = "#D7D0C7";
    "*background" = "#151515";

    #!black
    #! *color0:     #AF875F
    #! *color8:     #AF875F
    "*color0" = "#101010";
    "*color8" = "#404040";
    #!red
    "*color1" = "#E84F4F";
    "*color9" = "#D23D3D";
    #!green
    "*color2" = "#B8D68C";
    "*color10" = "#A0CF5D";
    #!yellow
    "*color3" = "#E1AA5D";
    "*color11" = "#F39D21";
    #!blue
    "*color4" = "#7DC1CF";
    "*color12" = "#4E9FB1";
    #!magenta
    "*color5" = "#9B64FB";
    "*color13" = "#8542FF";
    #!cyan
    "*color6" = "#6D878D";
    "*color14" = "#42717B";
    #!white
    "*color7" = "#dddddd";
    "*color15" = "#dddddd";

    "URxvt*borderColor" = "#151515";
    "URxvt*colorBD" = "#ffffff";
    "URxvt*cursorColor" = "#ff8939";
    "URxvt*cursorColor2" = "#151515";
    "URxvt.perl-ext-common" = "selection-to-clipboard";
  };

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = {
      focus.followMouse = false;
      #gaps = {
      #  inner = 32;
      #  outer = 0;
      #};
      window = {
        hideEdgeBorders = "vertical";
        commands = [
          { criteria = { class = "mpv"; }; command = "fullscreen enable, border pixel 0"; }
          { criteria = { title = "Android Emulator"; }; command = "floating enable"; }
          { criteria = { window_role = "browser|GtkFileChooserDialog"; }; command = "resize set 800 600, move position center"; }
        ];
      };
      focus = {
        newWindow = "smart";
      };
      assigns = {
        "1: main" = [{ class = "emacs"; }];
        "2: web" = [{ class = "Firefox"; }];
      };
      colors = {
        background = "#e0eaf9";
        # focused		 		#271f17 #271f17 #AAAAAA  #AAAAAA   #271f17
        # focusedInactive 	#21211d #1d2121 #a1a1a1  #484e50   #1d2121
        # unfocused        	#333333 #222222 #888888  #292d2e   #222222
        # urgent   			#4a4b4c #4a4b4c #AAAAAA  #AAAAAA   #4a4c4b
        # placeholder      	#000000 #0c0c0c #AAAAAA  #000000   #0c0c0c
      };
      bars = [{
        command = "i3bar -t";
        fonts = {
          names = [ "DejaVu Sans Mono" "FontAwesome5Free" ];
          size = 11.0;
        };
        colors = {
          background = "#202020";
          statusline = "#d0e1d4";
          separator = "#c1d0c1";
          focusedWorkspace  = { border = "#31302d"; background = "#31302d"; text = "#fff2ce"; };
          inactiveWorkspace = { border = "#64635f"; background = "#64635f"; text = "#28220b"; };
          urgentWorkspace   = { border = "#2e394a"; background = "#2e394a"; text = "#e7dfd9"; };
        };
      }];
      startup = [
        { command = "emacs"; }
        { command = "sleep 5 && firefox"; } # can't connect to any webpages if started before network is up
        { command = "autocutsel -selection PRIMARY -fork &"; }
      ];

      modifier = "Mod4";
      keybindings = let mod = "Mod4"; in {
        "${mod}+Return" = "exec i3-sensible-terminal";
        "${mod}+Shift+c" = "kill";
        "${mod}+r" = "exec dmenu_run";
        "${mod}+d" = "exec --no-startup-id i3-dmenu-desktop";
        "${mod}+1" = "workspace $ws1";
        "${mod}+2" = "workspace $ws2";
        "${mod}+3" = "workspace $ws3";
        "${mod}+4" = "workspace $ws4";
        "${mod}+5" = "workspace $ws5";
        "${mod}+6" = "workspace $ws6";
        "${mod}+7" = "workspace $ws7";
        "${mod}+8" = "workspace $ws8";
        "${mod}+9" = "workspace $ws9";
        "${mod}+0" = "workspace $ws10";
        "${mod}+Shift+1" = "move container to workspace $ws1";
        "${mod}+Shift+2" = "move container to workspace $ws2";
        "${mod}+Shift+3" = "move container to workspace $ws3";
        "${mod}+Shift+4" = "move container to workspace $ws4";
        "${mod}+Shift+5" = "move container to workspace $ws5";
        "${mod}+Shift+6" = "move container to workspace $ws6";
        "${mod}+Shift+7" = "move container to workspace $ws7";
        "${mod}+Shift+8" = "move container to workspace $ws8";
        "${mod}+Shift+9" = "move container to workspace $ws9";
        "${mod}+Shift+0" = "move container to workspace $ws10";
        "${mod}+Shift+space" = "floating toggle";
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";
        "${mod}+shift+h" = "move left";
        "${mod}+shift+j" = "move down";
        "${mod}+shift+k" = "move up";
        "${mod}+shift+l" = "move right";
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";
        "${mod}+shift+Left" = "move left";
        "${mod}+shift+Down" = "move down";
        "${mod}+shift+Up" = "move up";
        "${mod}+shift+Right" = "move right";
        "${mod}+shift+r" = "restart";
        "${mod}+q" = "layout splith";
        "${mod}+w" = "layout splitv";
        "${mod}+e" = "layout default";
        "${mod}+v" = "split vertical";
        "${mod}+o" = "split horizontal";
        "${mod}+p" = "split toggle";
        "${mod}+f" = "fullscreen toggle";
        "${mod}+i" = "exec surf google.com";
        "${mod}+s" = "exec scrot -e 'mv $f \"${homeDirectory}/Pictures/scrots\"'";
        "${mod}+z" = "exec mouse-switchscreen";
        "${mod}+b" = "exec urxvt-browser";
        "${mod}+Next" = "exec amixer set Master 5%-";
        "${mod}+Prior" = "exec amixer set Master 5%+";
        "${mod}+Alt_R" = "focus left";
        "${mod}+Super_R" = "focus down";
        "${mod}+Print" = "focus up";
      };
    };

    extraConfig = ''
floating_modifier Mod4

# Borders
new_window pixel 4
new_float pixel 4

popup_during_fullscreen ignore
'';
  };

  programs.i3status-rust = {
    enable = true;
  };

  services.grobi = {
    enable = true;
    rules = [{
      name = "ouchi";
      outputs_connected = [ "DVI-D-0" "DP-4" ];
      configure_row = [ "DP-4" "DVI-D-0" ];
      primary = "DP-4";
      atomic = true;
      execute_after = [
        "${pkgs.i3-gaps}/bin/i3-msg restart"
      ];
    }];
  };

  programs.urxvt = {
    enable = true;
    fonts = [ "xft:Droid Sans Mono:size=12" ];
  };

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./yuno/files/doom.d;
  };

  programs.vim = {
    enable = true;
    extraConfig = builtins.readFile ./yuno/files/vimrc;
    plugins = with pkgs.vimPlugins; [
      base16-vim
      ctrlp
      # vim-distinguished
      nerdtree
      syntastic
      vim-multiple-cursors
      vim-commentary
      vim-fugitive
      vim-repeat
      vim-surround
      align
      vim-misc
      # vim-session
      vim-airline
    ];
  };

  programs.git = {
    enable = true;
    userName = "Ruin0x11";
    userEmail = "nonbirithm@fastmail.com";
  };

  services.mpd = {
    enable = true;

    extraConfig = ''
       audio_buffer_size   "20480"
       buffer_before_play  "30%"
       audio_output {
         type "pulse"
         name "Pulseaudio"
       }
      '';

    network.listenAddress = "any";
    musicDirectory = "${homeDirectory}/Music";
  };

  programs.mpv = {
    enable = true;
    bindings = {
      RIGHT = "seek 5 exact";
      LEFT = "seek -5 exact";
      FORWARD = "seek 60";
      REWIND = "seek 60";
      XF86_NEXT = "seek 5 exact";
      XF86_PREV = "seek -5 exact";
      "0x1008FF14" = "cycle pause";
      STOP = "quit_watch_later";
      MUTE = "cycle sid";
      "Shift+UP" = "add sub-scale .1";
      "Shift+DOWN" = "add sub-scale -.1";
      "Shift+RIGHT" = "add sub-delay .1";
      "Shift+LEFT" = "add sub-delay -.1";
      VOLUME_UP = "add volume 5";
      VOLUME_DOWN = "add volume -5";
      "Ctrl+t"  = "show-text \${time-pos}/\${duration}";
    };
    config = {
      ao = "pulse";
      video-sync = "display-resample";

      #interpolation = true;
      cscale = "ewa_lanczossharp";
      scale = "ewa_lanczossharp";
      scale-antiring = 0.7;

      fs = true;
      demuxer-mkv-subtitle-preroll = true;
      alang = "jpn,ja,eng,en";
      slang = "jpn,ja,eng,en";
      border = false;
      osd-level = 0;
      sub = false;
      osc = false;
      cursor-autohide = "always";
      sub-scale = .4;
      audio-display = false;
      display-tags = "Artist,Album,Comment,Composer,Genre,Performer,Title,Track,icy-title,UNSYNCEDLYRICS";
      screenshot-format = "png";
      screenshot-template = "./%%%%%f%%%%%P%%%%";
      screenshot-directory = "${homeDirectory}/Pictures/mpv";
      load-scripts = "yes";
      stop-screensaver = true;
      af-add = "scaletempo";
    };
  };

  programs.rbw = {
    enable = true;
    settings = {
      email = "nonbirithm@fastmail.com";
    };
  };

  gtk.gtk3.extraConfig = {
    # enable prefers-reduced-motion in firefox
    gtk-enable-animations = false;
  };
}
