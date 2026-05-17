{ self, inputs, ... }: {
        flake.nixosModules.commonLocale = { pkgs, lib, ... }: {
		time = {
			timeZone = "Europe/Paris";
			hardwareClockInLocalTime = true;
		};

		i18n = {
			defaultLocale = "en_US.UTF-8";
			extraLocales = [
				"fr_FR.UTF-8/UTF-8"
				"ja_JP.UTF-8/UTF-8"
				"zh_CN.UTF-8/UTF-8"
			];
			extraLocaleSettings = {
				LC_PAPER = "fr_FR.UTF-8";
				LC_NUMERIC = "fr_FR.UTF-8";
				LC_MONETARY = "fr_FR.UTF-8";
				LC_MEASUREMENT = "fr_FR.UTF-8";
			};
		};

                fonts = {
                        packages = with pkgs; [
                                inter
                                noto-fonts
                                noto-fonts-cjk-sans
                                noto-fonts-cjk-serif
                                noto-fonts-color-emoji
                                nerd-fonts.jetbrains-mono
                                nerd-fonts.iosevka-term
                        ];
                };
        };
}
