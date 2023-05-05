args@{ config, ... }:

{
  imports = [
    (import ./exfat.nix args)
    (import ./ntfs.nix args)
  ];

  boot.tmp.useTmpfs = true;
}
