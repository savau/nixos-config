{
  description = "savau's flakey NixOS configuration. Source: https://github.com/savau/nixos-config";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    savau-xmonad-config = {
      url = github:savau/xmonad-config;
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    hosts = [
      "xego"
      "tis"
      "gsateo"
    ];
    users = [
      "savau"
      "ishka"
    ];

    inherit (self) outputs;
    system = "x86_64-linux";
    mkHostConfiguration = host: nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/${host}/configuration.nix
        ./modules.nix
      ];
      specialArgs = inputs;
    };
    mkHomeConfiguration = user: home-manager.lib.homeManagerConfiguration {
      inherit system;
      username = "${user}";
      homeDirectory = "/home/${user}";
      configuration.imports = [
        ./users/${user}/home.nix
      ];
      extraSpecialArgs = {
        inherit inputs outputs;
      };
    };
  in {
    nixosConfigurations = nixpkgs.lib.genAttrs hosts mkHostConfiguration;
    homeConfigurations  = nixpkgs.lib.genAttrs users mkHomeConfiguration;
  };
}
