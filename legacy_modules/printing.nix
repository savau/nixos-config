{ config, pkgs, ... }:

{
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      hplip
    ];
  };

  hardware.sane = {
    enable = true;
    extraBackends = with pkgs; [
      hplipWithPlugin
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  environment.systemPackages = with pkgs; [
    simple-scan
  ];
}
