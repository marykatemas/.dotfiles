{ pkgs, ... }:
let
  sharedPkgs = import ../shared/packages.nix pkgs;
in
{
  environment.systemPackages =
    sharedPkgs
    ++ (with pkgs; [
    ]);
}
