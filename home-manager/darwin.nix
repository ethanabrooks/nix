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
      coreutils
    ];
  };
}
