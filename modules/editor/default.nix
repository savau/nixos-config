args@{ config, pkgs, ... }:

{
  imports = [
    (import ./vim args)
  ];

  environment.variables = {
    EDITOR = "nvim";
    GIT_EDITOR = "nvim";
  };
}
