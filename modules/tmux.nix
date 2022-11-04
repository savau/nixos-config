{ config, pkgs, lib, ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    historyLimit = 50000;
    extraConfig = lib.readFile (pkgs.stdenv.mkDerivation {
      name = "tmux.conf";
      src = ./../dotfiles/tmux.conf;

      buildInputs = with pkgs; [ makeWrapper ];

      phases = [ "installPhase" ];

      inherit (pkgs) zsh;
      mandb = pkgs.man-db;

      installPhase = ''
        substituteAll $src $out
      '';
    });
    # tmuxp.enable = true;
  };
}
