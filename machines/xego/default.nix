{
  # TODO: remove, use directory name instead
  hostname = "xego";

  # UUID of the luks root partition
  # TODO: add more customization, i.e. option to disable LUKS all together
  luksRootUUID = "d62c89b0-55b9-44a9-8d25-5fb5762ba422";

  # time zone this machine typically resides in
  timezone = "Europe/Berlin";

  # users on this machine
  users = import ./users.nix;

  # system shell to use for all users on this machine including root
  # can be overriden per user via users.<username>.shell
  systemShell = import ./system-shell.nix;

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
    enable = false;
  };

  # configuration options for SSD optimizations
  ssdOptimizations = {
    enable = true;
  };
}
