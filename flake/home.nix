{ system, nixpkgs, nurpkgs, home-manager, nix-doom-emacs, ... }:

let
  mkHome = username: (
    let conf = (import ../home/${username}.nix {
      inherit nur pkgs nix-doom-emacs;
      inherit (pkgs) config lib stdenv;
    });

    homeDirectory = "/home/${username}";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      config.xdg.configHome = "${homeDirectory}/.config";
      overlays = [ nurpkgs.overlay ];
    };

    nur = import nurpkgs {
      inherit pkgs;
      nurpkgs = pkgs;
    };

    in 

    home-manager.lib.homeManagerConfiguration rec {
      inherit pkgs;
      modules = [
        conf
        {
          home = {
            inherit username homeDirectory;
            stateVersion = "22.11";
          };
        }
      ];
    });
in
  {
    yuno = mkHome "yuno";
  }
