{self, inputs, ... }: {
        flake.nixosModules.voidUsers = {pkgs, lib, ... }: {
                users.users.wiloti = {
                        isNormalUser = true;
                        extraGroups = [ "wheel" "networkmanager" "video" "libvirtd" "kvm" "docker" "input" "gamemode" ];
			shell = pkgs.zsh;
			autoSubUidGidRange = true; # For podman & docker rootless containers
			uid = 1000;
			hashedPasswordFile = "/etc/nixos/secrets/wiloti-password-pc";
			# For later setup sshAuthorizedKey
                };
        };
}
