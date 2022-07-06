{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ethanbro";
  home.homeDirectory = "/home/ethanbro";

  # Packages that should be installed to the user profile.
  home.packages = [
    pkgs.htop
    pkgs.tmux
    pkgs.vim
    pkgs.neovim
    pkgs.ncdu
    pkgs.poetry
  ];

  # Raw configuration files
  home.file.".vimrc".source = ./vimrc;

  programs.git = {
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

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
