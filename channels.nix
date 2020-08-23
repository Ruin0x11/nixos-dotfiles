{ config, lib, pkgs, ... }:

let 
   homeManagerTarball = fetchTarball
      https://github.com/rycee/home-manager/archive/release-20.03.tar.gz;
in
{
   nixpkgs.config = {
      packageOverrides = pkgs: {
        unstable = import homeManagerTarball {};
      };
   };
}
