{
  flake.modules.networkInterface.subnet-A = {
    ipv6.routes = [
      {
        address = "2001:1470:fffd:2098::";
        prefixLength = 64;
        via = "fdfd:b3f0::1";
      }
    ];
    ipv4.routes = [
      {
        address = "192.168.2.0";
        prefixLength = 24;
        via = "192.168.1.1";
      }
    ];
  };
}
