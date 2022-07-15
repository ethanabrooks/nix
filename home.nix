{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    # Raw configuration files
    homeDirectory = "/home/ethanbro";

    # Packages that should be installed to the user profile.
    packages = with pkgs; [
      htop
      mosh
      ncdu
      nix
      nixFlakes
      nixfmt
      poetry
      ripgrep
      tree
    ];

    sessionVariables = { EDITOR = "nvim"; };

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "22.05";

    username = "ethanbro";
  };

  programs = {

    direnv = {
      enable = true;
      enableZshIntegration = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    git = {
      difftastic.enable = true;
      enable = true;
      userName = "ethanabrooks";
      userEmail = "ethanabrooks@gmail.com";
      aliases = {
        lg =
          "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
        br = "branch";
        co = "checkout";
        cm = "commit -am";
        df = "!git reset && git diff";
      };
    };

    gitui = { enable = true; };

    # Let Home Manager install and manage itself.
    home-manager = { enable = true; };

    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      extraConfig = builtins.readFile ./vimrc;
      plugins = with pkgs.vimPlugins; [
        ale
        fzf-vim
        gruvbox
        nerdcommenter
        vim-nix
        vim-surround
        lightline-vim
      ];
    };

    tmux.enable = true;

    zsh = {
      autocd = true;
      enable = true;
      enableSyntaxHighlighting = true;
      enableAutosuggestions = true;
      initExtra = builtins.readFile ./zshrc;
      prezto = {
        editor.keymap = "vi";
        enable = true;
        prompt.theme = "pure";
        python.virtualenvAutoSwitch = true;
      };
      shellAliases = {
        ll = "ls -l";
        update = "home-manager switch -b backup";
      };
      localVariables = { TERM = "xterm-256color"; };
    };
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
