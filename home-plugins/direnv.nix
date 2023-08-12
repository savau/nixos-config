{ lib, pkgs, home, ... }:

{
  home.packages = [ pkgs.direnv ];

  programs.bash.interactiveShellInit = ''
    eval "$(${pkgs.direnv}/bin/direnv hook bash)"
  '';
  programs.zsh.interactiveShellInit = ''
    eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
  '';

  services.lorri.enable = true;
}
