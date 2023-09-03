{
  description = "savau's flakey NixOS configuration. Source: https://github.com/savau/nixos-config.git";

  nixConfig = {
    allowedUsers = [ "@wheel" ];  # grant the wheel user group permission to connect to the Nix daemon
    daemonNiceLevel = 0;          # Nix daemon process priority (0: highest, 19: lowest)
    daemonIOSchedPriority = 0;    # Nix daemon process I/O priority (0: highest, 7: lowest)

    experimental-features = [ "nix-command" "flakes" ];
    sandbox = true;                                 # prevent impurities in builds by disallowing access to dependencies outside of the Nix store
    cores = 0;                                      # use all available CPU cores when building
    trusted-users = [ "@wheel" ];                   # grant the wheel user group additional rights when connecting to the Nix daemon
    substituters = [ "https://cache.nixos.org/" ];  # list of binary cache URLs used to obtain pre-built binaries of Nix packages

    extraOptions = ''
      builders-use-substitutes = true
    '';
  };

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
    home-manager.url = github:nix-community/home-manager;

    # TODO use below repo to create nixosConfigurations for all hosts
    # (nixos-rebuild will pick the correct config based on hostname)
    nixos-config = {
      url = path:/etc/nixos; # TODO switch to git repo
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = let
      hosts = [
        "xego"
        "tis"
        "gsateo"
      ];
      mkDefaultSystem = host: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [
          ./hosts/${host}/configuration.nix
          ./modules.nix
        ];
      };
    in nixpkgs.lib.genAttrs hosts mkDefaultSystem;
  };
}
