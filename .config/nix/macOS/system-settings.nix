{
  pkgs,
  lib,
  hostConfig,
  ...
}:
{
  security.pam.services.sudo_local = {
    reattach = true;
    touchIdAuth = true;
    watchIdAuth = true;
  };
  networking = {
    localHostName = hostConfig.localHostName;
    computerName = hostConfig.computerName;
    hostName = hostConfig.hostName;
    knownNetworkServices = [
      "Wi-Fi"
      "Ethernet Adaptor"
      "Thunderbolt Ethernet"
    ];
    dns = [
      "1.1.1.1"
      "1.0.0.1"
    ];
  };
  system.defaults = {
    smb.NetBIOSName = hostConfig.localHostName;
    NSGlobalDomain = {
      InitialKeyRepeat = 10;
      KeyRepeat = 1;
      ApplePressAndHoldEnabled = false;
      _HIHideMenuBar = true;
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
      "com.apple.swipescrolldirection" = false;
      "com.apple.mouse.tapBehavior" = 1;
    };
    dock.autohide = true;
    trackpad.Clicking = true;
    universalaccess.mouseDriverCursorSize = 2.5;
    ".GlobalPreferences"."com.apple.mouse.scaling" = 1.0;
    CustomUserPreferences = {
      "NSGlobalDomain" = {
        "com.apple.mouse.linear" = true;
      };
    };
  };
}
