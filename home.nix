{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    # Raw configuration files
    file.".vimrc".source = ./vimrc;

    homeDirectory = "/home/ethanbro";

    # Packages that should be installed to the user profile.
    packages = with pkgs; [
      htop
      fzf
      mosh
      ncdu
      nix
      nixpkgs-fmt
      poetry
      pure-prompt
      ripgrep
      tmux
      tree
      zsh
    ];

    sessionVariables.EDITOR = "nvim";

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
    git = {
      enable = true;
      userName = "ethanabrooks";
      userEmail = "ethanabrooks@gmail.com";
      aliases = {
        lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
        br = "branch";
        co = "checkout";
        cm = "commit -am";
        df = "!git reset && git diff";
      };
    };

    # Let Home Manager install and manage itself.
    home-manager = {
      enable = true;
    };

    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      extraConfig = builtins.readFile ./init.vim;
      plugins = with pkgs.vimPlugins; [
        ale
        gruvbox
        nerdcommenter
        vim-nix
      ];
    };

    zsh = {
      enable = true;
      enableSyntaxHighlighting = true;
      history.size = 10000;
      initExtra =  builtins.readFile ./init.zsh;
      prezto = {
        enable = true;
        prompt.theme = "pure";
        tmux.itermIntegration = true;
      };
      shellAliases = {
        ll = "ls -l";
        update = "home-manager switch -b backup";
      };
    };
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
