{ config, pkgs, ... }:

{
   imports = [
   
   ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    vim 
    emacs
    aspell
    aspellDicts.en
    bind # nslookup, dig
    curl
    dos2unix
    duplicity
    elinks
    file
    gitAndTools.gitFull
    gnumake
    gnupg
    unstable.home-manager
    htop
    lsof
    ncurses
    nix-prefetch-scripts
    nmap
    openssl
    p7zip
    pciutils
    pmutils
    psmisc
    stdenv
    strace
    sudo
    sysstat
    tcpdump
    tmux
    tree
    unzip
    usbutils
    wget
    youtube-dl
    zip
    zsh
    unrar 
  ];

  programs.zsh.enable = true;
}
