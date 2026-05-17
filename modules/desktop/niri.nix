{ self, inputs, ... }: {
        flake.nixosModules.desktopNiri = { pkgs, lib, ... }: {
                imports = [ inputs.niri.nixosModules.niri ];
		
		programs.niri = {
			enable = true;
			package = pkgs.niri;
		};
		niri-flake.cache.enable = false;
        environment.systemPackages = [ pkgs.xwayland-satellite ];
		environment.sessionVariables = {
			QT_QPA_PLATFORM  = "wayland";
			NIXOS_OZONE_WL = "1";
		};
        };
}
