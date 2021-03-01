{ config, pkgs, ... }:

{
  imports = [
    (import ./vim)
  ];

  environment.variables = {
    EDITOR = "nvim";
    GIT_EDITOR = "nvim";
  };
}
