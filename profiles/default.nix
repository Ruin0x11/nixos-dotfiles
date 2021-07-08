{ config, pkgs, nixpkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # unstable.home-manager
    aspell
    aria2
    aspellDicts.en
    beets
    bfg-repo-cleaner
    bind # nslookup, dig
    curl
    dos2unix
    elinks
    fd
    file
    gitAndTools.gitFull
    gnumake
    gnupg
    htop
    hub 
    iotop
    lsof
    mailutils
    mpc_cli
    msmtp
    ncdu
    ncmpcpp
    ncurses
    nix-prefetch-scripts
    nmap
    openssl
    p7zip
    pciutils
    pmutils
    psmisc
    ranger
    ripgrep
    rxvt_unicode.terminfo
    sd
    stdenv
    strace
    sudo
    sysstat
    tcpdump
    tmux
    tree
    unrar 
    unzip
    usbutils
    vim 
    wget
    wget
    youtube-dl
    zip
    zsh
    zsh-history-substring-search
  ];

  programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      ohMyZsh.enable = true;
      ohMyZsh.plugins = [ "git" ];
      ohMyZsh.theme = "frisk";
      syntaxHighlighting.enable = true;
      interactiveShellInit = ''
        source "${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
      '';
  };
}
