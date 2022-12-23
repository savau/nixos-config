args:

{
  imports = [
    (import ./games.nix args)
    (import ./multimedia.nix args)
  ];
}
