args:

{
  imports = [
    ./nix.nix
    (import ./nixpkgs)

    (import ./home-manager.nix args)

    (import ./audio.nix args)
    (import ./bluetooth.nix args)
    (import ./boot-loader.nix args)
  # (import ./direnv.nix args)
    (import ./editor args)
    (import ./entertainment args)
    (import ./firmware.nix args)
    (import ./git.nix args)
    (import ./graphical args)
    (import ./i18n.nix args)
    (import ./kernel.nix args)
    (import ./laptop-battery.nix args)
    (import ./luks.nix args)
    (import ./networking.nix args)
    (import ./printing.nix args)
    (import ./security.nix args)
    (import ./sh args)
    (import ./ssd-optimizations.nix args)
    (import ./ssh.nix args)
    (import ./system-administration.nix args)
    (import ./time.nix args)
    (import ./tmux.nix args)
    (import ./users.nix args)
    (import ./video.nix args)
    (import ./virtualisation.nix args)
    (import ./work args)
  ];
}
