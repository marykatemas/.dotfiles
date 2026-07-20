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
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  home.activation.stowConfigs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -d "$HOME/.dotfiles" ]; then
      ${pkgs.stow}/bin/stow -d "$HOME/.dotfiles" -t "$HOME" .
    fi
    if [ -d "$HOME/.dotfiles.local" ]; then
      ${pkgs.stow}/bin/stow -d "$HOME/.dotfiles.local" -t "$HOME" .
    fi
  '';
}
