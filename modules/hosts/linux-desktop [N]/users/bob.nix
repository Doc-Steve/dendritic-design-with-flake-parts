{
  inputs,
  ...
}:
{
  flake.modules.nixos.linux-desktop = {
    imports = with inputs.self.modules.nixos; [
      bob
    ];

    home-manager.users.bob = {
      ###
    };
  };
}
