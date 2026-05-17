{ self, inputs, ... }: {
  flake.nixosModules.commonGhostty = { pkgs, lib, ... }: {
    environment.systemPackages = [ pkgs.ghostty ];
  };
}
