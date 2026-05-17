{ self, inputs, ... }: {
	flake.nixosModules.commonAudio = { pkgs, lib, ... }: {
		services.pipewire = {
			enable = true;
			jack.enable = true;

			alsa = {
				enable = true;
				support32Bit = true;
			};

			pulse = {
				enable =true;
			};
		};

		services.pulseaudio.enable = false;
	};
}
