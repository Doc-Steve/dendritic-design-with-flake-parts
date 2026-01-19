{
  inputs,
  ...
}:
{
  flake.modules.darwin.determinate = {
    imports = [ inputs.determinate.darwinModules.default ];
    nix.enable = false; # Determinate Nix handles the Nix configuration
  };
}
