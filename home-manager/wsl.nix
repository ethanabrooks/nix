{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./common.nix];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) ["ngrok"];

  home.homeDirectory = "/home/ethan";
  home.packages = with pkgs; [ngrok fuse];

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
