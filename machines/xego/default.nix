{
  hostname = "xego";

  # UUID of the luks root partition
  luksRootUUID = "d62c89b0-55b9-44a9-8d25-5fb5762ba422";

  # Time zone this machine typically resides in
  timezone = "Europe/Berlin";

  # Machine users
  users = import ./users.nix;

  # System shell to use for all machine users including root. May be overriden per user via users.<user>.shell
  systemShell = import ./system-shell.nix;

  # Audio services on this machine
  audio = {
    enable = true;
  };

  # Bluetooth services on this machine
  bluetooth = {
    enable = true;
  };

  # Battery-management services on this machine
  batteryManagement = {
    enable = true;
  };

  # SSD optimizations on this machine
  # enable if NixOS is installed on an SSD drive
  ssdOptimizations = {
    enable = true;
  };

  # Game services on this machine
  games = {
    enable = false;
  };
}
