args:

{
  imports = [
  # (import ./agda.nix args)
    (import ./haskell.nix args)
  # (import ./java.nix args)
    (import ./javascript.nix args)
  # (import ./octave.nix args)
    (import ./python.nix args)
  # (import ./r.nix args)
  # (import ./ruby.nix args)
    (import ./tex.nix args)
  ];
}
