{
  inputs,
  ...
}:
{
  flake.modules.darwin.macbook = {
    imports = with inputs.self.modules.darwin; [
      bob
    ];

    home-manager.users.bob = {
      ###
    };
  };
}
