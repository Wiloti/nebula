{ self, inputs, ... }: {
	flake.nixosModules.commonZsh = { pkgs, lib, ... }: {
		programs.zsh.enable = true;
	};
}
