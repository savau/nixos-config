{ config, pkgs, lib, machine, ... }:

with lib;
let
  cloneIfNotExists = branch: source: target: ''
    if [ ! -e "${target}" ]; then
      $DRY_RUN_CMD ${pkgs.git}/bin/git clone \
        --branch "${branch}" \
        --recursive \
        -- \
        "${source}" \
        "${target}"
    fi
  '';

  cloneScripts = mapAttrs (_: user:
      attrsets.mapAttrsToList
      (_: data: cloneIfNotExists data.branch data.source data.target)
      user.data
    ) machine.users;
in
{
  nixpkgs.config = {
    programs.git.enable = true;
    home.activation.cloneStatefulRepos = config.lib.dag.entryAfter [ "installPackages" ] (builtins.concatStringsSep "\n" cloneScripts);
  };
}
