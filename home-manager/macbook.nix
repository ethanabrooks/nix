{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./common.nix];

  home = {
    homeDirectory = "/Users/ethan";
    username = "ethan";
    packages = with pkgs; [
      awscli2
      coreutils
    ];
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrains Mono";
      size = 20;
    };
    keybindings = {
      "f1" = "new_window_with_cwd";
    };
    settings = {
      enabled_layouts = "tall:bias=50;full_size=1;mirrored=false";
    };
    shellIntegration.enableZshIntegration = true;
    theme = "Dimmed Monokai";
  };

  programs.zsh.initExtraFirst = ''
      export PATH=/Users/ethan/.local/bin/:$PATH
      source ${pkgs.pure-prompt}/share/zsh/site-functions/async
      source ${pkgs.pure-prompt}/share/zsh/site-functions/prompt_pure_setup
  '';
}
