{
  pkgs,
  lib,
  hostConfig,
  ...
}:
{
  imports = [
    ./packages.nix
    ./system-settings.nix
    ./homebrew.nix
  ];
  system.primaryUser = hostConfig.username;
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.hostPlatform = hostConfig.system;
  system.stateVersion = 6;
}
