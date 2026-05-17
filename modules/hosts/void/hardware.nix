{ self, inputs, ... }: {
	flake.nixosModules.voidHardware = { config, lib, pkgs, modulesPath, ... }: {
		imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

		services.fstrim.enable = true;

		fileSystems."/" = {
			device = "/dev/disk/by-uuid/6d87df06-3863-41e3-8d22-a0e308a95508";
			fsType = "ext4";
			options = [ "noatime" ];
		};

		fileSystems."/boot" = {
			device = "/dev/disk/by-uuid/C56F-1A41";
			fsType = "vfat";
			options = [ "fmask=0022" "dmask=0022" ];
		};


		fileSystems."/home/wiloti/media" = {
			device = "/dev/disk/by-uuid/4263e762-84f7-4a07-a805-00e2f2efcaa4";
			fsType = "btrfs";
			options = [ "compress=zstd" "noatime" ];
		};

		fileSystems."/home/wiloti/games" = {
			device = "/dev/disk/by-uuid/1a83a270-e061-44cf-b296-551a288785a6";
			fsType = "btrfs";
			options = [ "compress=zstd" "noatime" "exec" ];
		};

		fileSystems."/home/wiloti/vms" = {
			device = "/dev/disk/by-uuid/21051251-df0e-484d-a84a-4e38b699c278";
			fsType = "btrfs";
			options = [ "compress=zstd" "noatime" ];
		};

		systemd.tmpfiles.rules = [
			"d /home/wiloti/vms 0755 wiloti users -" # run once "sudo chattr +C /home/wiloti/vms"
			"d /home/wiloti/media 0755 wiloti users -"
			"d /home/wiloti/games 0755 wiloti users -"
		];

		nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
		hardware.enableRedistributableFirmware = true;
		hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
	};
}
