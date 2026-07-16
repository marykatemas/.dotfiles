{ pkgs, lib, ... }:
{
  security.pam.services.sudo_local = {
    reattach = true;
    touchIdAuth = true;
    watchIdAuth = true;
  };

  networking = {
    localHostName = "marykate-mac";
    computerName = "marykate macbook";
    hostName = "marykate.local";
    knownNetworkServices = [ "Wi-Fi" "Ethernet Adaptor" "Thunderbolt Ethernet" ];
    dns = [ "1.1.1.1" "1.0.0.1" ];
  };

  system.defaults = {
    NSGlobalDomain = {
      InitialKeyRepeat = 10;
      KeyRepeat = 2;
      ApplePressAndHoldEnabled = false;
      "com.apple.swipescrolldirection" = false;
      "com.apple.mouse.tapBehavior" = 1;
    };

    trackpad.Clicking = true;

    universalaccess.mouseDriverCursorSize = 2.5;

    smb.NetBIOSName = "marykate-mac";

    ".GlobalPreferences"."com.apple.mouse.scaling" = 1.0;

    CustomUserPreferences = {
      "NSGlobalDomain" = {
        "com.apple.mouse.linear" = true;
      };
    };
  };
}
