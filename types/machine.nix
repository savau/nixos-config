{
  types.machine = mkOptionType {
    name = "machine";
    description = "Attribute set containing all information required to create a machine-specific NixOS configuration. Required attributes: hostname :: str, timezone :: str, systemShell :: package, users :: attrsOf users.";

    check = x: true; # TODO: check for attrs and required attributes

    merge = loc: defs: {};  # TODO: merge attributes or inherit from attrs merge
  };
}
