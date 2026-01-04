{
  lib,
  ...
}:
{
  # factory: storage for factory aspect functions

  options.flake.factory = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };
}
