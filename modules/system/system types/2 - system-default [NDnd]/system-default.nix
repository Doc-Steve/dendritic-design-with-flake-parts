{
  inputs,
  ...
}:
{
  # import all essential nix-tools which which are used in all modules of specific class

  flake.modules.nixos.system-default = {
    imports =
      with inputs.self.modules.nixos;
      [
        system-minimal
        home-manager
        secrets
      ]
      ++ [ inputs.self.modules.generic.systemConstants ];
  };

  flake.modules.darwin.system-default = {
    imports =
      with inputs.self.modules.darwin;
      [
        system-minimal
        determinate
        home-manager
        homebrew
        secrets
      ]
      ++ [ inputs.self.modules.generic.systemConstants ];
  };

  # impermanence is not added by default to home-manager, because of missing Darwin implementation
  # for linux home-manager stand-alone configurations it has to be added manualy

  flake.modules.homeManager.system-default = {
    imports =
      with inputs.self.modules.homeManager;
      [
        system-minimal
        secrets
      ]
      ++ [ inputs.self.modules.generic.systemConstants ];
  };
}
