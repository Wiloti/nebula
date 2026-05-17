{ self, inputs, ... }: {
	flake.nixosModules.voidBoot = { pkgs, lib, ... }: {
		boot = {
			loader = {
				timeout = 10;
				efi = {
					canTouchEfiVariables = true;
					efiSysMountPoint = "/boot";
				};
				grub = {
					enable = true;
					configurationLimit = 10;
					configurationName = "void";
					efiSupport = true;
					devices = [ "nodev" ];
					useOSProber = true;
					font = "${self}/modules/themes/grub/font.ttf";
					fontSize = 18;
					theme = "${self}/modules/themes/grub";
				};
			};

			initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
			kernel.sysctl."kernel.sysrq" = 1;
			kernelPackages = pkgs.linuxPackages_zen;
			kernelModules = [ "kvm-amd" ];
			kernelParams = [ "quiet" "splash" ];
			blacklistedKernelModules = [ "nouveau" ];
			supportedFilesystems = [ "ntfs" ];
			tmp.cleanOnBoot = true;
		};
	};
}
