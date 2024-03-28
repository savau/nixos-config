{ lib, pkgs, home, ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    customPaneNavigationAndResize = true;
    keyMode = "vi";
    mouse = true;
    newSession = true;
    prefix = "C-x";
    terminal = "screen-256color";
    shell = "${pkgs.zsh}/bin/zsh";
    historyLimit = 50000;
    plugins = with pkgs.tmuxPlugins; [
      cpu
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
          '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '10' # minutes
        '';
      }
    ];
    extraConfig = lib.readFile (pkgs.stdenv.mkDerivation {
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
  };
}
