{ config, pkgs, ... }:

{
  console = {
    font = "lat9w-16";
    keyMap = "us";
  };

  i18n = {
    defaultLocale = "en_DK.UTF-8";
  };

  environment.systemPackages = with pkgs; [
    aspell
    aspellDicts.en
    aspellDicts.de
  ];
}
