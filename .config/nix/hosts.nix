{
  default =
    let
      sys = builtins.currentSystem;
      userEnv = builtins.getEnv "USER";
    in
    {
      type = if builtins.match ".*-darwin" sys != null then "darwin" else "linux";
      system = sys;
      username = userEnv;
      homeDirectory =
        if builtins.match ".*-darwin" sys != null then "/Users/${userEnv}" else "/home/${userEnv}";
      hostName = "hostNameDefault";
      localHostName = "localHostNameDefault";
      computerName = "computerNameDefault";
    };
  marykatemas-darwin = {
    type = "darwin";
    system = "aarch64-darwin";
    username = "marykatemas";
    homeDirectory = "/Users/marykatemas";
    hostName = "hostMaryKate";
    localHostName = "localHostMaryKate";
    computerName = "computerMaryKate";
  };
  marykatemas-linux = {
    type = "linux";
    system = "aarch64-linux";
    username = "marykatemas";
    homeDirectory = "/home/marykatemas";
  };
}
