{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.xserver.desktopManager.rxvt-unicode;
  xSessionEnabled = config.services.xserver.enable;
in
{
  options = {
    services.xserver.desktopManager.rxvt-unicode.enable = mkOption {
      type = types.bool;
      default = (versionOlder config.system.stateVersion "19.09") && xSessionEnabled;
      defaultText = if versionOlder config.system.stateVersion "19.09" then "config.services.rxvt-unicode.enable" else "false";
      description = "Enable a urxvt terminal as a desktop manager.";
    };
    services.xserver.desktopManager.rxvt-unicode.command = mkOption {
      type = types.nullOr types.str;
      default = null;
      defaultText = "null";
      description = "Command to run.";
    };
  };

  config = mkIf cfg.enable {
    services.xserver.desktopManager.session = singleton
      { name = "rxvt-unicode";
        start = ''
          ${pkgs.rxvt-unicode}/bin/urxvt ${optionalString (cfg.command != null) ("-e ${cfg.command}")} &
          waitPID=$!
        '';
      };

    environment.systemPackages = [ pkgs.rxvt-unicode ];
  };
}
