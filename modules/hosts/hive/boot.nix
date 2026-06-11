{ ... }: {
  flake.nixosModules.hiveBoot = { pkgs, lib, ... }: {
    boot = {
      loader = {
        systemd-boot = {
          enable = true;
          configurationLimit = 10;
        };
        efi.canTouchEfiVariables = true;
        timeout = 5;
      };

      resumeDevice = "/dev/mapper/cryptswap";

      initrd.availableKernelModules = [
        "nvme" "xhci_pci" "usb_storage" "sd_mod"
      ];
      kernelPackages = pkgs.linuxPackages_zen;
      kernelParams = [ "quiet" "splash" "resume=/dev/mapper/cryptswap" ];
      tmp.cleanOnBoot = true;
    };
  };
}
