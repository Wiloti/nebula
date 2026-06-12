{  inputs, ... }: {
  flake.nixosModules.wilotiNiri = { pkgs, lib, ... }: {
    home-manager.users.wiloti = { config, ... }: {
      programs.niri.settings = {

        spawn-at-startup = [
          { command = [ "${pkgs.xwayland-satellite}/bin/xwayland-satellite" ]; }
          { command = [ (lib.getExe pkgs.ghostty) ]; }
          { command = [
              "${inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.twilight}/bin/zen-twilight"
            ];
          }
        ];

        input = {
          keyboard = {
            xkb = {
              layout = "us,fr";
            };
            track-layout = "global";
            repeat-delay = 300;
            repeat-rate = 50;
          };

          mouse = {
            accel-profile = "flat";
            scroll-factor = 1.2;
          };

          touchpad.enable = false;
          trackpoint.enable = false;
          trackball.enable = false;
          tablet.enable = false;
          touch.enable = false;

          warp-mouse-to-focus.enable = true;

          focus-follows-mouse = {
            enable = true;
            max-scroll-amount = "0%";
          };

          workspace-auto-back-and-forth = true;
        };

        layout = {
          gaps = 10;

          center-focused-column = "on-overflow";

          always-center-single-column = true;

          default-column-width = {};

          preset-column-widths = [
            { proportion = 0.5; }
            { proportion = 0.75; }
            { proportion = 1.0; }
          ];

          focus-ring = {
            enable = true;
            width = 2;
            active.color = "#e8d5b770";
            inactive.color = "#00000000";
          };

          border.enable = false;

          shadow = {
            enable = true;
            softness = 30;
            spread = 5;
            offset = { x = 0; y = 0; };
            color = "#00000080";
          };

          insert-hint = {
            enable = true;
	    display = {
            	color = "#e8d5b780";
	    };
          };

          struts = {
            top = 5;
            bottom = 0;
            left = 0;
            right = 0;
          };
        };

        workspaces = {
          "Main" = {};
        };

        window-rules = [

          {
            geometry-corner-radius = {
              top-left = 12.0;
              top-right = 12.0;
              bottom-left = 12.0;
              bottom-right = 12.0;
            };
            clip-to-geometry = true;
          }

          {
            matches = [{ is-active = false; }];
            opacity = 0.97;
          }

          {
            matches = [{
              at-startup = true;
              app-id = "com.mitchellh.ghostty";
            }];
            open-on-output = "DP-1";
	    open-maximized = true;
          }

          {
            matches = [{
              at-startup = true;
              app-id = "zen-twilight";
            }];
            open-on-output = "HDMI-A-1";
	    open-maximized = true;
          }
          {
            matches = [{ title = "YouTube Feed"; }];
            open-floating = true;
            default-window-height = { fixed = 500; };
            default-column-width = { fixed = 900; };
          }

          {
            matches = [{ title = "Twitch Live"; }];
            open-floating = true;
            default-window-height = { fixed = 500; };
            default-column-width = { fixed = 900; };
          }
          {
            matches = [{ app-id = "mpv"; }];
            open-on-output = "HDMI-A-1";
          }
        ];

	gestures.hot-corners.enable = false;

        cursor = {
          theme = "Bibata-Modern-Classic";
          size = 20;
          hide-when-typing = true;
          hide-after-inactive-ms = 5000;
        };

        animations.enable = false;

        hotkey-overlay = {
          skip-at-startup = true;
          hide-not-bound = true;
        };

        prefer-no-csd = true;

        debug.honor-xdg-activation-with-invalid-serial = true;

        binds = with config.lib.niri.actions; let
          noctaliaIpc = cmd:
            spawn-sh "noctalia msg ${cmd}";
        in {

          # -- Window management --
          "Mod+A" = { action = close-window; };
          "Mod+F" = { action = maximize-column; };
          "Mod+Shift+F" = { action = fullscreen-window; };
          # Cycle column presets: 0.5 → 0.75 → 1.0 → 0.5
          "Mod+E" = { action = switch-preset-column-width; };
          "Mod+Q" = { action = switch-preset-column-width-back; };
          "Mod+B" = { action = expand-column-to-available-width; };
          "Mod+C" = { action = center-column; };
          "Mod+R" = { action = focus-window-previous; };

          # -- Focus movement (Vim-style) --
          "Mod+H" = { action = focus-column-left; };
          "Mod+L" = { action = focus-column-right; };
          "Mod+J" = { action = focus-window-down; };
          "Mod+K" = { action = focus-window-up; };
          "Mod+U" = { action = focus-column-first; };
          "Mod+I" = { action = focus-column-last; };

          "Mod+Alt+H" = { action = focus-monitor-left; };
          "Mod+Alt+L" = { action = focus-monitor-right; };

          "Mod+Shift+H" = { action = move-column-left; };
          "Mod+Shift+L" = { action = move-column-right; };
          "Mod+Shift+J" = { action = move-window-down; };
          "Mod+Shift+K" = { action = move-window-up; };
          "Mod+Alt+Shift+H" = { action = move-column-to-monitor-left; };
          "Mod+Alt+Shift+L" = { action = move-column-to-monitor-right; };

          } // (builtins.listToAttrs (builtins.genList (i: let
            n = i + 1;
          in {
            name = "Mod+${toString n}";
            value = { action.focus-workspace = [ n ]; };
          }) 9))

          // (builtins.listToAttrs (builtins.genList (i: let
            n = i + 1;
          in {
            name = "Mod+Shift+${toString n}";
            value = { action.move-column-to-workspace = [ n ]; };
          }) 9))

          // {
          "Mod+0" = { action = toggle-overview; repeat = false; };
          "Mod+Shift+Slash" = { action = show-hotkey-overlay; };
          "Mod+Space" = { action = switch-layout "next"; };
          "Mod+T" = { action = spawn (lib.getExe pkgs.ghostty); };
          "Mod+S" = { action = noctaliaIpc "panel-toggle launcher"; };
          "Mod+Y" = { action = spawn
            "${inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.twilight}/bin/zen-twilight";
          };
          "Mod+O" = { action = spawn (lib.getExe pkgs.obsidian); };
          "Print" = { action = spawn-sh ''set -e; grim -t ppm -g "$(slurp -d)" - | satty -f - --initial-tool=arrow --copy-command=wl-copy --corner-roundness=0 --actions-on-escape="save-to-clipboard,exit" --disable-notifications''; };

          "Mod+Alt+F" = { action = noctaliaIpc "session lock"; };
          "Mod+Alt+R" = { action = noctaliaIpc "panel-toggle launcher /emoji"; };
          "Mod+Alt+P" = { action = noctaliaIpc "settings-toggle"; };
          "Mod+Alt+W" = { action = noctaliaIpc "panel-toggle session"; };

          "XF86AudioRaiseVolume" = {
            action = noctaliaIpc "volume-up";
            allow-when-locked = true;
          };
          "XF86AudioLowerVolume" = {
            action = noctaliaIpc "volume-down";
            allow-when-locked = true;
          };
          "XF86AudioMute" = {
            action = noctaliaIpc "volume-mute";
            allow-when-locked = true;
          };
          "XF86AudioPlay" = {
            action = noctaliaIpc "media toggle";
            allow-when-locked = true;
          };
          "XF86AudioNext" = {
            action = noctaliaIpc "media next";
            allow-when-locked = true;
          };
          "XF86AudioPrev" = {
            action = noctaliaIpc "media previous";
            allow-when-locked = true;
          };
          "Mod+Alt+Y" = { action = spawn-sh "ghostty --title='YouTube Feed' --command=yt-feed";};
          "Mod+Alt+T" = { action = spawn-sh "ghostty --title='Twitch Live' --command=twitch-live";};
        };

      };
    };
  };
}
