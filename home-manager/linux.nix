{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./common.nix];

  home = {
    homeDirectory = "/home/ethanbro";
    username = "ethanbro";
    packages = with pkgs; [yarn];
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
