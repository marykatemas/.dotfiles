{
  description = "";

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

  outputs = { self, nix-darwin, home-manager, nixpkgs }@inputs: {
    darwinConfigurations."marykatemas-macos" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./macOS/darwin.nix
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.marykatemas = import ./macOS/home.nix;
          };
        }
      ];
    };

    homeConfigurations."marykatemas-linux" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."aarch64-linux";
      modules = [
        ./linux/home.nix
      ];
    };
  };
}
