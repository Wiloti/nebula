{self, inputs, ... }: {
	flake.nixosModules.commonSecurity = {pkgs, lib, ... }: {
		security = {
			rtkit.enable = true;
            #polkit.enable = true;
			sudo-rs.enable = false;
			sudo.enable = true;
			protectKernelImage = true;
			allowUserNamespaces = true;
		};
	};
}
