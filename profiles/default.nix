{ config, pkgs, nixpkgs, ... }:

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
    fd
    file
    gitAndTools.gitFull
    gnumake
    gnupg
    # unstable.home-manager
    htop
    hub 
    lsof
    ncurses
    ncmpcpp
    nix-prefetch-scripts
    nmap
    openssl
    p7zip
    pciutils
    pmutils
    psmisc
    ripgrep
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
    zsh-history-substring-search
    unrar 
    docker
    docker-compose
    rxvt_unicode.terminfo
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
