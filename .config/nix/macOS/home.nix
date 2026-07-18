{
  pkgs,
  lib,
  hostConfig,
  ...
}:
{
  home = {
    username = hostConfig.username;
    homeDirectory = lib.mkForce hostConfig.homeDirectory;
    stateVersion = "26.05";
  };
  programs.home-manager.enable = true;
}
