# TODO: use user type with permission defaults
let
  pkgs = import <nixpkgs> {};
in
{
  savau = {
    id = 1000;
    displayName = "Sarah Vaupel";
    shell = null;
    permissions = {
      all = true;
      wheel = true;
      systemd-journal = true;
      vboxusers = false;
      libvirtd = false;
      docker = false;
    };
  };

  # for debugging purposes:
  #anneo = {
  #  id = 1042;
  #  displayName = "Anne Onymous";
  #  shell = null;
  #  permissions = {
  #    all = false;
  #    wheel = false;
  #    systemd-journal = true;
  #    vboxusers = false;
  #    libvirtd = false;
  #    docker = false;
  #  };
  #};
  #mlem = {
  #  id = 1043;
  #  displayName = "Mike Lembo";
  #  shell = pkgs.bash;
  #  permissions = {
  #    all = false;
  #    wheel = false;
  #    systemd-journal = false;
  #    vboxusers = true;
  #    libvirtd = true;
  #    docker = true;
  #  };
  #};
  #pleb = {
  #  id = 1044;
  #  displayName = "Unworthy Pleb";
  #  shell = null;
  #  permissions = {
  #    all = false;
  #    wheel = false;
  #    systemd-journal = false;
  #    vboxusers = false;
  #    libvirtd = false;
  #    docker = false;
  #  };
  #};
}
