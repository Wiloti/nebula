{ self, inputs, ... }: {
  flake.nixosModules.wilotiSsh = { pkgs, lib, ... }: {
    home-manager.users.wiloti = {
      services.ssh-agent.enable = true;
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        matchBlocks = {
          "*" = {
            controlMaster = "auto";
            controlPath = "~/.ssh/sockets/%r@%h-%p";
            controlPersist = "10m";
          };
          "github.com" = {
            hostname = "github.com";
            user = "git";
            identityFile = "~/.ssh/id_ed25519";
            identitiesOnly = true;
            extraOptions = {
              PubkeyAcceptedAlgorithms = "+ssh-ed25519";
            };
          };
        };
      };

    };
  };
}
