{ inputs, ... }: {
	flake.nixosModules.wilotiZenBrowser = { pkgs, lib, ... }: {
		home-manager.users.wiloti = {
			imports = [ inputs.zen-browser.homeModules.twilight ];
			programs.zen-browser = {
				enable = true;
                policies = {
                    AutofillCreditCardEnabled = false;
                    DisableAppUpdate = true;
                    DisableFeedbackCommands = true;
                    DisableFirefoxStudies = true;
                    DisablePocket = true;
                    DisableTelemetry = true;
                    DontCheckDefaultBrowser = true;
                    NoDefaultBookmarks = true;
                    OfferToSaveLogins = false;
                    EnableTrackingProtection = {
                        Value = true;
                        Locked = true;
                        Cryptomining = true;
                        FingerPrinting = true;
                    };

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
                        engines = {
                            github = {
                                name = "Github Search";
                                urls = [
                                    {
                                        template = "https://github.com/search?q={searchTerms}";
                                    }
                                ];
                                definedAliases = ["@gh"];
                            };
                        };
					};
                    mods = [
                        "e122b5d9-d385-4bf8-9971-e137809097d0" # No Top Sites
                        "253a3a74-0cc4-47b7-8b82-996a64f030d5" # Floating History
                        "4ab93b88-151c-451b-a1b7-a1e0e28fa7f8" # No Sidebar Scrollbar
                        "7190e4e9-bead-4b40-8f57-95d852ddc941" # Tab title fixes
                        "803c7895-b39b-458e-84f8-a521f4d7a064" # Hide Inactive Workspaces
                        "906c6915-5677-48ff-9bfc-096a02a72379" # Floating Status Bar
                        "a6335949-4465-4b71-926c-4a52d34bc9c0" # Better Find bar
                        "1b88a6d1-d931-45e8-b6c3-bfdca2c7e9d6" # Remove Tab X
                    ];
				};
			};
		};
	};
}
