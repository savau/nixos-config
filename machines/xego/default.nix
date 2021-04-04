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

  # Enables bluetooth services on this device
  bluetoothEnabled = true;

  # Enables battery-management services on this device
  isLaptop = true;

  # Enables SSD optimizations (enable if NixOS is installed on an SSD drive)
  ssdOptimized = true;

  # Enables game services on this device
  gameEnabled = false;
}
