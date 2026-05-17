{ inputs, ... }:
{
  flake.nixosModules.wilotiNvim =
    { pkgs, lib, ... }:
    {
      home-manager.users.wiloti =
        { config, ... }:
        {
          imports = [ inputs.nixvim.homeModules.nixvim ];
          programs.nixvim = {
            enable = true;

            colorschemes.kanagawa-paper = {
              enable = true;
            };

            opts = {
              number = true;
              relativenumber = true;
              tabstop = 4;
              softtabstop = 4;
              shiftwidth = 4;
              expandtab = true;
              smartindent = true;
              wrap = false;
              swapfile = false;
              backup = false;
              undofile = true;
              hlsearch = false;
              incsearch = true;
              termguicolors = true;
              scrolloff = 8;
              signcolumn = "yes";
              updatetime = 50;
              clipboard = "unnamedplus";
              colorcolumn = "80";
              splitright = true;
              splitbelow = true;
            };

            globals.mapleader = " ";

            keymaps = [
              {
                mode = "v";
                key = "J";
                action = ":m '>+1<CR>gv=gv";
                options.desc = "Move selection down";
              }
              {
                mode = "v";
                key = "K";
                action = ":m '<-2<CR>gv=gv";
                options.desc = "Move selection up";
              }
              {
                mode = "n";
                key = "J";
                action = "mzJ`z";
                options.desc = "Join line without moving cursor";
              }
              {
                mode = "n";
                key = "<C-d>";
                action = "<C-d>zz";
                options.desc = "Half page down centered";
              }
              {
                mode = "n";
                key = "<C-u>";
                action = "<C-u>zz";
                options.desc = "Half page up centered";
              }
              {
                mode = "n";
                key = "n";
                action = "nzzzv";
                options.desc = "Next search result centered";
              }
              {
                mode = "n";
                key = "N";
                action = "Nzzzv";
                options.desc = "Previous search result centered";
              }
              {
                mode = "x";
                key = "<leader>p";
                action = ''"_dP'';
                options.desc = "Paste without overwriting clipboard";
              }
              {
                mode = "n";
                key = "Q";
                action = "<nop>";
                options.desc = "Disable Ex mode";
              }
              {
                mode = "n";
                key = "<leader>s";
                action = ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>";
                options.desc = "Search and replace word under cursor";
              }
              {
                mode = "n";
                key = "<leader>o";
                action = "<cmd>Oil --float<CR>";
                options.desc = "Open file manager";
              }
              # Trouble keymaps registered at the top level rather than in
              # trouble.keymaps because nixvim handles them more reliably here.
              {
                mode = "n";
                key = "<leader>xx";
                action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
                options.desc = "Buffer diagnostics (Trouble)";
              }
              {
                mode = "n";
                key = "<leader>xX";
                action = "<cmd>Trouble diagnostics toggle<cr>";
                options.desc = "Workspace diagnostics (Trouble)";
              }
              {
                mode = "n";
                key = "<leader>xq";
                action = "<cmd>Trouble qflist toggle<cr>";
                options.desc = "Quickfix list (Trouble)";
              }
              # Noice keymaps for browsing message history and dismissing
              # notifications without reaching for the mouse.
              {
                mode = "n";
                key = "<leader>nh";
                action = "<cmd>Noice history<cr>";
                options.desc = "Noice message history";
              }
              {
                mode = "n";
                key = "<leader>nd";
                action = "<cmd>Noice dismiss<cr>";
                options.desc = "Dismiss notifications";
              }
            ];

            extraConfigLua = ''
              -- Rounded borders for LSP floating windows.
              local border = "rounded"

              vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                vim.lsp.handlers.hover,
                { border = border }
              )
              vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                vim.lsp.handlers.signature_help,
                { border = border }
              )

              vim.diagnostic.config({
                float = {
                  border = border,
                  source = "if_many",
                  header = "",
                  prefix = "",
                },
                virtual_text = {
                  prefix = "●",
                },
                signs = true,
                underline = true,
                update_in_insert = false,
              })

              -- Configure nvim-notify appearance after it has loaded.
              -- background_colour must match your colorscheme's background
              -- so notify can calculate readable contrast for its popups.
              -- The kanagawa-paper dark background is #1f1f28.
              require("notify").setup({
                -- "fade" slides notifications in and fades them out smoothly.
                -- This is the least distracting option during focused editing.
                stages = "fade",
                -- Notifications stay visible for 3 seconds before fading.
                timeout = 3000,
                -- Keep popups compact — 50 columns fits most LSP messages.
                max_width = 50,
                -- "minimal" removes the title bar for a cleaner appearance.
                -- Use "default" if you want the plugin name shown in the title.
                render = "minimal",
                background_colour = "#1f1f28",
              })

              -- Replace vim's built-in notify with nvim-notify so that every
              -- plugin calling vim.notify() goes through the same visual system.
              vim.notify = require("notify")
            '';

            plugins = {
              web-devicons.enable = true;
              fidget.enable = true;
              vim-tmux-navigator.enable = true;

              which-key = {
                enable = true;
                settings = {
                  delay = 300;
                  icons.enabled = true;
                  win.border = "rounded";
                  win.padding = [ 1 2 ];
                };
              };

              # nvim-notify is the rendering engine for animated notifications.
              # It must be declared here so nixvim adds the package to the vim
              # pack. The actual setup() call happens in extraConfigLua above
              # because we need it to run after the plugin is loaded.
              notify = {
                enable = true;
              };

              # noice.nvim replaces the command line, search interface, and
              # notification routing with floating popups. The routes block
              # is the most important part — it tells noice which messages
              # to skip so fidget can handle LSP progress exclusively without
              # creating duplicate notifications.
              noice = {
                enable = true;
                settings = {
                  cmdline = {
                    enabled = true;
                    view = "cmdline_popup";
                    opts.border.style = "rounded";
                  };

                  messages = {
                    enabled = true;
                    view = "notify";
                    view_error = "notify";
                    view_warn = "notify";
                    # Search count stays inline with the search bar
                    # rather than appearing as a separate popup.
                    view_search = "virtualtext";
                  };

                  popupmenu = {
                    enabled = true;
                    backend = "nui";
                  };

                  routes = [
                    # Skip LSP progress messages — fidget.nvim handles these
                    # with its purpose-built spinner in the bottom right corner.
                    # Without this route, you would see duplicate progress
                    # notifications from both fidget and noice simultaneously.
                    {
                      filter = {
                        event = "lsp";
                        kind = "progress";
                      };
                      opts.skip = true;
                    }
                    # File write confirmations ("N lines written") are frequent
                    # and low-value so we skip them to reduce notification noise.
                    {
                      filter = {
                        event = "msg_show";
                        kind = "";
                        find = "written";
                      };
                      opts.skip = true;
                    }
                    # Search count messages ("3/12") stay as virtualtext
                    # rather than triggering a notification popup.
                    {
                      filter = {
                        event = "msg_show";
                        kind = "search_count";
                      };
                      opts.skip = true;
                    }
                  ];

                  lsp = {
                    # Disabled here because fidget owns LSP progress display.
                    progress.enabled = false;
                    hover = {
                      enabled = true;
                      opts.border.style = "rounded";
                    };
                    signature = {
                      enabled = true;
                      opts.border.style = "rounded";
                    };
                    # LSP error and warning messages appear as notify popups.
                    message = {
                      enabled = true;
                      view = "notify";
                    };
                    documentation.opts.border.style = "rounded";
                  };

                  health.checker = false;
                };
              };

              blink-cmp = {
                enable = true;
                settings = {
                  keymap = {
                    preset = "none";
                    "<C-p>" = [ "select_prev" "fallback" ];
                    "<C-n>" = [ "select_next" "fallback" ];
                    "<C-y>" = [ "accept" "fallback" ];
                    "<C-Space>" = [ "show" "show_documentation" "hide_documentation" ];
                    "<C-e>" = [ "hide" "fallback" ];
                  };
                  appearance.nerd_font_variant = "normal";
                  sources.default = [ "lsp" "buffer" "path" ];
                  snippets.preset = "luasnip";
                  completion = {
                    menu.border = "rounded";
                    documentation = {
                      auto_show = true;
                      auto_show_delay_ms = 200;
                      window.border = "rounded";
                    };
                    ghost_text.enabled = true;
                  };
                };
              };

              luasnip.enable = true;

              lsp = {
                enable = true;
                servers = {
                  lua_ls = {
                    enable = true;
                    settings.Lua = {
                      runtime.version = "Lua 5.1";
                      diagnostics.globals = [
                        "vim" "bit" "it" "describe" "before_each" "after_each"
                      ];
                    };
                  };
                  rust_analyzer = {
                    enable = true;
                    installRustc = true;
                    installCargo = true;
                  };
                  gopls.enable = true;
                  clangd.enable = true;
                  nil_ls.enable = true;
                  basedpyright.enable = true;
                  bashls.enable = true;
                  phpactor.enable = true;
                };
                keymaps = {
                  lspBuf = {
                    "gd" = { action = "definition"; desc = "Go to definition"; };
                    "gD" = { action = "declaration"; desc = "Go to declaration"; };
                    "gi" = { action = "implementation"; desc = "Go to implementation"; };
                    "gr" = { action = "references"; desc = "Go to references"; };
                    "K" = { action = "hover"; desc = "Show hover documentation"; };
                    "<leader>ca" = { action = "code_action"; desc = "Code action"; };
                    "<leader>rn" = { action = "rename"; desc = "Rename symbol"; };
                    "<leader>f" = { action = "format"; desc = "Format buffer"; };
                  };
                  diagnostic = {
                    "<leader>dp" = { action = "goto_prev"; desc = "Previous diagnostic"; };
                    "<leader>dn" = { action = "goto_next"; desc = "Next diagnostic"; };
                  };
                };
              };

              treesitter = {
                enable = true;
                settings = {
                  auto_install = false;
                  highlight = {
                    enable = true;
                    additional_vim_regex_highlighting = [ "markdown" ];
                  };
                  indent.enable = true;
                };
                grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
                  vimdoc lua rust go c nix python bash
                  javascript typescript php markdown markdown-inline
                  toml yaml json regex comment
                ];
              };

              telescope = {
                enable = true;
                settings.defaults = {
                  vimgrep_arguments = [
                    "rg" "--color=never" "--no-heading"
                    "--with-filename" "--line-number" "--column" "--smart-case"
                  ];
                  find_command = [
                    "fd" "--type" "f" "--hidden" "--follow" "--exclude" ".git"
                  ];
                };
                keymaps = {
                  "<leader>ff" = { action = "find_files"; options.desc = "Find files"; };
                  "<C-p>" = { action = "git_files"; options.desc = "Find git files"; };
                  "<leader>fws" = { action = "grep_string"; options.desc = "Grep word under cursor"; };
                  "<leader>fWs" = { action = "grep_string"; options.desc = "Grep WORD under cursor"; };
                  "<leader>fs" = { action = "live_grep"; options.desc = "Live grep"; };
                  "<leader>vh" = { action = "help_tags"; options.desc = "Help tags"; };
                  "<leader>fb" = { action = "buffers"; options.desc = "Find buffers"; };
                  "<leader>fd" = { action = "diagnostics"; options.desc = "Find diagnostics"; };
                };
              };

              oil = {
                enable = true;
                settings = {
                  view_options.show_hidden = true;
                  float.enabled = true;
                };
              };

              # mini.enable = true is required so nixvim adds the mini.nvim
              # package to the vim pack directory. Without it the modules
              # are declared but the Lua files don't exist on disk, which
              # is why require('mini.pairs') was returning "not found".
              mini = {
                enable = true;
                modules = {
                  pairs = { };
                  surround = { };
                  comment = { };
                };
              };

              indent-blankline = {
                enable = true;
                settings = {
                  indent.char = "│";
                  scope.enabled = true;
                };
              };

              trouble.enable = true;
            };
          };
        };
    };
}
