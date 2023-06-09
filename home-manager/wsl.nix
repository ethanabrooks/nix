{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./common.nix];

  home.homeDirectory = "/home/ethan";

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
