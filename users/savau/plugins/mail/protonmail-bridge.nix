{ lib, pkgs, home, ... }:

{
  home.packages = with pkgs; [
    protonmail-bridge
  ];

  services.gnome-keyring.enable = true;

  systemd.user.services.protonmail-bridge = {
    Unit.Description = "Protonmail Bridge";
    Unit.After = [ "network.target" ];
    Service.ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge --log-level info --noninteractive";
    Service.Environment = "PATH=${pkgs.gnome3.gnome-keyring}/bin:$PATH";
    Service.Restart = "always";
    Install.WantedBy = [ "default.target" ];
  };
}
