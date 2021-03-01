args:

{
  imports = [
    ./nix.nix
    (import ./nixpkgs)

    (import ./home-manager.nix args)

    (import ./basics.nix args)
    (import ./editor args)
    (import ./git.nix args)
    (import ./graphical args)
    (import ./i18n.nix args)
    (import ./laptop-battery.nix args)
    (import ./media.nix args)
    (import ./networking.nix args)
    (import ./security.nix args)
    (import ./ssh.nix args)
    (import ./users.nix args)
    (import ./work args)
    (import ./zsh.nix args)
  ];
}
