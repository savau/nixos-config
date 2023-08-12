{ lib, pkgs, home, ... }:

{
  home.packages = [ pkgs.direnv ];

  programs.bash.initExtra = ''
    eval "$(${pkgs.direnv}/bin/direnv hook bash)"
  '';
  programs.zsh.initExtra = ''
    eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
  '';

  services.lorri.enable = true;
}
