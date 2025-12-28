{
  inputs,
  ...
}:
{
  flake.modules.nixos.homeserver = {
    imports = with inputs.self.modules.nixos; [
      eve
    ];

    home-manager.users.eve = {
      ###
    };
  };
}
