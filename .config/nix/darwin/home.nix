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
  home.activation.stowConfigs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -d "$HOME/.dotfiles" ]; then
      ${pkgs.stow}/bin/stow -d "$HOME/.dotfiles" -t "$HOME" .
    fi
    if [ -d "$HOME/.dotfiles.local" ]; then
      ${pkgs.stow}/bin/stow -d "$HOME/.dotfiles.local" -t "$HOME" .
    fi
  '';
}
