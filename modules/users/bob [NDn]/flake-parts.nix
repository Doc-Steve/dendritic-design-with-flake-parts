{
  inputs,
  ...
}:
{
  flake.homeConfigurations = inputs.self.lib.mkHomeManager "x86_64-linux" "bob";
}
