{ self, inputs, ... }: {
  flake.nixosModules.wilotiMedia = { pkgs, lib, ... }: {
    home-manager.users.wiloti = {
      home.packages = with pkgs; [
        yt-dlp
        streamlink
        twitch-cli
        python3
        (pkgs.writeShellScriptBin "yt-feed" (builtins.readFile ./scripts/yt-feed))
        (pkgs.writers.writePython3Bin "twitch-live" {
          libraries = [];
          flakeIgnore = [ "E501" "E265" ];
        } (builtins.readFile ./scripts/twitch-live))
      ];
    };
  };
}
