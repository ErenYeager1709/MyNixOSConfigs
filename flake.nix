{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      ];
    };
  };
}
