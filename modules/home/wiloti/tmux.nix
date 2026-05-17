{ self, inputs, ... }: {
  flake.nixosModules.wilotiTmux = { pkgs, lib, ... }: {
    home-manager.users.wiloti = {

      programs.tmux = {
        enable = true;
        prefix = "C-Space";
        terminal = "tmux-256color";
        baseIndex = 1;
        escapeTime = 10;
        focusEvents = true;
        aggressiveResize = true;
        mouse = false;
        historyLimit = 50000;
        keyMode = "vi";

        extraConfig = ''
          set -g display-time 2000
          set -g renumber-windows on
          # True color support for neovim and color-aware applications.
          set -ag terminal-overrides ",*:Tc"

          # Status bar position — bottom keeps noctalia bar at top
          # and tmux status at bottom for clean visual separation.
          set -g status-position bottom

          # Prevent tmux from auto-renaming windows based on running command.
          set -g allow-rename off

          # Activity alerts — highlight windows with activity in the status bar.
          setw -g monitor-activity on
          set -g visual-activity on

          set -g status-left " #H "

          # Send prefix through to nested tmux sessions with Ctrl+Space twice.
          bind C-Space send-prefix

          # Reload config with prefix+R.
          bind R source-file $XDG_CONFIG_HOME/tmux/tmux.conf \; display "Config reloaded!"

          # Split panes preserving current working directory.
          bind '"' split-window -v -c "#{pane_current_path}"
          bind % split-window -h -c "#{pane_current_path}"

          # New windows open in current directory.
          bind c new-window -c "#{pane_current_path}"
        '';

        shell = "${pkgs.zsh}/bin/zsh";

        plugins = with pkgs.tmuxPlugins; [
          vim-tmux-navigator
          yank
          {
            plugin = ukiyo;
            extraConfig = ''
              set -g @ukiyo-theme "kanagawa/dragon"
              set -g @ukiyo-plugins "git time"
              set -g @ukiyo-show-powerline true
              set -g @ukiyo-show-flags true
              set -g @ukiyo-refresh-rate 3
              set -g @ukiyo-border-contrast false
              set -g @ukiyo-ignore-window-colors true
              set -g @ukiyo-left-icon-padding 0
            '';
          }
          {
            plugin = resurrect;
            extraConfig = ''
              set -g @resurrect-capture-pane-contents "on"
            '';
          }
          {
            plugin = continuum;
            extraConfig = ''
              set -g @continuum-restore "on"
              set -g @continuum-save-interval "10"
            '';
          }
        ];
      };

    };
  };
}
