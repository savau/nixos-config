{ config, lib, pkgs, ... }:

{
  programs.ssh = {
    startAgent = true;
  };
}
