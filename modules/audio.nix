{ config, pkgs, machine, ... }:

if machine.audio.enable then {
  # save the sound card state on shutdown
  sound.enable = true;

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
    extraConfig = if machine.bluetooth.enable then ''
      unload-module module-bluetooth-policy
      load-module module-bluetooth-policy auto_switch=2
      load-module module-switch-on-connect
    '' else "";  # reload with auto_switch=2 to make the module-bluetooth-policy switch to headset policy when an audio input stream appears
  };
} else {}
