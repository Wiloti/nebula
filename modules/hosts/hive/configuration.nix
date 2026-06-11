{ self, inputs, ... }: {
  flake.nixosModules.hiveConfiguration = { config, pkgs, lib, ... }: {
    imports = [
      self.nixosModules.hiveHardware
      self.nixosModules.hiveBoot
      self.nixosModules.hiveUsers
      self.nixosModules.hiveNetworking

      self.nixosModules.commonSecurity
      self.nixosModules.commonAudio
      self.nixosModules.commonLocale
      self.nixosModules.commonHomeManager
      self.nixosModules.commonGit
      self.nixosModules.commonGhostty
      self.nixosModules.commonZsh

      self.nixosModules.desktopNiri
      self.nixosModules.desktopSddm

      self.nixosModules.wilotiHomeManager
      self.nixosModules.wilotiNiri
      self.nixosModules.wilotiGit
      self.nixosModules.wilotiGhostty
      self.nixosModules.wilotiZsh
      self.nixosModules.wilotiTmux
      self.nixosModules.wilotiNvim
      self.nixosModules.wilotiSsh
      self.nixosModules.wilotiStarship
      self.nixosModules.wilotiZenBrowser
      self.nixosModules.wilotiMpv
      self.nixosModules.Direnv
      self.nixosModules.Bat
    ];

    environment.systemPackages = with pkgs; [
      fd
      jq
      vim
      tree
      file
      btop
      p7zip
      ffmpeg
      ripgrep
      firefox
      zathura
      binutils
      exiftool
      wl-clipboard
      acpi
      powertop
      brightnessctl
      docker
    ];

    services.thermald.enable = true;
    services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        # Keep battery between 20-80% for longevity
        START_CHARGE_THRESH_BAT0 = 20;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };

    services.logind = {
      lidSwitch = "suspend-then-hibernate";
      lidSwitchExternalPower = "suspend";
    };
    systemd.sleep.extraConfig = ''
      HibernateDelaySec=2h
    '';

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    system.stateVersion = "25.11";
  };
}
