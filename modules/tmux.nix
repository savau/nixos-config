{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    clock24 = true;
    customPaneNavigationAndResize = true;
    historyLimit = 50000;
    keyMode = "vi";
    newSession = true;
    shortcut = "x";
    terminal = "screen-256color";

    extraConfigBeforePlugins = lib.readFile (pkgs.stdenv.mkDerivation {
      name = "tmux.conf";
      src = ./../dotfiles/tmux.conf;
      mandb = pkgs.man;

      buildInputs = with pkgs; [ makeWrapper ];

      phases = [ "installPhase" ];
      installPhase = ''
        substituteAll $src $out
      '';

      inherit (pkgs) zsh;
    });

    plugins = with pkgs.tmuxPlugins; [
      resurrect
      continuum
    ];
    extraConfig = ''
      set -g @resurrect-strategy-vim 'session'
      set -g @resurrect-strategy-nvim 'session'
      set -g @resurrect-capture-pane-contents 'on'
      set -g @continuum-restore 'on'
      set -g @continuum-boot 'on'
      set -g @continuum-save-interval '10' # minutes
    '';
  };
}
