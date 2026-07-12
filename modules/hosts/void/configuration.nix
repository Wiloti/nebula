{ self, ... }: {
	flake.nixosModules.voidConfiguration = { config, pkgs, lib, ... }: {
		imports = [
			self.nixosModules.voidBoot
			self.nixosModules.voidHardware
			self.nixosModules.voidUsers
			self.nixosModules.voidNetworking
			self.nixosModules.voidGraphic
			self.nixosModules.voidNiri
            self.nixosModules.voidTransmission
            self.nixosModules.voidGaming
            self.nixosModules.voidVirtualization

			self.nixosModules.commonSecurity
			self.nixosModules.commonAudio
			self.nixosModules.commonLocale
			self.nixosModules.commonHomeManager
			self.nixosModules.commonGit
			self.nixosModules.commonGhostty
			self.nixosModules.commonZsh

			self.nixosModules.desktopNiri
			self.nixosModules.desktopSddm

			self.nixosModules.wilotiHomeManager
			self.nixosModules.wilotiNiri
            self.nixosModules.wilotiNoctalia
			self.nixosModules.wilotiGit
			self.nixosModules.wilotiGhostty
			self.nixosModules.wilotiZsh
			self.nixosModules.wilotiTmux
			self.nixosModules.wilotiNvim
            self.nixosModules.wilotiSsh
			self.nixosModules.wilotiStarship
			self.nixosModules.wilotiZenBrowser
            self.nixosModules.wilotiMpd
            self.nixosModules.wilotiMpv
            self.nixosModules.wilotiMedia
            self.nixosModules.wilotiBat
            self.nixosModules.wilotiDirenv
		];

		environment.systemPackages = with pkgs; [
			fd
			jq
			vim
			tree
			file
			btop
			p7zip
            ffmpeg
			ripgrep
			firefox
			zathura
            nautilus
			binutils
            exiftool
            adw-gtk3
            nwg-look
			powershell
            obs-studio
            fontpreview
            wl-clipboard
            nvtopPackages.nvidia
			nix-prefetch-github
		];

		nix.settings = {
            experimental-features = [ "nix-command" "flakes" ];
            extra-substituters = [ "https://noctalia.cachix.org" ];
            extra-trusted-public-keys = [
                "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
            ];
        };
		nixpkgs.config.allowUnfree = true;
        nix.gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };
        services.openssh = {
            enable =true;
            settings = {
                PermitRootLogin = "no";
            };
        };

		system.stateVersion = "25.11";
	};
}
