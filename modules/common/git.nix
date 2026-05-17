{ self, inputs, ... }: {
	flake.nixosModules.commonGit = { pkgs, lib, ... }: {
		programs.git = {
			enable = true;
			lfs.enable = true;
		};
	};
}
