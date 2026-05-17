{ self, inputs, ... }: {
  flake.nixosModules.voidNiri = { pkgs, lib, ... }: {

    home-manager.users.wiloti = {

      programs.niri.settings.outputs = {

        "DP-1" = {
          mode = {
            width = 1920;
            height = 1080;
            refresh = 144.001;
          };
          position = {
            x = 0;
            y = 0;
          };
          scale = 1.0;
          transform.rotation = 0;
          focus-at-startup = true;
          variable-refresh-rate = false;
        };

        "HDMI-A-1" = {
          mode = {
            width = 1920;
            height = 1080;
            refresh = 74.973;
          };
          position = {
            x = 1920;
            y = 0;
          };
          scale = 1.0;
          transform.rotation = 0;
          variable-refresh-rate = false;
        };
      };

    };
  };
}
