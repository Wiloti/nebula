{ self, inputs, ... }: {
	flake.nixosModules.wilotiZenBrowser = { pkgs, lib, ... }: {
		home-manager.users.wiloti = {
			imports = [ inputs.zen-browser.homeModules.twilight ];
			programs.zen-browser = {
				enable = true;
                policies = {
                    ExtensionSettings = {
                        "passbolt@passbolt.com" = {
                            install_url = "https://addons.mozilla.org/firefox/downloads/latest/passbolt/latest.xpi";
                            installation_mode = "force_installed";
                        };
                        "uBlock0@raymondhill.net" = {
                            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                            installation_mode = "force_installed";
                        };
                    };

                };
				profiles.wiloti = {
					isDefault = true;
					search = {
						force = true;
						default = "ddg";
					};
				};
			};
		};
	};
}
