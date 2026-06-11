{ ... }: {
  flake.nixosModules.hiveUsers = { pkgs, lib, ... }: {
    users.users.wiloti = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "video"
      ];
      shell = pkgs.zsh;
      autoSubUidGidRange = true;
      uid = 1000;
      hashedPasswordFile = "/etc/nixos/secrets/wiloti-password-laptop";
    };
  };
}
