{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./common.nix];

  home.homeDirectory = "/home/ethanbro";

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
