{ pkgs, lib, ... }: {
  home = {
    username = "marykatemas";
    homeDirectory = lib.mkForce "/Users/marykatemas";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}
