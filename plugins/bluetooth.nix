{ config, pkgs, machine, ... }:

{
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Reload pulseaudio bluetooth policy module with auto_switch=2 to switch to headset policy when an audio input stream appears
  hardware.pulseaudio.extraConfig = ''
    unload-module module-bluetooth-policy
    load-module module-bluetooth-policy auto_switch=2
    load-module module-switch-on-connect
  '';
}
