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

      # Container tools
      colima
      docker
      docker-compose

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
      (builtins.readFile ./home-manager/zshrc)
    ];

    shellAliases = {
      ll = "ls -l";
      ls = "ls --color=auto";
      update = "home-manager switch --flake ~/.config/home-manager";
    };
  };
}
