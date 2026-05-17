{ self, inputs, ... }: {
  flake.nixosModules.wilotiStarship = { pkgs, lib, ... }: {
    home-manager.users.wiloti = {

      programs.starship = {
        enable = true;

        settings = {
          format = lib.concatStrings [
            "$username"
            "@"
            "$hostname"
            " "
            "$directory"
            "$container"
            "$cmd_duration"
            "$line_break"
            "$character"
          ];

          right_format = "$status";

          add_newline = false;

          username = {
            show_always = true;
            format = "[$user]($style)";
            style_user = "bold fg:#87a987";
            style_root = "bold fg:#c4746e";
          };

          hostname = {
            ssh_only = false;
            format = "[$hostname]($style)";
            style = "bold fg:#8a9a7b";
          };

          directory = {
            truncation_length = 2;
            truncate_to_repo = false;
            format = "[$path]($style)";
            style = "bold fg:#8ba4b0";
            home_symbol = "~";
          };

          container = {
            format = " [$symbol $name]($style)";
            style = "bold fg:#b6927b";
            symbol = "󰡨";
          };

          cmd_duration = {
            min_time = 10000;
            format = " [$duration]($style)";
            style = "bold fg:#c4b28a";
          };

          character = {
            success_symbol = "[❯](bold fg:#87a987)";
            error_symbol = "[❯](bold fg:#c4746e)";
            vimcmd_symbol = "[❮](bold fg:#8ba4b0)";
          };

          status = {
            disabled = false;
            format = "[$symbol$status]($style)";
            symbol = "✘ ";
            style = "bold fg:#c4746e";
          };

          git_branch.disabled = true;
          git_commit.disabled = true;
          git_state.disabled = true;
          git_metrics.disabled = true;
          git_status.disabled = true;

          nodejs.disabled = true;
          python.disabled = true;
          rust.disabled = true;
          golang.disabled = true;
          java.disabled = true;
          ruby.disabled = true;
          lua.disabled = true;
          php.disabled = true;
          swift.disabled = true;
          kotlin.disabled = true;
          scala.disabled = true;
          haskell.disabled = true;
          elixir.disabled = true;
          elm.disabled = true;
          erlang.disabled = true;
          julia.disabled = true;
          nim.disabled = true;
          ocaml.disabled = true;
          perl.disabled = true;
          purescript.disabled = true;
          rlang.disabled = true;
          red.disabled = true;
          terraform.disabled = true;
          pulumi.disabled = true;
          nix_shell.disabled = true;
          conda.disabled = true;
          docker_context.disabled = true;
          package.disabled = true;
        };
      };

    };
  };
}
