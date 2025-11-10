{ pkgs, lib, ... }:

{
  home = {
    username = "ethan";
    homeDirectory = "/Users/ethan";
    stateVersion = "23.05";

    # Essential packages
    packages = with pkgs; [
      # Nix tooling
      alejandra # Nix code formatter
      nixpkgs-fmt # Alternative Nix formatter (more conservative)

      # CLI tools
      gh
      htop
      ncdu
      ripgrep
      speedtest-cli
      tree

      # macOS-specific
      coreutils
    ];
  };

  # Font support
  fonts.fontconfig.enable = true;

  # Let Home Manager install and manage itself
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

  # Git configuration
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "ethanabrooks";
        email = "ethanabrooks@gmail.com";
      };
      core.editor = "nvim";
      alias = {
        br = "branch";
        cm = "commit -am";
        co = "checkout";
        df = "diff";
        lg = "log --oneline";
      };
    };
  };

  # Neovim - minimal config since most work is in Cursor/VSCode
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  # Tmux
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./home-manager/tmux.conf;
    historyLimit = 10000;
  };

  # Zsh with pure prompt
  programs.zsh = {
    enable = true;
    autocd = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    # Pure prompt setup and custom config
    initContent = lib.mkMerge [
      (lib.mkBefore ''
        export PATH=/Users/ethan/.local/bin/:$PATH
        source ${pkgs.pure-prompt}/share/zsh/site-functions/async
        source ${pkgs.pure-prompt}/share/zsh/site-functions/prompt_pure_setup
      '')
      (builtins.readFile ./home-manager/zshrc)
    ];

    shellAliases = {
      ll = "ls -l";
      ls = "ls --color=auto";
      update = "home-manager switch --flake ~/.config/home-manager";
    };

    localVariables = {
      TERM = "xterm-256color";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}
