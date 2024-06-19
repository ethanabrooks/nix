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
      google-cloud-sdk
      htop
      lua-language-server
      ncdu
      nodejs_21
      ntp
      poetry
      python312
      ripgrep
      rnix-lsp
      speedtest-cli
      tree
      yarn
      magic-wormhole
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

  programs.git = {
    #difftastic.enable = true;
    enable = true;
    userName = "ethanabrooks";
    userEmail = "ethanabrooks@gmail.com";
    extraConfig.core.editor = "vim";
    aliases = {
      br = "branch";
      cm = "commit -am";
      co = "checkout";
      df = "diff";
      lg = "log --oneline";
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

  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = builtins.readFile ./wezterm.lua;
  };

  programs.zsh = {
    autocd = true;
    enable = true;
    syntaxHighlighting.enable = true;
    enableAutosuggestions = true;
    initExtraFirst = ''
      source ${pkgs.pure-prompt}/share/zsh/site-functions/async
      source ${pkgs.pure-prompt}/share/zsh/site-functions/prompt_pure_setup
    '';
    initExtra = builtins.readFile ./zshrc;
    shellAliases = {
      ll = "ls -l";
      ls = "ls --color=auto";
      s = "kitten ssh";
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
