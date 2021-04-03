{ config, pkgs, ... }:

{
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      hplip
    ];
  };

  environment.systemPackages = with pkgs; [
    simple-scan
  ];
}
