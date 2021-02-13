{ config, pkgs, ... }:

{
  console = {
    font = "lat9w-16";
    keyMap = "us";
  };

  i18n = {
    defaultLocale = "en_DK.UTF-8";
    supportedLocales = [
      "en_DK.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "en_GB.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"
    ];
  };

  environment.systemPackages = with pkgs; [
    aspell
    aspellDicts.en
    aspellDicts.de
  ];
}
