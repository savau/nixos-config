{ config, pkgs, machine, ... }:

{
  time.timeZone = machine.timezone;
}
