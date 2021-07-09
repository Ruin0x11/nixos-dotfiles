{ config, lib, pkgs, ... }:
with lib;

let secrets = import ../secrets.nix;
in
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nori = {
    isNormalUser = true;
    extraGroups = [
       "audio"
       "video"
       "wheel" # Enable ‘sudo’ for the user.
       "docker"
    ];

    uid = 1000;
    createHome = true;
    home = "/home/nori";
    shell = "/run/current-system/sw/bin/zsh";

    openssh.authorizedKeys.keys = secrets.sshKeys.nori;
  };

}
