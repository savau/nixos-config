args'@{ config, pkgs, lib, ... }:

let
  hostname = lib.fileContents ./host;
  # hostdir = ./machines/. + "/${hostname}";
  # machine = import hostdir args' // { inherit hostname; };
  # args = args' // { inherit machine; };
in
{
  imports = [
    # Include the results of the hardware scan
    ./machines/${hostname}/hardware-configuration.nix

    # Include machine-specific configuration.nix
    ./machines/${hostname}/configuration.nix
  ];

    # import each module in ./modules
    # TODO: include modules in machine and user config
    # ++ (
    #   lib.mapAttrsToList
    #   (moduleName: moduleFileType:
    #    if   moduleFileType == "regular" && builtins.match "[^ ]+.nix" moduleName == []
    #      || moduleFileType == "directory"
    #    then
    #      import (./modules/. + "/${moduleName}") args
    #    else
    #      # if the module is neither a regular nix file nor a directory, it is either a regular non-nix file, a symlink or an unknown file type
    #      # in this case, abort expression evaluation with error
    #      # TODO: throw warning and ignore the module instead of aborting?
    #      abort ("Unsupported module type: Found module " ++ moduleName ++ " of file type " ++ moduleFileType ++ ", but only regular *.nix files and directories are supported. Aborting.")
    #   )
    #   (builtins.readDir ./modules)
    # );
}
