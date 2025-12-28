{
  inputs,
  self,
  ...
}:
{
  flake.modules.nixos.secrets =
    { pkgs, ... }:
    {
      imports = [
        inputs.agenix.nixosModules.default
      ];
      environment.systemPackages = [ inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default ];
    };

  flake.modules.darwin.secrets =
    { pkgs, ... }:
    {
      imports = [
        inputs.agenix.darwinModules.default
      ];
      environment.systemPackages = [ inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default ];
    };

  flake.modules.homeManager.secrets =
    { pkgs, ... }:
    {
      imports = [
        inputs.agenix.homeManagerModules.default
      ];
    };

}
