{ self, inputs, ... }: {
	flake.nixosModules.wilotiGit = { pkgs, lib, ... }: {
		home-manager.users.wiloti = {
			programs.git = {
				enable = true;
				package = null;
				settings = {
					user.name = "Wiloti";
					user.email = "security@wiloti.fr";
					init.defaultBranch = "main";
                    pull.rebase = true;
                    rebase.autoStash = true;
                    gpg.format = "ssh";
                    user.signingKey = "~/.ssh/id_ed25519.pub";
                    commit.gpgSign = true;
                    tag.gpgSign = true;
                    gpg.ssh.allowedSignersFile = "~/.config/git/allowed_signers";
                    color.ui = "auto";
                    merge.tool = "nvimdiff";
                    merge.conflictstyle = "diff3";
                    push.default = "current";
                    push.autoSetupRemote = true;
				};
            };
            programs.delta = {
                enable = true;

                # Explicitly enable git integration since automatic enablement
                # is deprecated — this sets core.pager = delta in gitconfig.
                enableGitIntegration = true;

                options = {
                    syntax-theme = "kanagawa";
                    side-by-side = true;
                    line-numbers = true;
                    navigate = true;
                    hyperlinks = true;
                    file-style = "bold yellow ul";
                    file-decoration-style = "none";
                    dark = true;
                };
            };
            home.file.".config/git/allowed_signers".text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO6yJ9b3I9mvoOIDSC7CcOdwH1atjoBD+1mTqel4inxf security@wiloti.fr";
		};
	};
}
