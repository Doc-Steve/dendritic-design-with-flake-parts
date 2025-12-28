{
  flake.modules.nixos.iperf = {
    services.iperf3 = {
      enable = true;
      openFirewall = true;
    };
  };
}
