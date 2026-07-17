{ pkgs, ... }:
let
  brewfile = builtins.readFile ../../homebrew/Brewfile;
in
{
  homebrew = {
    enable = true;
    onActivation = {
    };

    taps = [ ];
    brews = [ ];
    casks = [ ];
    masApps = { };

    extraConfig = brewfile;
  };
}
