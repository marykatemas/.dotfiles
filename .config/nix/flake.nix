{
  description = "marynixmas .dotfiles";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nix-darwin,
      home-manager,
      nixpkgs,
    }@inputs:
    let
      hosts = import ./hosts.nix;
      lib = nixpkgs.lib;
      mkDarwin =
        name: cfg:
        nix-darwin.lib.darwinSystem {
          system = cfg.system;
          specialArgs = {
            hostConfig = cfg;
          };
          modules = [
            ./darwin
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  hostConfig = cfg;
                };
                users.${cfg.username} = import ./darwin/home.nix;
              };
            }
          ];
        };
      mkLinux =
        name: cfg:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${cfg.system};
          extraSpecialArgs = {
            hostConfig = cfg;
          };
          modules = [
            ./linux/home.nix
          ];
        };
    in
    {
      darwinConfigurations = lib.mapAttrs mkDarwin (
        lib.filterAttrs (name: cfg: cfg.type == "darwin") hosts
      );
      homeConfigurations = lib.mapAttrs mkLinux (lib.filterAttrs (name: cfg: cfg.type == "linux") hosts);
    };
}
