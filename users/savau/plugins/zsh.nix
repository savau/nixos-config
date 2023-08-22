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
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.7.0";
          sha256 = "sha256-oQpYKBt0gmOSBgay2HgbXiDoZo5FoUKwyHSlUrOAP5E=";
        };
      }
    ];
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