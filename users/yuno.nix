{ config, lib, pkgs, ... }:
with lib;

let secrets = import ../secrets.nix;
in
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yuno = {
    isNormalUser = true;
    extraGroups = [
       "audio"
       "video"
       "wheel" # Enable ‘sudo’ for the user.
    ];

    uid = 1000;
    createHome = true;
    home = "/home/yuno/";
    shell = "/run/current-system/sw/bin/zsh";

    openssh.authorizedKeys.keys = secrets.sshKeys.yuno;
  };
}
