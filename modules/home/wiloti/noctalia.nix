{ inputs, ... }: {
  flake.nixosModules.wilotiNoctalia = { pkgs, lib, ... }: {
    home-manager.users.wiloti = {
      imports = [ inputs.noctalia.homeModules.default ];

      programs.noctalia = {
        enable = true;

        systemd.enable = true;

        settings = {
          theme = {
            mode = "dark";
            source = "builtin";
            builtin = "Kanagawa Dragon";
          };

          wallpaper = {
            enabled = true;
            default.path = "/home/wiloti/Pictures/Wallpapers/philipp-a-urlich-cpncept541e.jpg";
          };

          bar = {
            enabled = true;
          };
        };
      };
    };
  };
}
