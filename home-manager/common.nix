{
  config,
  pkgs,
  lib,
  ...
}: let
  ifDarwin = pkgs.lib.lists.optionals pkgs.stdenv.isDarwin;
  ifLinux = pkgs.lib.lists.optionals pkgs.stdenv.isLinux;
in {
  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) ["vscode" "slack"];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    homeDirectory = "/home/ethanbro";

    # Packages that should be installed to the user profile.
    packages = with pkgs;
      [
        alejandra
        htop
        mosh
        ncdu
        nix
        nixFlakes
        nodejs
        poetry
        python39
        ripgrep
        tree
      ]
      ++ ifDarwin [hasura-cli iterm2 slack];

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.05";

    username = "ethanbro";
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

  programs.git = {
    #difftastic.enable = true;
    enable = true;
    userName = "ethanabrooks";
    userEmail = "ethanabrooks@gmail.com";
    extraConfig.core.editor = "vim";
    aliases = {
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      br = "branch";
      co = "checkout";
      cm = "commit -am";
      df = "!git reset && git diff";
    };
  };

  programs.gitui = {enable = true;};

  # Let Home Manager install and manage itself.
  programs.home-manager = {enable = true;};

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./vimrc;
    plugins = with pkgs.vimPlugins; [
      #ale
      copilot-vim
      fzf-vim
      nerdcommenter
      null-ls-nvim
      nvim-lspconfig
      oceanic-next
      python-syntax
      lightline-vim
      supertab
      vim-cute-python
      vim-nix
      vim-python-pep8-indent
      vim-surround
    ];
    withNodeJs = true;
  };

  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./tmux.conf;
    historyLimit = 10000;
  };

  programs.vscode = {enable = pkgs.stdenv.isDarwin;};

  programs.zsh = {
    autocd = true;
    enable = true;
    enableSyntaxHighlighting = true;
    enableAutosuggestions = true;
    initExtra = builtins.readFile ./zshrc;
    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
    };
    prezto = {
      editor.keymap = "vi";
      enable = true;
      prompt.theme = "pure";
    };
    shellAliases = {
      ll = "ls -l";
      update = "home-manager --flake .#ethanbro@ethanbro switch -b backup";
    };
    localVariables = {
      TERM = "xterm-256color";
      DOCKER_BUILDKIT = 1;
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}