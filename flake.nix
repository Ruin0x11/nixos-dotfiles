{
  description = "NixOS configuration";

  inputs = {
      nixpkgs.url = github:NixOS/nixpkgs;
      nurpkgs = {
        url = github:nix-community/NUR;
        inputs.nixpkgs.follows = "nixpkgs";
      };
      home-manager = {
        url = github:nix-community/home-manager;
        inputs.nixpkgs.follows = "nixpkgs";
      };
      nix-doom-emacs = {
        url = github:nix-community/nix-doom-emacs;
        inputs.nixpkgs.follows = "nixpkgs";
      };
  };

  outputs = inputs @ { self, nixpkgs, nurpkgs, home-manager, nix-doom-emacs }: 
    let system = "x86_64-linux";
    in
    {
        homeConfigurations = import ./flake/home.nix {
          inherit system nixpkgs nurpkgs home-manager nix-doom-emacs;
        };
        nixosConfigurations = import ./flake/nixos.nix {
          inherit (nixpkgs) lib;
          inherit inputs system;
        };
    };
}
