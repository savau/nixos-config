{ config, pkgs, machine, ... }:

{
  hardware.bluetooth.enable = machine.bluetoothEnabled;
  services.blueman.enable = machine.bluetoothEnabled;
}
