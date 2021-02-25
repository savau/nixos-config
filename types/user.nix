{
  types = rec {
    userPermissions = mkOptionType {
      name = "userPermissions";
      description = "Attribute set containing information about permissions to grant a user (i.e. which groups the user should be added to). Required attributes: none. Optional attributes: all :: bool (whether to add the user to every available group, i.e. overriding specific permissions; default: false), audio :: bool (default: true), video :: bool (default: true), networkmanager :: bool (default: true), wheel :: bool (default: false), systemd-jounal :: bool (default: false), vboxusers :: bool (default: false), libvirtd :: bool (default: false), docker :: bool (default: false).";

      check = x: true; # TODO: check for attrs and required attributes

      merge = loc: defs: {};  # TODO: merge attributes or inherit from attrs merge
    };

    user = mkOptionType {
      name = "user";
      description = "Attribute set containing all information required to create a user. Required attributes: id :: int. Optional attributes: displayName :: str (defaults to attribute key), shell :: package (default: null, in this case the user will use the machine's systemShell), permissions :: userPermissions (default: {}, in this case the user will be granted basic system usage permissions only, refer to the documentation of userPermissions for further details).";

      check = x: true; # TODO: check for attrs and required attributes

      merge = loc: defs: {};  # TODO: merge attributes or inherit from attrs merge
    };
  };
}
