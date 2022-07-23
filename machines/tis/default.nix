{ pkgs, ... }:

{
  # configuration options for Linux Unified Key Setup (LUKS) disk encryption
  luks = {
    # options for full disk encryption
    fullDiskEncryption = {
      enable = true;

      # LUKS root partition
      root = {
        uuid = "783b3e03-0784-4ef6-bfb1-ce51c6e93fc0";
      };
    };
    # TODO: implement options for partial disk encryption
  };

  # system shell to use for all users on this machine including root
  # can be overriden per user via users.<username>.shell
  systemShell = pkgs.zsh;

  # the physical keyboard layout on this machine
  keyboardLayout = {
    layout = "de,us";
    xkbOptions = "grp:rctrl_rshift_toggle";
  };

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
