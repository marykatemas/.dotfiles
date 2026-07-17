{ pkgs, lib, ... }: {
  imports = [
    ./packages.nix
    ./system-settings.nix
    ./homebrew.nix
  ];

  system.primaryUser = "marykatemas";

  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 6;
}
