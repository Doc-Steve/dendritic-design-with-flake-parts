{
  inputs,
  ...
}:
{
  flake.modules.nixos.impermanence =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
      imports = [
        inputs.impermanence.nixosModules.impermanence
      ];
      options = {
        environment.persistence-activation = {
          enable = lib.mkOption {
            description = "create missing enable option for impermanence";
            default = true;
            type = lib.types.bool;
          };
        };
      };
      config =
        let
          isDisabled = !config.environment.persistence-activation.enable;
        in
        {
          home-manager.sharedModules = [
            inputs.self.modules.homeManager.impermanence
            { home.persistence = lib.mkIf isDisabled (lib.mkForce { }); }
          ];
          environment.persistence = lib.mkIf isDisabled (lib.mkForce { });
        };
    };

  flake.modules.homeManager.impermanence = {
    imports = [ inputs.impermanence.homeManagerModules.impermanence ];
  };

  flake.modules.darwin.impermanence =
    { lib, ... }:
    {
      # define dummy persistence option in home-manager because of missing darwin implementation

      config = {
        home-manager.sharedModules = [
          {
            options.home.persistence = lib.mkOption {
              type = lib.types.attrsOf lib.types.unspecified;
            };
          }
        ];
      };
    };
}
