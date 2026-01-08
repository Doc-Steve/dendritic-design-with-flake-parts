{
  inputs,
  ...
}:
{
  flake.modules.homeManager."bobStandalone" = {
    imports = with inputs.self.modules.homeManager; [
      bob
    ];
    nixpkgs.config.allowUnfree = true;
  };
}
