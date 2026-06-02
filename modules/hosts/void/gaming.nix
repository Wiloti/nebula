{ ... }: {
  flake.nixosModules.voidGaming = { pkgs, lib, config, ... }: {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
      package = pkgs.steam.override {
        extraPkgs = pkgs': with pkgs'; [
          gamemode
          libkrb5
          keyutils
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
        ];
      };
    };
    programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          renice = 10;
          inhibit_screensaver = 1;
        };
        cpu = {
          governor = "performance";
        };
      };
    };
    programs.appimage = {
      enable = true;
      binfmt = true;
    };
    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };
    programs.steam.protontricks.enable = true;
    environment.systemPackages = with pkgs; [
      protonup-qt
      steam-run
      appimage-run
      (writeShellScriptBin "knight-launcher" ''
                SPIRAL_DIR="$HOME/games/SteamLibrary/steamapps/common/Spiral Knights"
                JAR="$SPIRAL_DIR/KnightLauncher.jar"

                if [ ! -f "$JAR" ]; then
                  echo "KnightLauncher.jar not found at: $JAR"
                  echo "Download it "
                  echo "and place it in your Spiral Knights installation directory."
                  exit 1
                fi

                exec ${steam-run}/bin/steam-run \
                  ${jdk}/bin/java -jar "$JAR" "$@"
      '')
    ];
  };
}
