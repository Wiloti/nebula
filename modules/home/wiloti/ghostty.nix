{ self, inputs, ... }: {
  flake.nixosModules.wilotiGhostty = { pkgs, lib, ... }: {
    home-manager.users.wiloti = {

      home.file.".config/ghostty/config".text = ''
        font-family = IosevkaTerm Nerd Font
        font-size = 14
        font-style = Regular
        cursor-style = bar
        cursor-style-blink = true
        window-decoration = false
        window-padding-x = 8
        window-padding-y = 8
        window-padding-balance = true
        background-opacity = 1.0
        shell-integration = zsh
        scrollback-limit = 2000
        copy-on-select = true
        resize-overlay = never
        confirm-close-surface = false
        bold-is-bright = false
      '';

    };
  };
}
