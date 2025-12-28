{
  lib,
  flake-parts-lib,
  ...
}:
{
  # currently, there's no nix-darwin module for flake-parts,
  # so we have to manually add flake.darwinConfigurations

  options = {
    flake = flake-parts-lib.mkSubmoduleOptions {
      darwinConfigurations = lib.mkOption {
        type = lib.types.lazyAttrsOf lib.types.raw;
        default = { };
      };
    };
  };
}
