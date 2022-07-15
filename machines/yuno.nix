{ config, pkgs, lib, ... }:

let secrets = import ../secrets.nix;
in
{ 
  imports = [];

  networking = {
    hostName = "yuno";
    hostId = "95ec4474";
    nameservers = [ "8.8.8.8" ];
    firewall.interfaces.eno1 = {
      allowedUDPPorts = [ 53 6600 ]; # DNS, mpd
      allowedTCPPorts = [ 53 6600 ];
    };
  };

  hardware.pulseaudio.extraConfig = ''
    load-module module-alsa-sink device=hw:1,0
    load-module module-combine-sink sink_name=combined
    set-default-sink combined
  '';

  fileSystems = let attrs = (lib.attrsets.genAttrs secrets.samba.shares (name:
    {
      device = "//${secrets.samba.ip}/${name}";
      fsType = "cifs";
      options =
        let automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
        in ["${automount_opts},credentials=/etc/smb-secrets,uid=${toString config.users.users.yuno.uid},gid=${toString config.users.groups.users.gid}"];
    }));
    smbShares = lib.attrsets.mapAttrs' (name: value: lib.attrsets.nameValuePair ("/mnt/nazuna/" + name) value) attrs;
    in
      lib.trivial.mergeAttrs smbShares {
          "/mnt/win" = { device = "/dev/disk/by-label/yuno-disku";
                         fsType = "ntfs";
        };
      };


  environment.etc = {
    smb-secrets = {
      text = secrets.samba.smb-secrets;
      mode = "0400";
    };
  };
}

