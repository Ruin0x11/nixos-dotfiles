# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ata_piix" "ahci" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/28223937-e3ef-4a3e-a6f8-dfebd4d86a49";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/057de101-31b8-4227-9cc4-5606c0b8d62b"; }
    ];

  hardware.enableRedistributableFirmware = true;
}
