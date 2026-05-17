{ self, inputs, ... }: {
  flake.nixosModules.wilotiMpd = { pkgs, lib, ... }: {
    home-manager.users.wiloti = {

      services.mpd = {
        enable = true;
        musicDirectory = "/home/wiloti/media/music";
        dataDir = "/home/wiloti/.config/mpd";
        network.listenAddress = "~/.config/mpd/socket";
        network.port = 6600;
        extraConfig = ''
          audio_output {
            type        "pipewire"
            name        "PipeWire Sound Server"
            format      "*:*:*"
          }
          auto_update "yes"
          restore_paused "yes"
          save_absolute_paths_in_playlists "yes"
        '';
      };
      systemd.user.services.mpd = {
        Unit.After = [ "home-wiloti-media.mount" ];
        Unit.Requires = [ "home-wiloti-media.mount" ];
      };
      home.packages = with pkgs; [
        mpc
        ncmpcpp
        ashuffle
      ];
      home.file.".config/ncmpcpp/bindings".text = ''
          def_key "j"
            scroll_down

          def_key "k"
            scroll_up

          def_key "h"
            previous_column

          def_key "l"
            next_column

          def_key "g"
            move_home

          def_key "G"
            move_end

          def_key "ctrl-d"
            page_down

          def_key "ctrl-u"
            page_up

          def_key "1"
            show_playlist

          def_key "2"
            show_media_library

          def_key "3"
            show_search_engine

          def_key "4"
            show_browser

          def_key "d"
            delete_playlist_items

          def_key "down"
            scroll_down

          def_key "up"
            scroll_up

          def_key "right"
            next_column

          def_key "left"
            previous_column
          '';
    };
  };
}
