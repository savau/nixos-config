let
  pkgs = import <nixpkgs> {};
in
{
  savau = {
    id = 1000;
    displayName = "Sarah Vaupel";
    shell = null;
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
  #  shell = null;
  #};
}
