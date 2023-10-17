{ lib, pkgs, home, ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.bash.initExtra = ''
    eval "$(${pkgs.direnv}/bin/direnv hook bash)"
  '';
  programs.zsh.initExtra = ''
    eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
  '';

  services.lorri.enable = true;
}
