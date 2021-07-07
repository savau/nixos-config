args'@{ config, pkgs, lib, ... }:

let
  hostname = lib.fileContents ./host;
  hostdir = ./machines/. + "/${hostname}";
  machine = import hostdir args' // { inherit hostname; };
  args = args' // { inherit machine; };
in
{
  imports = [
    # Include the results of the hardware scan.
    (hostdir + "/hardware-configuration.nix")

    # TODO: for each module in ./modules, import module with args instead
    (import ./modules args)
  ];
}
