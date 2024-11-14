{
  description = "my minimal flake";
  inputs = {
    # Where we get most of our software. Giant mono repo with recipes
    # called derivations that say how to build software.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable"; # nixos-22.11

    # Manages configs links things into your home directory
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Controls system level software and settings including fonts
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    pwnvim.url = "github:h-tiwari-dev/pwnvim?ref=b7cd03c1093f7aabc5b0f0cf362a53fa27548c3d";
  };
  outputs = inputs @ {
    nixpkgs,
    home-manager,
    darwin,
    pwnvim,
    ...
  }: {
    darwinConfigurations.Harshs-MacBook-Air = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        system = "aarch64-darwin";
        overlays = [(self: super: {inherit (self) allowUnfree;})];
        config.allowUnfree = true; # Allow unfree packages
      };

      modules = [
        ./modules/darwin
        home-manager.darwinModules.home-manager
        {
          users.users.harshtiwari.home = "/Users/harshtiwari/";
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {inherit pwnvim;};
            users.harshtiwari.imports = [
              ./modules/home-manager
            ];
          };
        }
      ];
    };
  };
}
