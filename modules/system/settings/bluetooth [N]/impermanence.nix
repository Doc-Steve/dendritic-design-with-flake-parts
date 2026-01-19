{
  inputs,
  ...
}:
{
  flake.modules.nixos.bluetooth =
    { config, ... }:
    {
      environment = inputs.self.lib.mkIfPersistence config {
        persistence."/persistent" = {
          directories = [
            "/var/lib/bluetooth"
          ];
        };
      };
    };
}
