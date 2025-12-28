{
  inputs,
  ...
}:
{
  flake.modules.homeManager."bobStandalone" = {
    imports = with inputs.self.modules.homeManager; [
      bob
      impermanence # it's not included by default, because of missing Darwin implementation
    ];
    nixpkgs.config.allowUnfree = true;
  };
}
