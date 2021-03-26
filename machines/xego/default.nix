{
  hostname = "xego";

  # UUID of the luks root partition
  luksRootUUID = "fd90341e-768c-43c8-b725-855d71ea7722";

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
}
