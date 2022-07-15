{ lib, inputs, system, ... }:

{
  yuno = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
      ../configuration.nix
      ../machines/yuno.nix
      ../users/yuno.nix
    ];
  };
}
