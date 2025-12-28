{
  inputs,
  ...
}:
{
  # import all essential nix-tools which which are used in all modules of specific class

  flake.modules.nixos.system-essential = {
    imports =
      with inputs.self.modules.nixos;
      [
        system-default
        home-manager
        impermanence
        secrets
      ]
      ++ [ inputs.self.modules.generic.systemConstants ];
  };

  flake.modules.darwin.system-essential = {
    imports =
      with inputs.self.modules.darwin;
      [
        system-default
        determinate
        home-manager
        homebrew
        impermanence
        secrets
      ]
      ++ [ inputs.self.modules.generic.systemConstants ];
  };

  # impermanence is not added by default to home-manager, because of missing Darwin implementation
  # for linux home-manager stand-alone configurations it has to be added manualy

  flake.modules.homeManager.system-essential = {
    imports =
      with inputs.self.modules.homeManager;
      [
        system-default
        secrets
      ]
      ++ [ inputs.self.modules.generic.systemConstants ];
  };
}
