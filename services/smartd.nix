{ config, pkgs, ... }:

{
  services.smartd = {
    enable = true;
    notifications = {
      mail = {
        enable = true;
        sender = "nonbirithm@fastmail.com";
        recipient = "nonbirithm@fastmail.com";
        mailer = "${pkgs.msmtp}/bin/msmtp";
      };
      test = true;
    };
  };
}
