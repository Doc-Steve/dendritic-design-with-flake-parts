{
  inputs,
  withSystem,
  ...
}:
{

  flake.modules.generic.pkgs-by-name =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [
        (final: _prev: {
          unstable = import inputs.nixpkgs-unstable {
            inherit (final) config;
            system = pkgs.stdenv.hostPlatform.system;
          };
        })
        inputs.self.overlays.default
      ];
    };

}
