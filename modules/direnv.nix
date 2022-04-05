{ config, pkgs, lib, ... }:

# TODO: implement machine switch?
{
  environment.systemPackages = [ pkgs.direnv ];

  programs = {
    bash.interactiveShellInit = ''
      eval "$(${pkgs.direnv}/bin/direnv hook bash)"
    '';
    zsh.interactiveShellInit = ''
      eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
    '';
  };

  services.lorri.enable = true;
}
