{ pkgs, ... }:

{
  # configuration options for Linux Unified Key Setup (LUKS) disk encryption
  luks = {
    # options for full disk encryption
    fullDiskEncryption = {
      enable = true;

      # LUKS root partition
      root = {
        uuid = "869d3b66-b638-48cf-aee5-594cc5de9b4b";
      };
    };
    # TODO: implement options for partial disk encryption
  };

  # system shell to use for all users on this machine including root
  # can be overriden per user via users.<username>.shell
  systemShell = pkgs.zsh;

  # time zone this machine typically resides in
  timezone = "Europe/Berlin";

  # users on this machine
  users = import ./users.nix;


  # configuration options for audio services
  audio = {
    enable = true;
  };

  # configuration options for battery management and optimization services
  batteryManagement = {
    enable = true;
  };

  # configuration options for bluetooth services
  bluetooth = {
    enable = true;
  };

  # configuration options for game services
  games = {
    enable = true;
  };

  # configuration options for SSD optimizations
  ssdOptimizations = {
    enable = true;
  };
}
