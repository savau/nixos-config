{ lib, pkgs, ... }:

{
  imports = lib.mapAttrsToList (moduleName: moduleFileType:
    if   moduleFileType == "regular" && builtins.match "[^ ]+.nix" moduleName == []
      || moduleFileType == "directory"
    then
      import (./modules/. + "/${moduleName}")
    else
      # if the module is neither a regular nix file nor a directory, it is either a regular non-nix file, a symlink or an unknown file type
      # in this case, abort expression evaluation with error
      abort ("Unsupported module type: Found module " ++ moduleName ++ " of file type " ++ moduleFileType ++ ", but only regular *.nix files and directories are supported. Aborting.")
  ) (builtins.readDir ./modules);
}
