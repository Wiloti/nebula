{ self, inputs, ... }: {
  flake.nixosModules.desktopSddm = { pkgs, lib, ... }: {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "pixie";
      extraPackages = with pkgs.kdePackages; [
        qtdeclarative
        qtsvg
      ];
      settings = {
        General = {
          Numlock = "off";
          RememberLastUser = true;
          RememberLastSession = true;
        };
        Theme = {
          CursorTheme = "Bibata-Modern-Classic";
          EnableAvatars = false;
        };
      };
    };

    systemd.tmpfiles.rules = [
      "d /var/lib/sddm/wallpapers 0755 sddm sddm"
    ];
    environment.systemPackages = [
      pkgs.bibata-cursors
      (pkgs.stdenv.mkDerivation (
      {
        name = "pixie-sddm";
        src = pkgs.fetchFromGitHub {
          owner = "xCaptaiN09";
          repo = "pixie-sddm";
          rev = "f20ebd5b8f1a75616d864564c7f4c3d2826b8a92";
          sha256 = "sha256-A09sfUECmZw89U1k9L6di8i0v7av5/vC/JDpi5UZ9Ho=";
        };
        nativeBuildInputs = [ pkgs.imagemagick ];
        installPhase = ''
          mkdir -p $out/share/sddm/themes/pixie
          cp -r * $out/share/sddm/themes/pixie/
          rm -f $out/share/sddm/themes/pixie/assets/avatar.jpg
          {
            echo '[General]'
            echo 'background=/var/lib/sddm/wallpapers/background.jpg'
            echo 'primaryColor=#E3E3DC'
            echo 'accentColor=#A9C78F'
            echo 'autoColor=true'
            echo 'use24HourClock=false'
            echo 'backgroundColor=#1A1C18'
            echo 'textColor=#E3E3DC'
            echo 'fontFamily=FlexRounded'
            echo 'fontSize=12'
          } > $out/share/sddm/themes/pixie/theme.conf
        '';
      }))
    ];

  };
}
