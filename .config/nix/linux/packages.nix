{ pkgs, ... }:
let
  sharedPkgs = import ../shared/packages.nix pkgs;
in
{
  home.packages =
    sharedPkgs
    ++ (with pkgs; [
      gcc
    ]);
}
