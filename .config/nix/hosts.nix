{
  default =
    let
      sys = builtins.currentSystem;
      userEnv = builtins.getEnv "USER";
      hostEnv = builtins.getEnv "HOST";
    in
    {
      type = if builtins.match ".*-darwin" sys != null then "darwin" else "linux";
      system = sys;
      username = userEnv;
      homeDirectory =
        if builtins.match ".*-darwin" sys != null then "/Users/${userEnv}" else "/home/${userEnv}";
      hostName = hostEnv;
      localHostName = hostEnv;
      computerName = hostEnv;
    };
  marykatemas-macos = {
    type = "darwin";
    system = "aarch64-darwin";
    username = "marykatemas";
    homeDirectory = "/Users/marykatemas";
    hostName = "marykate-mac";
    localHostName = "marykate-mac";
    computerName = "marykate macbook";
  };
  marykatemas-linux = {
    type = "linux";
    system = "aarch64-linux";
    username = "marykatemas";
    homeDirectory = "/home/marykatemas";
  };
}
