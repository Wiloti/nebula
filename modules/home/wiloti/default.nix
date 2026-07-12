{ inputs, ... }: {
	flake.nixosModules.wilotiHomeManager = { pkgs, lib, ... }: {
		home-manager.users.wiloti = {
			home.username = "wiloti";
			home.homeDirectory = "/home/wiloti";
			home.pointerCursor = {
                enable = true;
				gtk.enable = true;
				package = pkgs.bibata-cursors;
				name = "Bibata-Modern-Classic";
				size = 20;
			};
			home.packages = with pkgs; [
				grim
                slurp
                satty
                inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
                signal-desktop
                obsidian
			];
            home.file.".ssh/sockets/.keep" = {
                text = "";
            };
			home.stateVersion = "25.11";
		};
	};
}
