{
  description = "A simple NixOS flake";

  nixConfig = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
    };
    noctalia-greeter.url = "github:noctalia-dev/noctalia-greeter";
    hydration-notifier.url = "git+https://tangled.org/tobinio.dev/hydration-notifier";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.eren = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./configuration.nix
        inputs.hydration-notifier.nixosModules.default
	inputs.nix-flatpak.nixosModules.nix-flatpak
	inputs.noctalia.nixosModules.default
	inputs.noctalia-greeter.nixosModules.default
	inputs.home-manager.nixosModules.home-manager
      ];
    };
  };
}
