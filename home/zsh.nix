{ lib, pkgs, home, ... }:

{
  programs.zsh = {
    enable = true;

    autocd = true;
    autosuggestion.enable = true;
    history = {
      size = 1000000;
      save = 1000000;
      ignorePatterns = [];
      ignoreSpace = true;
      extended = true;
      share = true;
    };

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [
        "git"
      ];
    };

    dirHashes = {
      "dl"   = "$HOME/Downloads";
      "docs" = "$HOME/Nextcloud/Documents";
      # "proj" = "$HOME/Projects"; # TODO: move current symlinks in proj here?
    };

    # initExtraFirst = ''
    #   export PATH=~/.utils/bin:$PATH
    # '';
    # initExtra = ''
    #   GPG_TTY=$(tty)
    #   export GPG_TTY
    # '';
  };
}
