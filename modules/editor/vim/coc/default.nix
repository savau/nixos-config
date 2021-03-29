args:

{
  imports = [
    # choose ONE *.nix file in this directory
    (import ./basic.nix args)
  ];
}
