{ config, pkgs, ... }:

{
  nix = {
    package = pkgs.nix;


  # daemonNiceLevel = 0;          # Nix daemon process priority (0: highest, 19: lowest)
    daemonIOSchedPriority = 0;    # Nix daemon process I/O priority (0: highest, 7: lowest)
  # allowedUsers = [ "@wheel" ];  # grant the wheel user group permission to connect to the Nix daemon
  
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      sandbox = true;                                 # prevent impurities in builds by disallowing access to dependencies outside of the Nix store
      cores = 0;                                      # use all available CPU cores when building
      trusted-users = [ "@wheel" ];                   # grant the wheel user group additional rights when connecting to the Nix daemon
      substituters = [ "https://cache.nixos.org/" ];  # list of binary cache URLs used to obtain pre-built binaries of Nix packages
    };

    extraOptions = ''
      builders-use-substitutes = true
    '';
  };
}
