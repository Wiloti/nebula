{ inputs, ... }: {
  flake.nixosModules.hiveHardware = { config, lib, pkgs, modulesPath, ... }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
      inputs.nixos-hardware.nixosModules.lenovo-thinkpad-l13-yoga
    ];

    boot.initrd.availableKernelModules = [
      "nvme" "xhci_pci" "usb_storage" "sd_mod"
    ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "/dev/mapper/cryptroot";
      fsType = "ext4";
    };

    boot.initrd.luks.devices."cryptroot" = {
      device = "/dev/disk/by-uuid/998d9f24-17c5-4b97-8c13-6c04d34930a3";
      allowDiscards = true;
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/2AF3-A397";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

    swapDevices = [ { device = "/dev/mapper/cryptswap"; } ];

    boot.initrd.luks.devices."cryptswap" = {
      device = "/dev/disk/by-uuid/5d8a40e4-1d21-402a-abb3-f28e44580a6a";
      keyFile = "/dev/urandom";
      keyFileSize = 4096;
    };

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
