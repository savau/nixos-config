{ config, pkgs, lib, ... }:

let
  hostname = lib.fileContents ./host;  # TODO: make this obsolete by using flakes in the future
in
{
  imports = [
    <home-manager/nixos>

    # Include machine-specific configuration.nix
    ./hosts/${hostname}/configuration.nix
  ]
    # import each module in ./modules
    ++ (
      lib.mapAttrsToList
      (moduleName: moduleFileType:
       if   moduleFileType == "regular" && builtins.match "[^ ]+.nix" moduleName == []
         || moduleFileType == "directory"
       then
         import (./modules/. + "/${moduleName}")
       else
         # if the module is neither a regular nix file nor a directory, it is either a regular non-nix file, a symlink or an unknown file type
         # in this case, abort expression evaluation with error
         abort ("Unsupported module type: Found module " ++ moduleName ++ " of file type " ++ moduleFileType ++ ", but only regular *.nix files and directories are supported. Aborting.")
      )
      (builtins.readDir ./modules)
    );

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = false;

  home-manager.users.root = {
    programs.home-manager.enable = true;
    home.stateVersion = "24.05";
    imports = [ # TODO: promote those three to system-level
      ./home/neovim.nix
      ./home/tmux.nix
      ./home/zsh.nix
    ];
  };
  users.users.root.shell = pkgs.zsh;

  home-manager.users.savau = import ./home.nix;
  users.users.savau = {
    isNormalUser = true;
    extraGroups = [
      "audio" "video"
      "nitrokey"
      "networkmanager"
      "lp" "scanner"
      "systemd-journal"
      "docker"
      "wheel"
    ];
  };

  programs.zsh.enable = true;

  system.stateVersion = "24.05";
}
