{
  flake.modules.networkInterface.subnet-B = {
    ipv6.routes = [
      {
        address = "2001:1470:fffd:2099::";
        prefixLength = 64;
        via = "fdfd:b3f1::1";
      }
    ];
    ipv4.routes = [
      {
        address = "192.168.3.0";
        prefixLength = 24;
        via = "192.168.2.1";
      }
    ];
  };
}
