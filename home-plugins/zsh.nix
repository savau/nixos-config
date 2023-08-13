{ lib, pkgs, home, ... }:

{
  programs.zsh = {
    enable = true;
    autocd = true;
    enableAutosuggestions = true;
    history = {
      size = 1000000;
      save = 1000000;
      ignorePatterns = [
        "rm *"
        "pkill *"
      ];
      ignoreSpace = true;
      extended = true;
      share = true;
    };
    shellAliases = {
      "ll" = "ls -la";
    };
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" ];
    };
    initExtraFirst = ''
      export PATH=~/.utils/bin:$PATH
    '';
    initExtra = ''
      GPG_TTY=$(tty)
      export GPG_TTY
    '';
  };
}
