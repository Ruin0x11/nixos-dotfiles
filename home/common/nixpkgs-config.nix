{ pkgs, ... }:

let 
  nurTarball = fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz";
in
{
  allowUnfree = true;
  packageOverrides = pkgs: {
    nur = import nurTarball {
      inherit pkgs;
    };
  };
}
