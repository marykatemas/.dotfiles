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
  # Let Determinate Nix handle Nix configuration
  nix.enable = false;
  system.primaryUser = hostConfig.username;
  nixpkgs.hostPlatform = hostConfig.system;
  system.stateVersion = 6;
  nixpkgs.config.allowUnfree = true;
  environment =
    let
      brewPrefix = if pkgs.stdenv.hostPlatform.isAarch64 then "/opt/homebrew" else "/usr/local";
    in
    {
      systemPath = [
        "${brewPrefix}/bin"
        "${brewPrefix}/sbin"
      ];
      variables = {
        HOMEBREW_PREFIX = brewPrefix;
        HOMEBREW_CELLAR = "${brewPrefix}/Cellar";
        HOMEBREW_REPOSITORY = brewPrefix;
      };
    };
}
