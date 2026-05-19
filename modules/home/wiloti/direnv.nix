{ ... }: {
	flake.nixosModules.wilotiDirenv = { pkgs, lib, ... }: {
		home-manager.users.wiloti = {
            programs.direnv = {
                enable =true;
                enableZshIntegration = true;
                nix-direnv.enable = true;
            };
        };
    };
}
