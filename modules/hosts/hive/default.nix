{self, inputs, ... }: {
    flake.nixosConfiguration.hive = inputs.nixpkgs.lib.nixosSystem {
        module = [ self.nixosModules.hiveConfiguration ];
    };
}
