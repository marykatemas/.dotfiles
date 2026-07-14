{ pkgs, ... }: {
  imports = [
    ./packages.nix
  ];

  home = {
    username = "marykatemas";
    homeDirectory = "/home/marykatemas";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}
