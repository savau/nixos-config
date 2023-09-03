{
  description = "savau's flakey NixOS configuration. Source: https://github.com/savau/nixos-config.git";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = let
      hosts = [
        "xego"
        "tis"
        "gsateo"
      ];
      mkHostConfiguration = host: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [
          ./hosts/${host}/configuration.nix
          ./modules.nix
        ];
      };
    in nixpkgs.lib.genAttrs hosts mkHostConfiguration;
  };
}
