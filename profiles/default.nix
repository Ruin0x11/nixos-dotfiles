{ config, pkgs, nixpkgs, ... }:

{
  imports = [];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
    aspell
    aria2
    aspellDicts.en
    atop
    backblaze-b2
    beets
    bfg-repo-cleaner
    bind # nslookup, dig
    curl
    dos2unix
    dstat
    duplicity
    elinks
    emacs
    fd
    file
    gdrive
    gitAndTools.gitFull
    gnumake
    gnupg
    htop
    hub 
    iotop
    lsof
    mailutils
    megatools
    mpc_cli
    msmtp
    ncdu
    ncmpcpp
    ncurses
    nix-prefetch-scripts
    nmap
    openssl
    p7zip
    pamix
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
}
