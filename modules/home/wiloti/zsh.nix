{ self, inputs, ... }: {
  flake.nixosModules.wilotiZsh = { pkgs, lib, ... }: {
    home-manager.users.wiloti = { config, ... }: {

      programs.zsh = {
        enable = true;

        history = {
          size = 50000;
          save = 50000;
          path = "${config.home.homeDirectory}/.zsh_history";
          extended = true;
          ignoreDups = true;
          ignoreSpace = true;
          share = true;
          expireDuplicatesFirst = true;
        };

        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = false;

        plugins = [

          {
            name = "zsh-history-substring-search";
            src = pkgs.zsh-history-substring-search;
            file = "share/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh";
          }

          {
            name = "zsh-autopair";
            src = pkgs.zsh-autopair;
            file = "share/zsh/zsh-autopair/autopair.zsh";
          }
        #   {
        #       name = "fast-syntax-highlighting";
        #       src = pkgs.zsh-fast-syntax-highlighting;
        #       file = "share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh";
        # }
        ];

        shellAliases = {
          rebuild = "sudo nixos-rebuild switch --flake .#void";
          update  = "nix flake update";
          cleanup = "sudo nix-collect-garbage -d";
          grep = "grep --color=auto";
          top  = "btop";
          exegol = "nix-shell -p xhost --run 'xhost +si:localuser:root' &>/dev/null; sudo -E $(echo ~/.local/bin/exegol)";
        };

        completionInit = ''
          # Case-insensitive completion — typing 'desk' matches 'Desktop'
          zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

          # Colored completion menu matching ls colors
          zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}

          # Navigable completion menu — use arrow keys to select
          zstyle ':completion:*' menu select

          # Show completion category headers
          #zstyle ':completion:*' group-name '''

          # Verbose completion descriptions
          zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'

          # Don't complete already-selected entries
          zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm -w -w'
        '';

        initContent = ''
          # Bind Up/Down keys to history substring search after plugin loads.
          # This must happen after the plugin is sourced to take effect.
          bindkey '^[OA' history-substring-search-up
          bindkey '^[OB' history-substring-search-down

          # Also bind Ctrl+P / Ctrl+N as alternative history navigation
          # consistent with emacs-style keybindings.
          bindkey '^P' history-substring-search-up
          bindkey '^N' history-substring-search-down

          # Autopair initialization
          autopair-init
          # Matching Ctrl+E for completing
          bindkey '^E' autosuggest-accept
        '';

        sessionVariables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
          MANPAGER = "nvim +Man!";
          MPD_HOST = "/home/wiloti/.config/mpd/socket";
        };

      };

      programs.fzf = {
        enable = true;
        enableZshIntegration = true;
        defaultCommand = "fd --type f --hidden --follow --exclude .git";
        fileWidgetCommand = "fd --type f --hidden --follow --exclude .git";
        fileWidgetOptions = [ "--preview 'cat {}'" ];
        changeDirWidgetCommand = "fd --type d --hidden --follow --exclude .git";
        changeDirWidgetOptions = [ "--preview 'ls {}'" ];

        colors = {
          "bg+"     = "#363646"; # waveBlue1 — selected item background
          "bg"      = "#181616"; # dragonBlack3 — main background
          "spinner" = "#c4b28a"; # dragonYellow — loading spinner
          "hl"      = "#c4746e"; # dragonRed — highlighted match
          "fg"      = "#c5c9c5"; # dragonWhite — normal text
          "header"  = "#8ba4b0"; # dragonBlue2 — header text
          "info"    = "#c4b28a"; # dragonYellow — info line
          "pointer" = "#87a987"; # dragonGreen — pointer
          "marker"  = "#87a987"; # dragonGreen — multi-select marker
          "fg+"     = "#c5c9c5"; # dragonWhite — selected item text
          "prompt"  = "#87a987"; # dragonGreen — prompt
          "hl+"     = "#c4746e"; # dragonRed — highlighted match selected
        };
      };

    };
  };
}
