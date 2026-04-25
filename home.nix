{ pkgs, lib, ... }:

{
  home = {
    username = "ethan";
    homeDirectory = "/Users/ethan";
    stateVersion = "23.05";

    packages = with pkgs; [
      # Nix tooling
      nixfmt-rfc-style

      # CLI tools
      gh
      google-cloud-sdk
      htop
      ncdu
      ripgrep
      speedtest-cli
      tree
      uv
      wezterm

      # Container tools
      colima
      docker
      docker-compose

      # Runtimes
      nodejs

      # macOS-specific
      coreutils
    ];
  };

  programs.home-manager.enable = true;

  # Shell integrations
  programs.dircolors = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = "$username$hostname$directory$git_branch$git_state$git_status$cmd_duration$line_break$python$character";
      directory.style = "blue";
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };
      git_branch = {
        format = "[$branch]($style)";
        style = "bright-black";
      };
      git_status = {
        format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
        style = "cyan";
        conflicted = "​";
        untracked = "​";
        modified = "​";
        staged = "​";
        renamed = "​";
        deleted = "​";
        stashed = "≡";
      };
      git_state = {
        format = "\\([$state( $progress_current/$progress_total)]($style)\\) ";
        style = "bright-black";
      };
      cmd_duration = {
        format = "[$duration]($style) ";
        style = "yellow";
      };
      python = {
        format = "[$virtualenv]($style) ";
        style = "bright-black";
        detect_extensions = [];
        detect_files = [];
      };
    };
  };

  # Git
  programs.git = {
    enable = true;
    userName = "ethanabrooks";
    userEmail = "ethanabrooks@gmail.com";
    aliases = {
      br = "branch";
      cm = "commit -am";
      co = "checkout";
      df = "diff";
      lg = "log --oneline";
    };
  };

  # Neovim
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    extraConfig = ''
      set clipboard=unnamedplus
    '';
    plugins = with pkgs.vimPlugins; [
      # Theme
      NeoSolarized

      # Syntax
      nvim-treesitter.withAllGrammars

      # Navigation
      telescope-nvim
      telescope-fzf-native-nvim
      plenary-nvim
      neo-tree-nvim
      nvim-web-devicons
      nui-nvim

      # LSP + Completion
      nvim-lspconfig
      mason-nvim
      mason-lspconfig-nvim
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip

      # Git
      gitsigns-nvim

      # Formatting
      conform-nvim

      # Quality of life
      nvim-autopairs
      comment-nvim
      which-key-nvim
      lualine-nvim
      bufferline-nvim
    ];
    extraLuaConfig = builtins.readFile ./home-manager/nvim.lua;
  };

  # Tmux
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./home-manager/tmux.conf;
    historyLimit = 10000;
  };

  # Zsh
  programs.zsh = {
    enable = true;
    autocd = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    initContent = lib.mkMerge [
      (lib.mkBefore ''
        export PATH=/Users/ethan/bin:/Users/ethan/.local/bin/:$PATH
      '')
      (builtins.readFile ./home-manager/zshrc)
    ];

    shellAliases = {
      ll = "ls -l";
      ls = "ls --color=auto";
      update = "home-manager switch --flake ~/.config/home-manager";
    };
  };
}
