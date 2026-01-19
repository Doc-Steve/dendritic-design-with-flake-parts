{
  inputs,
  ...
}:
{
  flake.modules.darwin.macbook = {
    imports = with inputs.self.modules.darwin; [
      alice
    ];

    home-manager.users.alice = {
      ###
    };
  };
}
