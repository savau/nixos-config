args:

{
  imports = [
    (import ./communication.nix args)
    (import ./games.nix args)
    (import ./multimedia.nix args)
  ];
}
