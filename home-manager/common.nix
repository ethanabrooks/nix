{
  config,
  pkgs,
  lib,
  ...
}: {
  fonts.fontconfig.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    # Packages that should be installed to the user profile.
    packages = with pkgs; [
      alejandra
      htop
      ncdu
      nix
      nixFlakes
      nodejs
      poetry
      python39
      ripgrep
      tree
      lua-language-server
      nodePackages.pyright
      rnix-lsp
    ];

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.05";
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
      lg = "log --oneline";
      br = "branch";
      co = "checkout";
      cm = "commit -am";
      df = "!git reset && git diff";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager = {enable = true;};

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraLuaConfig = builtins.readFile ./init.lua;
    plugins = with pkgs.vimPlugins; [
      oceanic-next
      nvim-lspconfig # Essential for configuring LSP servers
      nvim-cmp # Autocompletion plugin
      cmp-nvim-lsp # LSP source for nvim-cmp
    ];
    withNodeJs = true;
  };

  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./tmux.conf;
    historyLimit = 10000;
  };

  programs.zsh = {
    autocd = true;
    enable = true;
    syntaxHighlighting.enable = true;
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
      update-darwin = "home-manager --flake '.#darwin' switch -b backup";
      update-linux = "home-manager --flake '.#linux' switch -b backup";
    };
    localVariables = {
      TERM = "xterm-256color";
      DOCKER_BUILDKIT = 1;
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}
