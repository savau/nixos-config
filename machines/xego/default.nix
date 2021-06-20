{
  # TODO: remove, use directory name instead
  hostname = "xego";

  # UUID of the luks root partition
  # TODO: add more customization, i.e. option to disable LUKS all together
  luksRootUUID = "d62c89b0-55b9-44a9-8d25-5fb5762ba422";

  timezone = "Europe/Berlin";

  users = import ./users.nix;

  # system shell to use for all users on this machine including root
  # can be overriden per user via users.<username>.shell
  systemShell = import ./system-shell.nix;

  audio = {
    enable = true;
  };

  bluetooth = {
    enable = true;
  };

  batteryManagement = {
    enable = true;
  };

  ssdOptimizations = {
    enable = true;
  };

  games = {
    enable = false;
  };
}
