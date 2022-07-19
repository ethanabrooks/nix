{
  config,
  pkgs,
  lib,
  ...
}: let
  vim-snazzy = pkgs.vimUtils.buildVimPlugin {
    name = "vim-snazzy";
    src = pkgs.fetchFromGitHub {
      owner = "connorholyday";
      repo = "vim-snazzy";
      rev = "d979964b4dc0d6860f0803696c348c5a912afb9e";
      sha256 = "sha256-6YZUHOqqNP6V4kUEd24ClyMJfckvkQTYRtcVsBsiNSk=";
    };
  };
in {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    homeDirectory = builtins.getEnv "HOME";

    # Packages that should be installed to the user profile.
    packages = with pkgs; [
      alejandra
      htop
      mosh
      ncdu
      nix
      nixFlakes
      nixfmt
      poetry
      python39
      ripgrep
      tree
    ];

    sessionVariables = {EDITOR = "nvim";};

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

  imports = lib.lists.flatten [
    (lib.optionals (builtins.currentSystem == "x86_64-linux") [./linux.nix])
    (lib.optionals (builtins.currentSystem == "x86_64-darwin") [./darwin.nix])
  ];

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
    difftastic.enable = true;
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

  programs.gitui = {enable = true;};

  # Let Home Manager install and manage itself.
  programs.home-manager = {enable = true;};

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./vimrc;
    plugins = with pkgs.vimPlugins; [
      ale
      fzf-vim
      #lightline-vim
      #lightline-gruvbox-vim
      nerdcommenter
      null-ls-nvim
      nvim-lspconfig
      python-syntax
      vim-cute-python
      vim-nix
      vim-python-pep8-indent
      vim-surround

      gruvbox
      onehalf
      papercolor-theme
      tender-vim
      nord-vim
      vim-one
      oceanic-next
      ayu-vim
      palenight-vim
      vim-snazzy
    ];
  };

  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./tmux.conf;
  };

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
      update = "home-manager switch -b backup";
    };
    localVariables = {TERM = "xterm-256color";};
  };
}
