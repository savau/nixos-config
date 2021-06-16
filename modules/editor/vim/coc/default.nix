args'@{ pkgs, vimConfigDir, ... }:

let
  args = args' // {
    cocConfigDir = "${vimConfigDir}/nvim/coc-settings";
  };
in
{
  imports = [
  # choose ONE *.nix file in this directory
    (import ./basic.nix args)
  ];

  environment.systemPackages = with pkgs; [
    nodejs  # coc requirement
  ];
}
