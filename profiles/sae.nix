{ config, pkgs, nixpkgs, ... }:

let
  unstable = import (fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {
      overlays = [
        (import (builtins.fetchTarball {
          url =
            "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
        }))
      ];
    };

  my-emacs = (pkgs.emacsPackagesGen unstable.emacsGcc).emacsWithPackages
    (epkgs: [ ]);
in
{
  imports = [ ./graphical.nix ../cachix.nix ];

  #services.emacs.package = pkgs.emacsPgtkGcc;

  environment.systemPackages = with pkgs; [
    my-emacs
    love_11
    wpa_supplicant_gui
    cachix
    luajit
    luajitPackages.luacheck
    vips
  ];
}
