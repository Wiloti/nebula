{ self, inputs, ... }: {
  flake.nixosModules.wilotiMpv = { pkgs, lib, ... }: {
    home-manager.users.wiloti = {

      programs.mpv = {
        enable = true;
        package = pkgs.mpv.override {
          scripts = with pkgs.mpvScripts; [
            mpris
            sponsorblock-minimal
            modernx
          ];
        };

        config = {
          vo = "gpu";
          gpu-api = "vulkan";
          hwdec = "nvdec";
          profile = "high-quality";
          ytdl-format = "bestvideo[height<=1080]+bestaudio/best";
          gpu-context = "waylandvk";
          ao = "pipewire";
          keep-open = true;
          save-position-on-quit = true;
          sub-auto = "fuzzy";
          sub-font-size = 40;
        };
      };
      programs.yt-dlp = {
        enable = true;
        settings = {
          embed-metadata = true;
          embed-thumbnail = true;
        };
      };

    };
  };
}
