{ config, pkgs, ... }:

{
  nix = {
    useSandbox = true;      # prevent impurities in builds by disallowing access to dependencies outside of the Nix store
    buildCores = 0;         # use all available CPU cores when building
    daemonNiceLevel = 0;    # Nix daemon process priority (0: highest, 19: lowest)
    daemonIONiceLevel = 0;  # Nix daemon process I/O priority (0: highest, 7: lowest)
    allowedUsers = [ "@wheel" ];  # grant the wheel user group permission to connect to the Nix daemon
    trustedUsers = [ "@wheel" ];  # grant the wheel user group additional rights when connecting to the Nix daemon
    binaryCaches = [ "https://cache.nixos.org/" ];  # list of binary cache URLs used to obtain pre-built binaries of Nix packages
    extraOptions = ''
      builders-use-substitutes = true
    '';  # enable the builder to use caches
  };

  environment.systemPackages = with pkgs; [
    nix-prefetch-git
  ];
}
