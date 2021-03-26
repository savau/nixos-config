args@{ config, pkgs, ... }:

{
  imports = [
    (import ./communication.nix args)
    (import ./multimedia.nix args)
    (import ./office.nix args)

    (import ./lang args)
  ];

  environment.systemPackages = with pkgs; [
    # build-essentials
    binutils
    gcc
    gnumake
    gup
    pkgconfig
  ];
}
