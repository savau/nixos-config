let
  # Full user specification:
  # The attribute name corresponds to the username
  defaultUser = {
    # user id
    # TODO: make optional (use next free number if unspecified)
    id = 1000;

    # display name
    displayName = "Default User";

    # TODO: implement superuser flag

    # user permissions
    permissions = {
      # should this user be granted all permissions available on this machine?
      all = false;

      # additional user permissions by group name
      # possible options for this machine:
      # [
      #   "docker"
      #   "libvirtd"
      #   "systemd-journal"
      #   "vboxusers"
      # ];
      additional = [];
    };

    # default shell
    shell = ./system-shell.nix;
  };
  pkgs = import <nixpkgs> {};
in
{
  savau = {
    id = 1000;
    displayName = "Sarah Vaupel";
    permissions.all = true;
  };

  # for debugging purposes:
  #anneo = {
  #  id = 1042;
  #  displayName = "Anne Onymous";
  #  shell = null;
  #  permissions.additional = [
  #    "systemd-journal"
  #  ];
  #};
  #mlem = {
  #  id = 1043;
  #  displayName = "Mike Lembo";
  #  shell = pkgs.bash;
  #  permissions.additional = [
  #    "vboxusers"
  #    "libvirtd"
  #    "docker"
  #  ];
  #};
  #pleb = {
  #  id = 1044;
  #  displayName = "Unworthy Pleb";
  #};
}
