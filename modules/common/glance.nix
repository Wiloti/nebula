{  inputs, ... }: {
	flake.nixosModules.commonGlance = { pkgs, lib, ... }: {
		imports = [ inputs.home-manager.nixosModules.home-manager ];

		home-manager = {
			useGlobalPkgs = true;
			useUserPackages = true;
		};
	};
}
