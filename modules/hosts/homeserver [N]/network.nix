{ self, lib, ... }:
{
  flake.modules.nixos.homeserver = {
    networking.interfaces."enp86s0" =
      with self.modules.networkInterface;
      lib.mkMerge [
        subnet-A
        subnet-B
        {
          ipv4.addresses = [
            {
              address = "10.0.0.1";
              prefixLength = 16;
            }
          ];
          ipv6.addresses = [
            {
              address = "2001:1470:fffd:2098::e006";
              prefixLength = 64;
            }
          ];
        }
      ];
  };
}
