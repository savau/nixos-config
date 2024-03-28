{ config, lib, pkgs, ... }:

{
  programs.ssh = {
    enable = true;

    startAgent = true;
  };
}
