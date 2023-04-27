{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./common.nix];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) ["vscode" "slack"];

  home = {
    homeDirectory = "/Users/ethan";

    packages = with pkgs; [hasura-cli iterm2 slack];
  };

  programs.vscode.enable = true;
}
