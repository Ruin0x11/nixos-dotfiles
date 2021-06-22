{ config, pkgs, nixpkgs, ... }:

{
   imports = [];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # unstable.home-manager
    aspell
    aria2
    aspellDicts.en
    backblaze-b2
    beets
    bfg-repo-cleaner
    bind # nslookup, dig
    curl
    dhall
    dhall-json
    docker
    docker-compose
    dos2unix
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
    mpc_cli
    ncmpcpp
    ncurses
    nix-prefetch-scripts
    nmap
    openssl
    p7zip
    pciutils
    pmutils
    psmisc
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
