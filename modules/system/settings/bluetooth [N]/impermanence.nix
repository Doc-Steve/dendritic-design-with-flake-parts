{ ... }:
{

  flake.modules.nixos.bluetooth = {
    environment.persistence."/persistent" = {
      directories = [
        "/var/lib/bluetooth"
      ];
    };
  };
}
