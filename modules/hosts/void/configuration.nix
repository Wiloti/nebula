{ self, inputs, ... }: {
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
		];

		environment.systemPackages = with pkgs; [
			fd
			jq
			vim
			tree
			file
			btop
			p7zip
            nvtopPackages.nvidia
            ffmpeg
			ripgrep
			firefox
			zathura
            nautilus
			binutils
            exiftool
			powershell
            wl-clipboard
            fontpreview
			nix-prefetch-github
            adw-gtk3
            nwg-look
		];

		nix.settings.experimental-features = [ "nix-command" "flakes" ];
		nixpkgs.config.allowUnfree = true;
        nix.gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };
		system.stateVersion = "25.11";
	};
}
