{ config, pkgs, ... }:

{
  # Save the sound card state on shutdown
  sound.enable = true;

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
  };
}
