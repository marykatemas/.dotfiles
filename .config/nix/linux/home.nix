{
  pkgs,
  lib,
  hostConfig,
  ...
}:
{
  imports = [
    ./packages.nix
  ];
  home = {
    username = hostConfig.username;
    homeDirectory = hostConfig.homeDirectory;
    stateVersion = "26.05";
  };
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
